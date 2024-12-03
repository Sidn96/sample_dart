import 'package:common/features/risk_profile/presentation/components/q1_current_age_chips_component.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'q1_current_age_provider.g.dart';

///question one
@Riverpod(keepAlive: true)
class RiskProfileQuestionOneAgeNotifier extends _$RiskProfileQuestionOneAgeNotifier {
  int selectedIndex = 0;
  List<AgeCalculation> ageList = AgeCalculation.ageList;


  @override
  int build() {
    //var temp = ageList[selectedIndex];
    onAppearance();
    return selectedIndex;
  }

  void updateValue(int value) {
    selectedIndex = value;
    state = selectedIndex;
  }

  void onAppearance() {
  //  List<String> list = tempValue.split('-');
    ref
        .read(riskProfileAnswerOneAgeNotifierProvider.notifier)
        .updateAgeValue( AgeCalculation.ageList[0].lowerBound,
      AgeCalculation.ageList[0].upperBound);
  }
}

@Riverpod(keepAlive: true)
class RiskProfileAnswerOneAgeNotifier extends _$RiskProfileAnswerOneAgeNotifier {
  List<int> selectedAgeIndex = [];

  @override
  List<int> build() {
    return selectedAgeIndex;
  }

  void updateAgeValue(int startValue, int endValue) {
    var ageResult = ageFilter(startValue, endValue);
    state = ageResult;
  }

  List<int> ageFilter(int initial, int last) {
    List<int> ageList = [];
    for (int i = initial; i <= last; i++) {
      ageList.add(i);
    }
    return ageList;
  }

  clearAllAnswers(){
    ref.read(selectedUserAgeRPNotifierProvider.notifier).updateAgeValue(-1);
  }
}

@Riverpod(keepAlive: true)
class SelectedUserAgeRPNotifier extends _$SelectedUserAgeRPNotifier {
  late int selectedAgeIndex;

  @override
  int build() {
    selectedAgeIndex = -1;
    return selectedAgeIndex;
  }

  void updateAgeValue(int value) {
    selectedAgeIndex = value;
    state = selectedAgeIndex;
  }
}
