import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/platform_builder.dart';
import 'package:common/features/blogs/domain/blog_item_model.dart';
import 'package:common/features/blogs/presentation/screens/details_page/blog_detail_app_view.dart'
    if (dart.library.html) 'package:common/features/blogs/presentation/screens/details_page/blog_detail_mweb_view.dart';
import 'package:common/features/blogs/presentation/screens/details_page/blog_detail_desktop_view.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends HookWidget {
  final BlogItemData blogItemData;

  const BlogDetailScreen({super.key, required this.blogItemData});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        MoEngageService().trackEvent(
            eventName: MoEngageEventsConsts.horizontalEventsValue.truefinblogscreenviewed,
            product: ProductEvent.truefin,
            properties: {
              "source": "Blogs",
              "content_title": blogItemData.title,
              "views_count": blogItemData.views,
              "likes_count": blogItemData.likes,
              "comment_count": "0"
            });
      });
      return null;
    }, []);
    return PlatformBuilder(
      mWebView: BlogDetailViewWidget(blogItem: blogItemData),
      mobileAppView: BlogDetailViewWidget(blogItem: blogItemData),
      desktopView: const BlogDetailDesktopViewWidget(),
    );
  }
}
