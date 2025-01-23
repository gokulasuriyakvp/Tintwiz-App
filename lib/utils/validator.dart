
import 'constants.dart';

class FieldValidators {
  static String? userEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return  Constants.errorUsername;
    } else if (value.length < 3) {
      return Constants.errorUserNameInvalid;
    }
    return null;
  }
  static String? passwordValidator(String? value) {
    // final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');

    if (value == null || value.isEmpty) {
      return Constants.errorPssword;
    } else if (value.length < 4) {
      return Constants.errorPsswordIncorret;
    }
    return null;
  }
}
