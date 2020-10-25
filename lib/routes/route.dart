import 'package:flutter/material.dart';
import 'package:flutter_photo_share/ui/account/login_page.dart';
import 'package:flutter_photo_share/ui/account/profile_page.dart';
import 'package:flutter_photo_share/ui/account/set_account_info_page.dart';
import 'package:flutter_photo_share/ui/comment/comment_page.dart';
import 'package:flutter_photo_share/ui/demo/custom_scroll_view_demo.dart';
import 'package:flutter_photo_share/ui/demo/demo_page.dart';
import 'package:flutter_photo_share/ui/demo/known_size_demo.dart';
import 'package:flutter_photo_share/ui/demo/random_size_demo.dart';
import 'package:flutter_photo_share/ui/demo/variable_size_demo.dart';
import 'package:flutter_photo_share/ui/home/home_page.dart';
import 'package:flutter_photo_share/ui/startup/user_guidence_page.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      DemoPage.ROUTE: (_) => DemoPage(),
      UserGuidencePage.ROUTE: (_) => UserGuidencePage(),
      CustomScrollviewDemo.ROUTE: (_) => CustomScrollviewDemo(),
      KnownSizedDemo.ROUTE: (_) => KnownSizedDemo(),
      RandomSizedDemo.ROUTE: (_) => RandomSizedDemo(),
      VariableSizedDemo.ROUTE: (_) => VariableSizedDemo(),
      LoginPage.ROUTE: (_) => LoginPage(),
      HomePage.ROUTE:(_)=>HomePage(),
      CommentPage.ROUTE:(_)=>CommentPage(),
      ProfilePage.ROUTE:(_)=>ProfilePage(),
      SetAccountInfoPage.ROUTE:(_)=>SetAccountInfoPage(),
    };
  }
}
