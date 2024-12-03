import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/routing/global_navigation_utils.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/custom_snackbar.dart';
import 'package:common/env/env.dart';
import 'package:common/features/blogs/domain/blog_item_model.dart';
import 'package:common/features/blogs/infrastructure/blog_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:loader_overlay/loader_overlay.dart';

part 'blog_details_state_notifier.g.dart';

//provider that contains the html view height as the state
@riverpod
class BlogDetailViewStateNotifier extends _$BlogDetailViewStateNotifier {
  late InAppWebViewController inAppWebViewController;

  @override
  double build() {
    return 200.0;
  }

  String getFontUri(ByteData data, String mime) {
    final buffer = data.buffer;
    return Uri.dataFromBytes(
            buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
            mimeType: mime)
        .toString();
  }

  Future<void> setContent(String htmlContent) async {
    // Define the CSS for the Google Font
    const fontCss = '''
    @import url('https://fonts.googleapis.com/css2?family=Manrope:wght@400&display=swap');
    * {
      font-family: 'Manrope', sans-serif;
    }
  ''';
    final content = '''
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <style>
         $fontCss
        img {max-width: 100%; height: auto} 
        * {
            line-height: 28.8px;
            font-size: 16px;
        }
        .container {
            width: 100%;
        }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid; text-align: left; padding: 8px; min-width: 100px;}
        
    </style>
</head>
<body>
    <div class="container" id="_flutter_target_do_not_delete">
        <!-- Your HTML content -->
        $htmlContent
    </div>
</body>
</html>

                      ''';

    inAppWebViewController.loadData(data: content);
  }

  setContentHeight(double value) {
    state = value;
  }

  fetchBlogDetails(BlogItemData blogItemData, BuildContext context) async {
   // print("fetchBlogDetails called");
    context.loaderOverlay.show();
    final blogRepo = ref.read(getBlogRepositoryProvider);
    final result = await blogRepo.fetchBlogItemDetails(
        "${Env.opsPanelBaseUrlFromEnv}api/blogs/${blogItemData.categories?[0].slug}/${blogItemData.slug}");
    result.fold((l) {
     CustomSnackbarUtil.showSnackbar(l);
    }, (r) {
      setContent(r.data?.content ?? "");
    });
    context.loaderOverlay.hide();
  }
}
