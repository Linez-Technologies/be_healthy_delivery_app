import 'package:be_healthy_delivery_app/components/rounded_fill_button.dart';
import 'package:be_healthy_delivery_app/generated/l10n.dart';
import 'package:be_healthy_delivery_app/utils/colors.dart';
import 'package:be_healthy_delivery_app/utils/global_variables.dart';
import 'package:be_healthy_delivery_app/utils/route_names.dart';
import 'package:be_healthy_delivery_app/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedLanguage;
  bool isProgressbarVisible = false;
  bool isOTPSent = false;
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  var textEmailController = TextEditingController();
  var textPasswordController = TextEditingController();
  var textOTPEmailController = TextEditingController();
  var textOTPCodeController = TextEditingController();
  String otpCode = '';
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isProgressbarVisible,
        child: Stack(children: [
          Container(
            //child: Image(image: AssetImage(BASE_IMAGE_PATH + 'bottom_circles.png'),),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(BASE_IMAGE_PATH + 'bottom_circles.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                //AspectRatio(
                // child:
                Container(
                  height: 100,
                  width: 150,
                  child: Image(image: AssetImage('${BASE_IMAGE_PATH}logo.png'),),
                ),
                // aspectRatio: 3.5,
                // ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(height: 15,),
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: textEmailController,
                          //validator: (input) => !input.contains("@")
                          //  ? "Email Id should be valid "
                          //  : null,
                          decoration: new InputDecoration(
                              hintText: S.of(context).e_mail_or_mobile_number,
                              fillColor: Colors.white,
                              filled: true),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        new TextFormField(
                          obscureText: true,
                          controller: textPasswordController,
                          obscuringCharacter: "*",
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                              hintText: S.of(context).password,
                              suffixIcon: TextButton(
                                onPressed: () {

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        Future.delayed(Duration(seconds: 1000), () {
                                          Navigator.of(context).pop(true);
                                        });
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.all(8.0),
                                          title: Text( isOTPSent ?
                                          S.of(context).enter_otp_sent_to_your_email  : S.of(context).enter_your_email,
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Container(
                                            height: 150,
                                            width: MediaQuery.of(context).size.width,
                                            child: Column(
                                                children: [
                                                  TextFormField(
                                                    keyboardType: isOTPSent ?  TextInputType.number : TextInputType.emailAddress,
                                                    controller:  isOTPSent ?  textOTPCodeController : textOTPEmailController,
                                                    decoration: new InputDecoration(
                                                        hintText:  isOTPSent ?  S.of(context).e_mail_or_mobile_number : 'Enter OTP',
                                                        fillColor: Colors.white,
                                                        filled: true),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  ElevatedButton(
                                                    child: Text(isOTPSent ? S.of(context).verify_otp : S.of(context).send_otp),
                                                    onPressed: () async {
                                                      if (isOTPSent){
                                                        otpCode == textOTPCodeController.text ?  ViewUtils.showToast(S.of(context).otp_matched): ViewUtils.showToast(S.of(context).invalid_code);

                                                      } else{
                                                        //textOTPEmailController.text = '';
                                                        sendOtp(context);
                                                        isOTPSent = false;
                                                      }
                                                    },
                                                  ),
                                                ]),

                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  S.of(context).forgot,
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RoundedFilledButton(
                          title: S.of(context).sign_in,
                          onPressed: () async {

                            Navigator.pushNamed(context, DASHBOARD_SCREEN);
                            setState(() {
                              // isProgressbarVisible = true;
                            });
                            bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(textEmailController.text);
                            if(emailValid) {
                              await login(context);
                            }else {
                              await loginWithPhone(context);
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 80),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: kOrangeMaterialColor,
                                    width: 2,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(30)),
                          ),

                          onPressed: () {
                            Navigator.pushNamed(context, SIGN_UP_SCREEN);
                          },
                          child: Text(
                            S.of(context).sign_up,
                            style: TextStyle(color: kOrangeMaterialColor),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // FlatButton(
                            //   padding: EdgeInsets.symmetric(
                            //       vertical: 12, horizontal: 20),
                            //   onPressed: () async{
                            //     // await _login();
                            //   },
                            //   child: Text(
                            //     S.of(context).sign_in_with_facebook,
                            //     style: TextStyle(
                            //         color: Colors.white, fontSize: 10),
                            //   ),
                            //   color: Color(0xFF94267b2),
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(30)),
                            // ),
                            ElevatedButton(
                              onPressed: () async{
                                _handleGoogleSignIn(context);
                              },
                              child: Text(
                                S.of(context).sign_in_with_google,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                              ),
                            ),
                          ],
                        ),
                        DropdownButtonFormField<String>(
                          icon: Icon(Icons.language, color: kOrangeMaterialColor,),
                          decoration: new InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,),
                          value: selectedLanguage,
                          items: ['English', 'Arabic']
                              .map((label) => DropdownMenuItem(
                            child: Text(label.toString()),
                            value: label,
                          ))
                              .toList(),
                          hint: Text(S.of(context).language),
                          onChanged: (value) async{
                            if(value == 'English'){
                              final prefs = await SharedPreferences.getInstance();
                              prefs.setString(SELECTED_LANGUAGE, 'en');
                              setState(() {
                                S.load(Locale('en'));
                                selectedLanguage = 'English';
                              });
                            }else if(value == 'Arabic'){
                              final prefs = await SharedPreferences.getInstance();
                              prefs.setString(SELECTED_LANGUAGE, 'ar');
                              setState(() {
                                S.load(Locale('ar'));
                                selectedLanguage = 'Arabic';
                              });
                            }
                          },
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void sendOtp(BuildContext context) async{}

  void _handleGoogleSignIn(BuildContext context) async{}

  login(BuildContext context) async{}

  loginWithPhone(BuildContext context) {}
}
