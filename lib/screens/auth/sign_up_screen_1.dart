import 'package:be_healthy_delivery_app/components/rounded_fill_button.dart';
import 'package:be_healthy_delivery_app/generated/l10n.dart';
import 'package:be_healthy_delivery_app/utils/global_variables.dart';
import 'package:be_healthy_delivery_app/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen1 extends StatefulWidget {
  @override
  _SignUpScreen1State createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  bool isProgressBarVisible = false;
  GlobalKey<FormState> _globalFormKey = new GlobalKey<FormState>();
  var selectedState = "State";
  String selectedGender;
  var selectedStateId = "";
  var selectedCountry = "Kuwait";
  var fullName = '';
  var stateId = 0;

  String email;
  String password;
  String phoneNumber;


  @override
  void initState() {
    selectedGender = 'Male'; //S.of(context).male;
    // TODO: implement initState
    super.initState();
    getStates(context);
    getPreviousScreenData();
  }

  getPreviousScreenData() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email') ?? '';
    password = prefs.getString('password') ?? '';
    phoneNumber = prefs.getString('phoneNumber') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            S
                .of(context)
                .sign_up,
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
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        margin: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                        ),
                        child: Form(
                          key: _globalFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  setState(() {
                                    fullName = value;
                                  });
                                },
                                decoration: new InputDecoration(
                                    hintText: S
                                        .of(context)
                                        .full_name,
                                    fillColor: Colors.transparent,
                                    filled: true),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              DropdownButtonFormField<String>(
                                decoration: new InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true),
                                value: selectedCountry,
                                items: ['Kuwait']
                                    .map((label) =>
                                    DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                    .toList(),
                                hint: Text(S
                                    .of(context)
                                    .country),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              // DropdownButtonFormField<String>(
                              //   decoration: new InputDecoration(
                              //       fillColor: Colors.transparent,
                              //       filled: true),
                              //   value: selectedState,
                              //   items: stateNames
                              //       .map((label) =>
                              //       DropdownMenuItem(
                              //         child: Text(label.toString()),
                              //         value: label,
                              //       ))
                              //       .toList(),
                              //   hint: Text('State'),
                              //   onChanged: (value) {
                              //     setState(() {
                              //       selectedState = value;
                              //       stateId = getStateId(value);
                              //       //ViewUtils.showToast( selectedState );
                              //     });
                              //   },
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              DropdownButtonFormField<String>(
                                decoration: new InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true),
                                value: selectedGender,
                                items: [S
                                    .of(context)
                                    .male, S
                                    .of(context)
                                    .female
                                ]
                                    .map((label) =>
                                    DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                    .toList(),
                                hint: Text(S
                                    .of(context)
                                    .gender),
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          RoundedFilledButton(
                            title: S
                                .of(context)
                                .sign_up,
                            onPressed: () async {
                              if (_globalFormKey.currentState.validate()) {
                                if (stateId != 0) {
                                  // getSignUp(context);
                                } else {
                                  ViewUtils.showErrorToast(S
                                      .of(context)
                                      .please_select_state);
                                }
                                //Navigator.pushNamed(context, LOG_IN_PAGE);
                                // Navigator.pushAndRemoveUntil(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => LoginPage()),
                                //   (Route<dynamic> route) => false,
                                // );
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ])));
  }

  // List<StatesModel> states;
  // List<String> stateNames = ['State'];

  Future<void> getStates(BuildContext context) async {
    // var response = await ApiRequests.deliveryStateGet();
    // print(response);
    // if(response.status == 200) {
    //   setState(() {
    //     states =  response.statesModel;
    //     if (states.length > 0){
    //       selectedState = states[0].stateName;
    //       stateId = states[0].stateID;
    //     }
    //     states.forEach((element) {
    //       stateNames.add(element.stateName);
    //     });
    //   });
    // }else{
    //   ViewUtils.showErrorToast(response.message);
    //   setState(() {
    //     isProgressBarVisible = false;
    //   });
    // }
  }
}
