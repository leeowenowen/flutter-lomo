import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_photo_share/common/constants/constants.dart';
import 'package:flutter_photo_share/common/utils/font_util.dart';
import 'package:flutter_photo_share/ui/demo/custom_scroll_view_demo.dart';
import 'package:flutter_photo_share/ui/demo/random_size_demo.dart';
import 'package:flutter_photo_share/ui/demo/variable_size_demo.dart';
import 'feed.dart';
import 'upload_page.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_page.dart';
import 'search_page.dart';
import 'activity_feed.dart';
import 'create_account.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;
import 'models/user.dart';
import 'service/account_service.dart';


final ref = Firestore.instance.collection(Constants.COLLECTION_USER);
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


User currentUserModel;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized(); // after upgrading flutter this is now necessary

  // enable timestamps in firebase
  Firestore.instance.settings().then((_) {
    print('[Main] Firestore timestamps in snapshots set');},
    onError: (_) => print('[Main] Error setting timestamps in snapshots')
  );
  AccountService.init();
  runApp(Orangda());
}



Future<Null> _setUpNotifications() async {
  if (Platform.isAndroid) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );

    _firebaseMessaging.getToken().then((token) {
      print("Firebase Messaging Token: " + token);

      Firestore.instance
          .collection(Constants.COLLECTION_USER)
          .document(currentUserModel.id)
          .updateData({"androidNotificationToken": token});
    });
  }
}

class Orangda extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orangda',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          buttonColor: Colors.pink,
          primaryIconTheme: IconThemeData(color: Colors.black)),
      home: HomePage(title: 'Orangda'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

PageController pageController;

class _HomePageState extends State<HomePage> {
  int _page = 0;
  bool triedSilentLogin = false;
  bool setupNotifications = false;

  Scaffold buildLoginPage() {
    return Scaffold(
      body: Container(child:Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 240.0),
          child: Column(
            children: <Widget>[
              FontUtil.makeBrand(),
              Padding(padding: const EdgeInsets.only(bottom: 100.0)),
              GestureDetector(
                onTap: login,
                child: Image.asset(
                  "assets/images/google_signin_button.png",
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

  @override
  Widget build(BuildContext context) {
    if (triedSilentLogin == false) {
      silentLogin(context);
    }

    if (setupNotifications == false && currentUserModel != null) {
      setUpNotifications();
    }

    return (AccountService.googleSignIn().currentUser == null || currentUserModel == null)
        ? buildLoginPage()
        :Scaffold(
            body: Container(
              child:PageView(
              children: [
                Container(
                  color: Colors.red,
                  child: Feed(),
                ),
                Container(color: Colors.white, child: VariableSizedDemo()),
                Container(
                  color: Colors.white,
                  child: Uploader(),
                ),
                Container(
                    color: Colors.white, child: CustomScrollviewDemo()),
                Container(
                    color: Colors.white,
                    child:ProfilePage(
                      userId: AccountService.googleSignIn().currentUser.id,
                    ),
                )
              ],
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: onPageChanged,
            ),
            ),
            bottomNavigationBar: CupertinoTabBar(
              backgroundColor: Colors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home,
                        color: (_page == 0) ? Colors.black : Colors.grey),
                    title: Container(height: 0.0),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search,
                        color: (_page == 1) ? Colors.black : Colors.grey),
                    title: Container(height: 0.0),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle,
                        color: (_page == 2) ? Colors.black : Colors.grey),
                    title: Container(height: 0.0),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.star,
                        color: (_page == 3) ? Colors.black : Colors.grey),
                    title: Container(height: 0.0),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person,
                        color: (_page == 4) ? Colors.black : Colors.grey),
                    title: Container(height: 0.0),
                    backgroundColor: Colors.white),
              ],
              onTap: navigationTapped,
              currentIndex: _page,
            ),
          );
  }

  void login() async {
    await AccountService.ensureLoggedIn(context);
    setState(() {
      triedSilentLogin = true;
    });
  }

  void setUpNotifications() {
    _setUpNotifications();
    setState(() {
      setupNotifications = true;
    });
  }

  void silentLogin(BuildContext context) async {
    await AccountService.silentLogin(context);
    setState(() {
      triedSilentLogin = true;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
