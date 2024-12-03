import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';

final listOfAngelContentProvider = StateProvider<List<String>>((ref) => [
      AppConstants.faqAngelDescription1,
      AppConstants.faqAngelDescription2,
      AppConstants.faqAngelDescription3,
      AppConstants.faqAngelDescription4,
      AppConstants.faqAngelDescription5,
      AppConstants.faqAngelDescription6,
      AppConstants.faqAngelDescription7,
      AppConstants.faqAngelDescription8,
      AppConstants.faqAngelDescription9,
      AppConstants.faqAngelDescription10,
      AppConstants.faqAngelDescription11,
      AppConstants.faqAngelDescription12,
      AppConstants.faqAngelDescription13,
      AppConstants.faqAngelDescription14,
    ]);

final listOfAngelHeaderContentProvider = StateProvider<List<String>>((ref) => [
      AppConstants.faqAngelHeader1,
      AppConstants.faqAngelHeader2,
      AppConstants.faqAngelHeader3,
      AppConstants.faqAngelHeader4,
      AppConstants.faqAngelHeader5,
      AppConstants.faqAngelHeader6,
      AppConstants.faqAngelHeader7,
      AppConstants.faqAngelHeader8,
      AppConstants.faqAngelHeader9,
      AppConstants.faqAngelHeader10,
      AppConstants.faqAngelHeader11,
      AppConstants.faqAngelHeader12,
      AppConstants.faqAngelHeader13,
      AppConstants.faqAngelHeader14,
    ]);

final listOfExpandedContentProvider = StateProvider<List<String>>((ref) => [
      AppConstants.faqAboutDescription1,
      AppConstants.faqAboutDescription2,
      AppConstants.faqAboutDescription3,
      AppConstants.faqAboutDescription4,
      AppConstants.faqAboutDescription5,
      AppConstants.faqAboutDescription6,
      AppConstants.faqAboutDescription7,
      AppConstants.faqAboutDescription8,
      AppConstants.faqAboutDescription9,
      AppConstants.faqAboutDescription10,
      AppConstants.faqAboutDescription11,
      AppConstants.faqAboutDescription12,
      AppConstants.faqAboutDescription13,
      AppConstants.faqAboutDescription14,
      AppConstants.faqAboutDescription15,
      AppConstants.faqAboutDescription16,
      AppConstants.faqAboutDescription17,
      AppConstants.faqAboutDescription18,
      AppConstants.faqAboutDescription19,
      AppConstants.faqAboutDescription20,
      AppConstants.faqAboutDescription21
    ]);

final listOfExpandedMemberContentProvider =
    StateProvider<List<String>>((ref) => [
          AppConstants.faqMemberDescription1,
          AppConstants.faqMemberDescription2,
          AppConstants.faqMemberDescription3,
          AppConstants.faqMemberDescription4,
          AppConstants.faqMemberDescription5,
          AppConstants.faqMemberDescription6,
          AppConstants.faqMemberDescription7,
          AppConstants.faqMemberDescription8,
          AppConstants.faqMemberDescription9,
          AppConstants.faqMemberDescription10,
          AppConstants.faqMemberDescription11,
          AppConstants.faqMemberDescription12,
          AppConstants.faqMemberDescription13,
          AppConstants.faqMemberDescription14,
          AppConstants.faqMemberDescription15,
          AppConstants.faqMemberDescription16,
        ]);

// about -----

final listOfHeaderContentProvider = StateProvider<List<String>>((ref) => [
      AppConstants.faqAboutHeader1,
      AppConstants.faqAboutHeader2,
      AppConstants.faqAboutHeader3,
      AppConstants.faqAboutHeader4,
      AppConstants.faqAboutHeader5,
      AppConstants.faqAboutHeader6,
      AppConstants.faqAboutHeader7,
      AppConstants.faqAboutHeader8,
      AppConstants.faqAboutHeader9,
      AppConstants.faqAboutHeader10,
      AppConstants.faqAboutHeader11,
      AppConstants.faqAboutHeader12,
      AppConstants.faqAboutHeader13,
      AppConstants.faqAboutHeader14,
      AppConstants.faqAboutHeader15,
      AppConstants.faqAboutHeader16,
      AppConstants.faqAboutHeader17,
      AppConstants.faqAboutHeader18,
      AppConstants.faqAboutHeader19,
      AppConstants.faqAboutHeader20,
      AppConstants.faqAboutHeader21
    ]);
final listOfMemberHeaderContentProvider = StateProvider<List<String>>((ref) => [
      AppConstants.faqMemberHeader1,
      AppConstants.faqMemberHeader2,
      AppConstants.faqMemberHeader3,
      AppConstants.faqMemberHeader4,
      AppConstants.faqMemberHeader5,
      AppConstants.faqMemberHeader6,
      AppConstants.faqMemberHeader7,
      AppConstants.faqMemberHeader8,
      AppConstants.faqMemberHeader9,
      AppConstants.faqMemberHeader10,
      AppConstants.faqMemberHeader11,
      AppConstants.faqMemberHeader12,
      AppConstants.faqMemberHeader13,
      AppConstants.faqMemberHeader14,
      AppConstants.faqMemberHeader15,
      AppConstants.faqMemberHeader16,
    ]);

final listOfPalExpandedContentProvider = StateProvider<List<String>>((ref) => [
      AppConstants.newFaqPalDescription1,
      AppConstants.newFaqPalDescription2,
      AppConstants.newFaqPalDescription3,
      AppConstants.newFaqPalDescription4,
      AppConstants.newFaqPalDescription5,
      AppConstants.newFaqPalDescription6,
      AppConstants.newFaqPalDescription7,
      AppConstants.newFaqPalDescription8,
      AppConstants.newFaqPalDescription9,
      AppConstants.newFaqPalDescription10,
      AppConstants.newFaqPalDescription11,
      AppConstants.newFaqPalDescription12,
      AppConstants.newFaqPalDescription13,
      AppConstants.newFaqPalDescription14,
    ]);

final listOfPalHeaderContentProvider = StateProvider<List<String>>((ref) => [
      AppConstants.newFaqPalsHeader1,
      AppConstants.newFaqPalsHeader2,
      AppConstants.newFaqPalsHeader3,
      AppConstants.newFaqPalsHeader4,
      AppConstants.newFaqPalsHeader5,
      AppConstants.newFaqPalsHeader6,
      AppConstants.newFaqPalsHeader7,
      AppConstants.newFaqPalsHeader8,
      AppConstants.newFaqPalsHeader9,
      AppConstants.newFaqPalsHeader10,
      AppConstants.newFaqPalsHeader11,
      AppConstants.newFaqPalsHeader12,
      AppConstants.newFaqPalsHeader13,
      AppConstants.newFaqPalsHeader14,
    ]);

final listOfTruePalMemberExpandedContentProvider =
    StateProvider<List<String>>((ref) => [
          AppConstants.truePalFaq1Answer,
          AppConstants.truePalFaq2Answer,
          AppConstants.truePalFaq3Answer,
          AppConstants.truePalFaq4Answer,
          AppConstants.truePalFaq5Answer,
          AppConstants.truePalFaq6Answer,
          AppConstants.truePalFaq7Answer,
          AppConstants.truePalFaq8Answer,
          AppConstants.truePalFaq9Answer,
          AppConstants.truePalFaq10Answer,
        ]);

// about -----

/*--TruePAL--*/

final listOfTruePalMemberHeaderContentProvider =
    StateProvider<List<String>>((ref) => [
          AppConstants.truePalFaq1,
          AppConstants.truePalFaq2,
          AppConstants.truePalFaq3,
          AppConstants.truePalFaq4,
          AppConstants.truePalFaq5,
          AppConstants.truePalFaq6,
          AppConstants.truePalFaq7,
          AppConstants.truePalFaq8,
          AppConstants.truePalFaq9,
          AppConstants.truePalFaq10,
        ]);

/// FAQ providers
final showAllProvider = StateProvider<bool>(
  (ref) => false,
);

List<String> listoftabs(bool isMemberApp) {
  if (isMemberApp) {
    return ["Members", "Pals"];
  } else {
    return ["Pals", "Members"];
  }
}
