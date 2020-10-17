import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_photo_share/ui/demo/custom_scroll_view_demo.dart';
import 'package:flutter_photo_share/ui/demo/demo_page.dart';
import 'package:flutter_photo_share/ui/demo/random_size_demo.dart';
import 'package:flutter_photo_share/ui/demo/variable_size_demo.dart';
import 'package:flutter_photo_share/ui/startup/user_guidence_page.dart';

import 'common/utils/app_util.dart';
import 'common/utils/preferences.dart';
import 'config/route.dart';
import 'localization/my_l10n_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();
  await AppUtil.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String startupRoute = DemoPage.ROUTE;
    if(AppUtil.isFirstRun()){
      startupRoute = UserGuidencePage.ROUTE;
    }
    return MaterialApp(
        title: 'Oranda',
        initialRoute: startupRoute,
        routes: Routes.getRoute(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          MyLocalizationDelegate()
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('zh', 'CN'),
        ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DemoPage()
    );
  }
}

