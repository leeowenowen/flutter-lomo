import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_photo_share/common/utils/font_util.dart';
import 'package:flutter_photo_share/localization/my_l10n.dart';
import 'package:flutter_photo_share/service/account_service.dart';
import 'package:flutter_photo_share/ui/home/home_page.dart';

class LoginPage extends StatefulWidget {
  static final String ROUTE = 'login page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Future<void> initState() {
    super.initState();
    AccountService.silentLogin(context).then((logined) {
      if (!logined) {
        return;
      }
      gotoMainPage();
    });
  }

  void gotoMainPage(){
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HomePage.ROUTE, (route) => false);
  }

  void login() async {
    bool success = await AccountService.ensureLoggedIn(context);
    if(!success){
      //show error dialog here
      return;
    }
    gotoMainPage();
  }

  @override
  Widget build(BuildContext context) {
    String photoTheWorld =
        MyLocalizations.of(context).get('common.photo_the_world');
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Column(
              children: <Widget>[
                Stack(children: [
                  Container(
                    child: Image.asset('assets/logo.png', height: 300),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                      child: Container(
                        margin:EdgeInsets.only(top: 220),
                        child: FontUtil.makeBrand()),
                      )
                ]),

                SizedBox(
                  height: 30,
                ),
                Text(photoTheWorld,
                    style: const TextStyle(
                        fontFamily: "Fontdiner Swanky",
                        color: Colors.black,
                        fontSize: 20)),
                Padding(padding: const EdgeInsets.only(bottom: 100.0)),
                GestureDetector(
                  onTap: login,
                  child: Image.asset(
                    "assets/google_signin_button.png",
                    width: 225.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
