import 'package:be_healthy_delivery_app/generated/l10n.dart';
import 'package:be_healthy_delivery_app/utils/colors.dart';
import 'package:be_healthy_delivery_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var etName = TextEditingController();
  var etEmail = TextEditingController();
  var etPhoneNumber = TextEditingController();
  var etGender = TextEditingController();
  int compId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image(
              image: AssetImage('${BASE_IMAGE_PATH}bottom_circles.png'),
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage('${BASE_IMAGE_PATH}logo.png'),
              height: 100.0,
              width: 100.0,
            ),
          ),
          Positioned(
            top: 110,
            right: 8,
            left: 8,
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: getUserInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(S
                                .of(context)
                                .name + ':'),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey)),
                            child: EditableText(
                              cursorColor: kOrangeMaterialColor,
                              controller: etName,
                              style: TextStyle(color: kOrangeMaterialColor),
                              focusNode: FocusNode(),
                              backgroundCursorColor: kWhiteColor,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(S
                                .of(context)
                                .email + ':'),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey)),
                            child: EditableText(
                              cursorColor: kOrangeMaterialColor,
                              controller: etEmail,
                              style: TextStyle(color: kOrangeMaterialColor),
                              focusNode: FocusNode(),
                              backgroundCursorColor: kWhiteColor,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(S
                                .of(context)
                                .phone_number + ':'),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey)),
                            child: EditableText(
                              cursorColor: kOrangeMaterialColor,
                              controller: etPhoneNumber,
                              style: TextStyle(color: kOrangeMaterialColor),
                              focusNode: FocusNode(),
                              backgroundCursorColor: kWhiteColor,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(S
                                .of(context)
                                .gender + ':'),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey)),
                            child: EditableText(
                              cursorColor: kOrangeMaterialColor,
                              controller: etGender,
                              style: TextStyle(color: kOrangeMaterialColor),
                              focusNode: FocusNode(),
                              backgroundCursorColor: kWhiteColor,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Align(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: kOrangeMaterialColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                              ),
                              child: Text(S.of(context).update,
                                style: TextStyle(color: kWhiteColor),),
                              onPressed: () async {
                                await updateProfile();
                              },),
                            alignment: Alignment.center,
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
        ]),
      ),
    );
  }

  Future getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    etName.text = prefs.getString(COMPANY_NAME);
    etEmail.text = prefs.getString(EMAIL);
    etPhoneNumber.text = prefs.getString(PHONE_NUMBER);
    etGender.text = prefs.getString(GENDER);
    compId = prefs.getInt(COMP_ID);
  }

  Future updateProfile() async {
    // var response = await ApiRequests.updateProfile(
    //     etName.text, compId, etEmail.text, etPhoneNumber.text, etGender.text);
    // if (response.success) {
    //   ViewUtils.showSuccessToast(response.message);
    // } else {
    //   ViewUtils.showErrorToast(response.message);
    // }
  }
}