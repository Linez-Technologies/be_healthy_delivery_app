import 'package:be_healthy_delivery_app/generated/l10n.dart';
import 'package:be_healthy_delivery_app/screens/dashboard_screen.dart';
import 'package:be_healthy_delivery_app/utils/colors.dart';
import 'package:be_healthy_delivery_app/utils/global_variables.dart';
import 'package:be_healthy_delivery_app/utils/route_names.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String compName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DashboardScreen(
                  currentIndex: 0,
                );
              },
            ));
          },
        ),
        title: Text(
          S.of(context).settings,
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: PhysicalModel(
                  color: kOrangeMaterialColor,
                  shadowColor: kOrangeMaterialColor,
                  borderRadius: BorderRadius.circular(60),
                  elevation: 16.0,
                  shape: BoxShape.circle,
                  child: CircleAvatar(
                    backgroundImage:
                    AssetImage('${BASE_IMAGE_PATH}img_avatar.png'),
                    radius: 50.0,
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                compName == null ? "-----" : compName,
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: ListView(
              children: [
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  onTap: () {
                    // moveUpdateMealSelection(context);
                  },
                  leading: Icon(FontAwesomeIcons.utensils),
                  title: Text(S.of(context).change_package),
                  trailing: Icon(Icons.navigate_next),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return DashboardScreen(
                          currentIndex: 1,
                        );
                      },
                    ));
                  },
                  leading: Icon(FontAwesomeIcons.shoppingBasket),
                  title: Text(S.of(context).my_order),
                  trailing: Icon(Icons.navigate_next),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  onTap: () {
                    // Navigator.pushNamed(context, BILLING_ADDRESSES_PAGE);
                  },
                  leading: Icon(FontAwesomeIcons.mapMarkerAlt),
                  title: Text(S.of(context).address),
                  trailing: Icon(Icons.navigate_next),
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  onTap: () async {
                    changeLanguageDialog(context);
                  },
                  leading: Icon(Icons.language),
                  title: Text(S.of(context).language),
                  trailing: Icon(Icons.navigate_next),
                ),

                Divider(
                  color: Colors.black,
                ),
                // ListTile(
                //   onTap: (){
                //     Navigator.pushNamed(context, FAVOURITE_SCREEN);
                //   },
                //   leading: Icon(Icons.favorite_border),
                //   title: Text(S.of(context).wish_list),
                //   trailing: Icon(Icons.navigate_next),
                // ),
                // Divider(
                //   color: Colors.black,
                // ),
                ListTile(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await
                    prefs.setBool('isLoggedIn', false);
                    final GoogleSignIn _googleSignIn = GoogleSignIn();
                    await _googleSignIn.signOut();
                    Navigator.pushNamed(context, LOG_IN_SCREEN);
                  },
                  leading: Icon(Icons.logout),
                  title: Text(S.of(context).logout),
                  trailing: Icon(Icons.navigate_next),
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> changeLanguageDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Row(
              children: [
                Flexible(child: Text(S.of(context).change_language)),
              ],
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () async {
                  setState(() {
                    S.load(Locale('en', 'US'));
                  });
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString(SELECTED_LANGUAGE, 'en');
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    Text(S.of(context).english),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  setState(() {
                    S.load(Locale('ar'));
                  });
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString(SELECTED_LANGUAGE, 'ar');
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).arabic),
              ),
            ],
          );
        });
  }

}
