import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/enums/app_type.dart';
import 'package:common/core/presentation/utils/global_loading_indicator.dart';
import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:common/core/presentation/widgets/user_journey_app_bar_widget.dart';
import 'package:common/features/member_angel_common_constant/presentation/providers/member_angel_common_constant_provider.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/service_recommendation_and_rating/domain/entities/member_angel_rating_details_entity.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/providers/service_recommendation_and_rating_provider.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/widgets/service_recommendation_and_rating_form.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/widgets/service_recommendation_and_rating_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/consts/constant_app_strings.dart';

Future<void> showRatingRecommendationDialog(
  BuildContext context, {
  required MemberAngelRatingDetailsEntity detailsEntity,
  bool? canClose,
  Function()? onSubmit,
}) async {
  try {
    await showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(anim1),
            child: child,
          );
        },
        pageBuilder: (context, p1, p2) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: ServiceRecommendationAndRatingPage(
              detailsEntity: detailsEntity,
              canClose: canClose ?? false,
              onSubmit: onSubmit,
            ),
          );
        });
  } catch (_) {}
  // showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     isDismissible: false,
  //     useSafeArea: true,
  //     enableDrag: false,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
  //     backgroundColor: Colors.white,
  //     builder: (c) {
  //       return ServiceRecommendationAndRatingPage(
  //         detailsEntity: detailsEntity,
  //       );
  //     });
}

class ServiceRecommendationAndRatingPage extends HookConsumerWidget {
  final MemberAngelRatingDetailsEntity? detailsEntity;
  final bool canClose;
  final Function()? onSubmit;

  const ServiceRecommendationAndRatingPage({
    super.key,
    this.detailsEntity,
    this.canClose = true,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(partnerRecommendationAndRatingDataProvider);
    ref.watch(memberRecommendationAndRatingDataProvider);

    return WillPopScope(
      onWillPop: () async {
        if (canClose) {
          ref.read(
              sendIgnoreRatingProvider(appType: detailsEntity?.appType).future);
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: UserJourneyAppBarWidget(
          title: AppStrings.recommendationAndRating,
          showBackButton: canClose,
          bgColor: ColorUtilsV2.hex_FFFAED,
          onLeadingTap: () async {
            await ref.read(
                sendIgnoreRatingProvider(appType: detailsEntity?.appType)
                    .future);
            Navigator.pop(context);
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ServiceRecommendationAndRatingHeader(
                      detailsEntity: detailsEntity,
                      onRatingUpdate: (v) {
                        if (detailsEntity!.appType == AppType.partner) {
                          final partnerRecommendationAndRatingDataNotifier = ref
                              .read(partnerRecommendationAndRatingDataProvider
                                  .notifier);
                          partnerRecommendationAndRatingDataNotifier
                              .setRatingCount(v.toInt(),
                                  detailsEntity?.showQuestion ?? false);
                        } else {
                          final recommendationAndRatingDataNotifier = ref.read(
                              memberRecommendationAndRatingDataProvider
                                  .notifier);
                          recommendationAndRatingDataNotifier.setRatingCount(
                              v.toInt(), detailsEntity?.showQuestion ?? false);
                        }
                      },
                    ),
                    30.height,
                    ServiceRecommendationAndRatingForm(
                        detailsEntity: detailsEntity),
                  ],
                ),
              ),
            ),
            20.height,
            MemberAngelAppButton(
              bgColor: ColorUtils.yellow,
              label: AppConstants.submit,
              bttnEnabled: (detailsEntity?.appType == AppType.partner)
                  ? ref
                      .read(partnerRecommendationAndRatingDataProvider)
                      .isButtonEnabled
                  : ref
                      .read(memberRecommendationAndRatingDataProvider)
                      .isButtonEnabled,
              onSuccessHandler: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                showProgressBar(ref);
                if (detailsEntity?.appType == AppType.partner) {
                  await ref.read(submitRatingRecommendationProvider.future);
                  ref.invalidate(partnerRecommendationAndRatingDataProvider);
                  ref
                      .read(partnerRecommendationAndRatingDataProvider.notifier)
                      .clearState();
                  ref
                      .read(partnerRecommendationAndRatingDataProvider.notifier)
                      .setQuestionDetails(ref
                              .read(memberAngelConstantProvider.notifier)
                              .data
                              ?.memberFeedbackDetails ??
                          []);
                } else {
                  await ref.read(sendUserRatingRecommendationProvider.future);
                  ref.invalidate(memberRecommendationAndRatingDataProvider);
                  ref
                      .read(memberRecommendationAndRatingDataProvider.notifier)
                      .clearState();

                  ref
                      .read(memberRecommendationAndRatingDataProvider.notifier)
                      .setQuestionDetails(ref
                              .read(memberAngelConstantProvider.notifier)
                              .data
                              ?.palFeedbackDetails ??
                          []);
                }

                hideProgressBar(ref);

                onSubmit?.call();

                // if (isSuccess && context.mounted) {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
            20.height,
          ],
        ),
      ),
    );
  }
}
