import 'package:common/core/presentation/widgets/platform_builder.dart';
import 'package:common/features/blogs/presentation/screens/listing_page/blog_listing_app_view.dart';
import 'package:common/features/blogs/presentation/screens/listing_page/blog_listing_desktop_view.dart';
import 'package:flutter/material.dart';

class BlogVideosListingScreen extends StatelessWidget {
  final Map<String, dynamic>? params;
  const BlogVideosListingScreen({super.key, this.params});

  @override
  Widget build(BuildContext context) {
    return PlatformBuilder(
      mWebView: BlogVideosListingAppView(params: params),
      mobileAppView: BlogVideosListingAppView(params: params),
      desktopView: const BlogListingDesktopView(),
    );
  }
}
