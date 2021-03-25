import 'package:be_healthy_delivery_app/components/rounded_fill_button.dart';
import 'package:be_healthy_delivery_app/generated/l10n.dart';
import 'package:be_healthy_delivery_app/utils/global_variables.dart';
import 'package:be_healthy_delivery_app/utils/route_names.dart';
import 'package:be_healthy_delivery_app/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isProgressBarVisible = false;
  GlobalKey<FormState> _globalFormKey = new GlobalKey<FormState>();
  String email = '';
  String phoneNumber = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    final screenSizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            S.of(context).sign_up,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: ModalProgressHUD(
            inAsyncCall: isProgressBarVisible,
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
                  children: [
                    SizedBox(
                      height: screenSizeHeight * 0.16,
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            // BoxShadow(
                            //     color: Theme.of(context).hintColor.withOpacity(0.2),
                            //     offset: Offset(0, 10),
                            //     blurRadius: 20)
                          ]),
                      child: Form(
                        key: _globalFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              validator: (input) => !input.contains("@")
                                  ? S.of(context).email_id_should_be_valid
                                  : null,
                              // initialValue : "mujahidlinez@gmail.com",
                              keyboardType: TextInputType.emailAddress,
                              decoration: new InputDecoration(
                                  hintText: S.of(context).email,
                                  fillColor: Colors.transparent,
                                  filled: true),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return S.of(context).please_enter_phone_number;
                                }
                                return null;
                              },
                              // initialValue : "03218565452",
                              onChanged: (value) {
                                setState(() {
                                  phoneNumber = value;
                                });
                              },
                              keyboardType: TextInputType.phone,
                              decoration: new InputDecoration(
                                  hintText: S.of(context).mobile_number,
                                  fillColor: Colors.transparent,
                                  filled: true),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              // initialValue : "12345",
                              obscureText: true,
                              obscuringCharacter: "*",
                              validator: (input) => input.length <= 4
                                  ? S.of(context).password_should_be_greater_than_5
                                  : null,
                              decoration: new InputDecoration(
                                  hintText: S.of(context).password,
                                  fillColor: Colors.transparent,
                                  filled: true),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              obscureText: true,
                              // initialValue : "12345",
                              obscuringCharacter: "*",
                              onChanged: (value) {
                                setState(() {
                                  confirmPassword = value;
                                });
                              },
                              validator: (input) => input.length <= 4
                                  ? S.of(context).password_should_be_greater_than_5
                                  : null,
                              decoration: new InputDecoration(
                                  hintText: S.of(context).re_enter_password,
                                  fillColor: Colors.transparent,
                                  filled: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RoundedFilledButton(
                            title: S.of(context).w_continue,
                            onPressed: () async {
                              if (_globalFormKey.currentState.validate()) {
                                if (password == confirmPassword){
                                  // obtain shared preferences
                                  final prefs = await SharedPreferences.getInstance();
                                  prefs.setString('email', email);
                                  prefs.setString('password', password);
                                  prefs.setString('phoneNumber', phoneNumber);
                                  Navigator.pushNamed(context, SIGN_UP_SCREEN_1);
                                  //   Navigator.push(
                                  //
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => SignUpPage2(email: email,password: password,phoneNumber: phoneNumber),
                                  //     ),
                                  //   );
                                }else{
                                  ViewUtils.showToast(S.of(context).password_does_not_match);
                                }
                              }
                            },
                          ),
                          // RoundedFilledButton(
                          //   title: S.of(context).sign_in_with_facebook,
                          //   onPressed: () async {
                          //
                          //   },
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]
            )
        )
    );
  }
}