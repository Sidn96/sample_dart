import 'package:common/core/presentation/utils/date_utils/date_utils.dart';
import 'package:common/features/profile/presentation/common_imports.dart';

extension DateTimeExtensions on DateTime {
  bool get isFuture {
    return isAfter(DateTime.now());
  }

  bool get isMinor {
    var now = DateTime.now();
    var diff = now.difference(this);
    return isBefore(now) && diff.inDays < ((365 * 18) + 4);
  }

  int get dateDifferenceInDays {
    var now = DateTime.now();
    //var diff = (now.difference(this).inHours / 24).round();
    var diff = now.difference(this).inDays;
    return diff;
  }

  String formatTo({String dateFormat = AppDateUtils.DOB_DATE_FORMAT}) {
    return DateFormat(dateFormat).format(this);
  }

  String get getDayAndMonth => switch (day) {
        1 || 11 || 21 || 31 => "${day}st ${formatTo(dateFormat: "MMMM")}",
        _ => "${day}th ${formatTo(dateFormat: "MMMM")}",
      };

  bool isSameDate(DateTime? newDate) {
    if (newDate == null) return false;
    return (day == newDate.day &&
        month == newDate.month &&
        year == newDate.year);
  }

  String get getDayWithDate =>
      "${DateFormat('EE').format(this)} ${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year";
}
