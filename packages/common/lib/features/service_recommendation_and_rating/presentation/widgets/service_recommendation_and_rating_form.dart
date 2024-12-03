import 'package:common/core/presentation/common_widgets/truepal_app_loader.dart';
import 'package:common/core/presentation/common_widgets/truepal_error_widget.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/debouncer.dart';
import 'package:common/core/presentation/utils/enums/app_type.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/text_field_light_grey_border.dart';
import 'package:common/features/member_angel_common_constant/domain/entities/truepal_constant_data.dart';
import 'package:common/features/member_angel_common_constant/presentation/providers/member_angel_common_constant_provider.dart';
import 'package:common/features/service_recommendation_and_rating/domain/entities/member_angel_rating_details_entity.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/providers/service_recommendation_and_rating_provider.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/widgets/customer_cooperative_comfortable_status_radio.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/widgets/service_dropdown_w.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/widgets/service_recommendation_and_rating_form_field.dart';
import 'package:common/features/service_recommendation_and_rating/presentation/widgets/session_recommended_inc_dec.dart';
import 'package:flutter/material.dart';

class ServiceRecommendationAndRatingForm extends HookConsumerWidget {
  final MemberAngelRatingDetailsEntity? detailsEntity;
  const ServiceRecommendationAndRatingForm({super.key, this.detailsEntity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debounce = Debouncer(milliseconds: 500);
    // final diagnosisController = useTextEditingController();
    final experienceController = useTextEditingController();
    useEffect(() {
      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration.zero, () {
        ref
            .read(memberAngelConstantProvider.notifier)
            .getMemberAngelConstantData(detailsEntity!.appType!);
      });
      return;
    }, const []);

    final memberAngelConstantData = ref.watch(memberAngelConstantProvider);
    final partnerRecommendationDataNotifier =
        ref.read(partnerRecommendationAndRatingDataProvider.notifier);
    final memberRecommendationDataNotifier =
        ref.read(memberRecommendationAndRatingDataProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          memberAngelConstantData.when(
            data: (data) {
              List<TruepalFeedbackDetail>? feedbackList;
              if (detailsEntity?.appType == AppType.partner) {
                feedbackList = data?.memberFeedbackDetails;
              } else {
                feedbackList = data?.palFeedbackDetails;
              }

              if (feedbackList == null) {
                return const SizedBox.shrink();
              }

              if (detailsEntity?.showQuestion == false) {
                return TextFieldLightGreyBorder(
                  maxLines: 3,
                  hintText:
                      "Would you like to provide more information about your experience?",
                  hintTextSize: 12,
                  hintTextHeight: 1.4,
                  controller: experienceController,
                  onChanged: (value) {
                    debounce.run(() async {
                      final details = TruepalFeedbackDetail(
                        question:
                            "Would you like to provide more information about your experience?",
                        type: "textarea",
                        value: value,
                      );
                      if (detailsEntity?.appType == AppType.partner) {
                        partnerRecommendationDataNotifier.updateQuestionAnswer(
                            details,
                            shouldValidate: false);
                      } else {
                        memberRecommendationDataNotifier.updateQuestionAnswer(
                            details,
                            shouldValidate: false);
                      }
                    });
                  },
                );
              }

              // if (list != null && (detailsEntity?.showQuestion ?? false)) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: feedbackList
                    .map(
                      (e) => (e.type == "textarea")
                          ? TextFieldLightGreyBorder(
                              maxLines: 3,
                              hintText: e.question ?? "",
                              hintTextSize: 12,
                              hintTextHeight: 1.4,
                              hintTextColor: ColorUtils.midLightGrey,
                              controller: experienceController,
                              onChanged: (value) {
                                debounce.run(() async {
                                  if (detailsEntity?.appType ==
                                      AppType.partner) {
                                    partnerRecommendationDataNotifier
                                        .updateQuestionAnswer(
                                            TruepalFeedbackDetail(
                                                question: e.question,
                                                type: e.type,
                                                options: e.options,
                                                value: value));
                                  } else {
                                    memberRecommendationDataNotifier
                                        .updateQuestionAnswer(
                                            TruepalFeedbackDetail(
                                                question: e.question,
                                                type: e.type,
                                                options: e.options,
                                                value: value));
                                  }
                                });
                              },
                            )
                          : (e.type == "dropdown")
                              ? ServiceRecommendationAndRatingFormField(
                                  question: e.question ?? "",
                                  isRequired: e.isMandatory ?? false,
                                  spacing: 10,
                                  fieldWidget: ServiceDropdownComponent(
                                    onChange: (v) {
                                      partnerRecommendationDataNotifier
                                          .updateQuestionAnswer(
                                              TruepalFeedbackDetail(
                                                  question: e.question,
                                                  type: e.type,
                                                  options: e.options,
                                                  value: v.id));
                                      partnerRecommendationDataNotifier
                                          .setRecommendedServiceId(v.id);
                                    },
                                  ),
                                )
                              // : (e.type == "text")
                              //     ? ServiceRecommendationAndRatingFormField(
                              //         question: e.question ?? "",
                              //         isRequired: e.isMandatory ?? false,
                              //         fieldWidget: TextFieldLightGreyBorder(
                              //           controller: diagnosisController,
                              //           onChanged: (value) {
                              //             debounce.run(() {
                              //               recommendationDataNotifier
                              //                   .updateQuestionAnswer(
                              //                       TruepalFeedbackDetail(
                              //                           question: e.question,
                              //                           type: e.type,
                              //                           options: e.options,
                              //                           value: value));
                              //             });
                              //           },
                              //         ),
                              //       )
                              : (e.type == "number")
                                  ? ServiceRecommendationAndRatingFormField(
                                      question: e.question ?? "",
                                      isRequired: e.isMandatory ?? false,
                                      spacing: 10,
                                      fieldWidget:
                                          SessionRecommendedIncrementDecrement(
                                        min: e.min ?? 1,
                                        max: e.max ?? 5,
                                        onSelection: (v) {
                                          if (detailsEntity?.appType ==
                                              AppType.partner) {
                                            partnerRecommendationDataNotifier
                                                .updateQuestionAnswer(
                                                    TruepalFeedbackDetail(
                                                        question: e.question,
                                                        type: e.type,
                                                        options: e.options,
                                                        value: v));
                                            partnerRecommendationDataNotifier
                                                .setSessionsRecommended(v);
                                          }
                                        },
                                      ),
                                    )
                                  : (e.type == "radio")
                                      ? ServiceRecommendationAndRatingFormField(
                                          question: e.question ?? "",
                                          isRequired: e.isMandatory ?? false,
                                          spacing: 4,
                                          fieldWidget: StatusSelectionRadio(
                                            selectedChoice: (value) {
                                              if (value == null) return;
                                              if (detailsEntity?.appType ==
                                                  AppType.partner) {
                                                partnerRecommendationDataNotifier
                                                    .updateQuestionAnswer(
                                                        TruepalFeedbackDetail(
                                                            question:
                                                                e.question,
                                                            type: e.type,
                                                            options: e.options,
                                                            value: value));
                                              } else {
                                                memberRecommendationDataNotifier
                                                    .updateQuestionAnswer(
                                                        TruepalFeedbackDetail(
                                                            question:
                                                                e.question,
                                                            type: e.type,
                                                            options: e.options,
                                                            value: value));
                                              }
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                    )
                    .toList(),
              );
            },
            loading: () => const TrupalAppLoader(),
            error: (error, stackTrace) =>
                TruepalErrorWidget(onSuccessHandler: () {
              ref
                  .read(memberAngelConstantProvider.notifier)
                  .getMemberAngelConstantData(detailsEntity!.appType!);
            }),
          ),
          20.height,
        ],
      ),
    );
  }
}
