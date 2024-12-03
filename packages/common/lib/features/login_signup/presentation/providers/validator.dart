import '../../../profile/presentation/common_imports.dart';

class Validator {
  ///DOB validation method new
  static int validateDateOfBirth(String value) {
    Pattern pattern =
        r"^(((0[1-9]|[12][0-9]|3[01])[- /.](0[13578]|1[02])|(0[1-9]|[12][0-9]|30)[- /.](0[469]|11)|(0[1-9]|1\d|2[0-8])[- /.]02)[- /.]\d{4}|29[- /.]02[- /.](\d{2}(0[48]|[2468][048]|[13579][26])|([02468][048]|[1359][26])00))$";
    if (value.isEmpty) {
      return 1;
    } else if (!RegExp(pattern.toString()).hasMatch(value)) {
      return 2;
    } else if (value.isNotEmpty) {
      final dob = DateFormat('dd/MM/yyyy').parse(value);
      final diff = DateTime.now().difference(dob);
      if (!(diff.inDays <= 37985)) {
        return 3;
      } else if (!(diff.inDays >= 6574)) {
        return 4;
      } else if (DateTime.now().isBefore(dob)) {
        return 5;
      } else {
        /// success;
        return 0;
      }
    }
    return 0;
  }

  static int fullNameValidate(String data) {
    if (data.isEmpty) {
      return 1;
    } else if (data.startsWith(" ") || data.trim().length < 3) {
      return 2;
    } else {
      return 0;
    }
  }

  static bool validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(email)) ? false : true;
  }
}
