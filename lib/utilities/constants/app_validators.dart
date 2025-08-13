import 'package:get/get.dart';

class AppValidators {
  String? email(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);

    if (value == null) {
      return 'This field is required'.tr;
    } else if (value.isEmpty) {
      return 'This field is required'.tr;
    } else if (regExp.hasMatch(value) == false) {
      return 'invalid Email'.tr;
    }
    return null;
  }

  String? fullname(String? value) {
    if (value == null) {
      return 'This field is required'.tr;
    } else if (value.isEmpty) {
      return 'This field is required'.tr;
    }

    return null;
  }

  String? cridetCard(String? value) {
    if (value == null) {
      return 'This field is required'.tr;
    } else if (value.isEmpty) {
      return 'This field is required'.tr;
    } else if (value.length != 19) {
      return 'Invalid Card Number'.tr;
    } else {}

    return 'Invalid Card Number'.tr;
  }

  String? textValidation(String? value) {
    if (value == null) {
      return 'This field is required'.tr;
    } else if (value.isEmpty) {
      return 'This field is required'.tr;
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value == null) {
      return 'Enter Your Password'.tr;
    } else if (value.isEmpty) {
      return 'Enter Your Password'.tr;
    } else if (value.length < 5) {
      return 'Password Should Be More Than 4 Digit'.tr;
    }
    return null;
  }

  String? coupon(String? value) {
    String pattern = r'^\d{1,10}$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'This field is required'.tr;
    } else if (!regExp.hasMatch(value)) {
      return 'invalid Input'.tr;
    }
    return null;
  }

  String? phoneValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required'.tr;
    } else {
      if ((!value.isNum)) {
        return 'invalid Phone Number'.tr;
      }
    }
    return null;
  }

  String? cardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required'.tr;
    }

    return null;
  }
}
