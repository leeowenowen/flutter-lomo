import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_photo_share/models/posts_repository.dart';
import 'package:flutter_photo_share/widgets/push_to_refresh_header.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import 'common/constants/constants.dart';
import 'image_post.dart';

class PostPage extends StatefulWidget{
  @override
  _PostPageState createState() => _PostPageState();

}

class _PostPageState extends State<PostPage>{
  PostRepository listSourceRepository = PostRepository(
    pageCount: 20,
    collection: Constants.COLLECTION_POSTS,
  );
  DateTime dateTimeNow;
  @override
  void initState() {
    super.initState();
   // _getSmileWallPosts();
    listSourceRepository.refresh().whenComplete(() {
      setState(() {
        dateTimeNow = DateTime.now();
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    listSourceRepository.dispose();
  }
  Future<bool> onRefresh() {
    return listSourceRepository.refresh().whenComplete(() {
      dateTimeNow = DateTime.now();
    });
  }
  @override
  Widget build(BuildContext context) {
    return PullToRefreshNotification(
      pullBackOnRefresh: false,
      maxDragOffset: maxDragOffset,
      armedDragUpCancel: false,
      onRefresh: onRefresh,
      child: LoadingMoreCustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: PullToRefreshContainer(
                    (PullToRefreshScrollNotificationInfo info) {
                  return PullToRefreshHeader(info, dateTimeNow);
                }),
          ),
          LoadingMoreSliverList<ImagePost>(
            SliverListConfig<ImagePost>(
              extendedListDelegate:
              const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                // crossAxisSpacing: 5,
                // mainAxisSpacing: 5,
              ),
              itemBuilder: buildItem,
              sourceList: listSourceRepository,
              padding: const EdgeInsets.all(5.0),
              lastChildLayoutType: LastChildLayoutType.foot,
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, ImagePost item, int index){
    return item;
  }
}