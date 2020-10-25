import 'package:flutter/material.dart';
import 'package:flutter_photo_share/common/utils/font_util.dart';
import 'package:flutter_photo_share/localization/my_l10n.dart';
import 'package:flutter_photo_share/service/account_service.dart';
import 'package:flutter_photo_share/ui/account/login_page.dart';
import 'package:flutter_photo_share/ui/activity/activity_page.dart';

import '../../main.dart';
import '../post_feed/post_feed_page.dart';
import '../account/profile_page.dart';
import '../upload/upload_page.dart';

class HomePage extends StatefulWidget {
  static final String ROUTE = 'home_page';
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  PageController _pageController;

  String _getPageTitle() {
    String key;
    switch (_page) {
      case 0:
        key = 'main.title';
        break;
      case 1:
        key = 'smile_wall.title';
        break;
      case 2:
        key = 'share.title';
        break;
      case 3:
        key = 'me.title';
        break;
      default:
        break;
    }
    return MyLocalizations.of(context).get(key);
  }

  @override
  Widget build(BuildContext context) {
    return (AccountService.googleSignIn().currentUser == null ||
        currentUserModel == null)
        ? LoginPage()
        : Scaffold(
      appBar: AppBar(
        title: FontUtil.makeTitleByString(_getPageTitle()),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: PageView(
          children: [
            Container(
              color: Colors.white,
              child: PostFeedPage(),
            ),
            Container(color: Colors.white, child: ActivityPage()),
            Container(
              color: Colors.white,
              child: Uploader(),
            ),
            // Container(
            //     color: Colors.white, child: CustomScrollviewDemo()),
            Container(
              color: Colors.white,
              child: ProfilePage(
                userId: AccountService.googleSignIn().currentUser.id,
              ),
            )
          ],
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Row(
          children: [
            Container(
              child: Icon(Icons.home,
                  color: (_page == 0) ? Colors.black : Colors.grey),
            ),
            Container(
              child: Icon(Icons.home,
                  color: (_page == 1) ? Colors.black : Colors.grey),
            ),
            Container(
              child: Icon(Icons.home,
                  color: (_page == 2) ? Colors.black : Colors.grey),
            ),
            Container(
              child: Icon(Icons.home,
                  color: (_page == 3) ? Colors.black : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    //Animating Page
    _pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}