class InputValidationResult {
  InputValidationResult(this.status, [this.message]);

  /// Provides whether the input filed is validated or not
  final bool status;

  /// Provides error message if any.
  final String? message;
}

class InputValidation {
  /// checks whether a password is valid or not
  static InputValidationResult isPasswordValid(String? password) {
    if (password == null) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (password.trim().isEmpty) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password)) {
      return InputValidationResult(false,
          'The password should have at least eight characters, alpha-numeric, at least one capital & one special character.');
    }
    return InputValidationResult(true, null);
  }

  /// checks whether a otp is valid or not
  static InputValidationResult isOtpValid(String? pin) {
    if (pin == null) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (pin.trim().isEmpty) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (pin.length != 6) {
      return InputValidationResult(false, 'length should be 6');
    }
    return InputValidationResult(true, null);
  }

  /// checks whether a pin is valid or not
  static InputValidationResult isMPinValid(String? pin) {
    if (pin == null) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (pin.trim().isEmpty) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (pin.length != 4) {
      return InputValidationResult(false, 'length should be 4');
    }
    return InputValidationResult(true, null);
  }

  /// checks whether a email is valid not not
  static InputValidationResult isEmailValid(String? email) {
    if (email == null) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (email.trim().isEmpty) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) {
      return InputValidationResult(false, 'Email Id is Invalid');
    }
    return InputValidationResult(true);
  }

  static InputValidationResult isMobileNumberValid(String? mobileNumber) {
    if (mobileNumber == null) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (mobileNumber.trim().isEmpty) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (!RegExp(r'^(?:(?:\\+|0{0,2})91(\s*[\\-]\s*)?|[0]?)?[6789]\d{9}$')
        .hasMatch(mobileNumber)) {
      return InputValidationResult(false, 'invalid mobile number');
    }
    return InputValidationResult(true);
  }

  /// check's whether a pan is valid or not
  static InputValidationResult isPanValid(String? pan) {
    if (pan == null) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (pan.trim().isEmpty) {
      return InputValidationResult(false, 'Mandatory Field');
    } else if (pan.length != 10) {
      return InputValidationResult(false, 'Please enter valid Pan!');
    } else if (!RegExp(r'[A-Z]{3}[ABCFGHLJPTF]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}')
        .hasMatch(pan)) {
      return InputValidationResult(false, 'Please enter valid Pan!');
    }
    return InputValidationResult(true);
  }

  // Name Validation
  static InputValidationResult isNameValid(String? name) {
    if (name == null) {
      return InputValidationResult(false, "Mandatory Field");
    } else if (name.trim().isEmpty) {
      return InputValidationResult(false, "Mandatory Field");
    } else if (!RegExp(r'^[a-zA-Z ]*$').hasMatch(name)) {
      return InputValidationResult(false, "Name is Invalid");
    }
    return InputValidationResult(true);
  }

  static InputValidationResult isMandatory(String? value) {
    if (value == null) {
      return InputValidationResult(false, "Mandatory Field");
    } else if (value.trim().isEmpty) {
      return InputValidationResult(false, "Mandatory Field");
    }
    return InputValidationResult(true);
  }

  static InputValidationResult isPinCodeValid(String? value) {
    if (value == null) {
      return InputValidationResult(false, "Mandatory Field");
    } else if (value.trim().isEmpty) {
      return InputValidationResult(false, "Mandatory Field");
    } else if (!RegExp(r'^[1-9][0-9]{5}$').hasMatch(value)) {
      return InputValidationResult(false, "Invalid pin code");
    }
    return InputValidationResult(true);
  }

  static InputValidationResult isValidIFSC(String? code) {
    if (code == null || code.trim().isEmpty) {
      return InputValidationResult(false, "Mandatory Field");
    }

    // IFSC code should be 11 characters long
    if (code.length != 11) {
      return InputValidationResult(false, "Should be 11 characters");
    }

    // Define a regular expression for valid IFSC code pattern
    RegExp regex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    // IFSC code should match the pattern
    if (!regex.hasMatch(code)) {
      return InputValidationResult(false, "Invalid IFSC code");
    }

    return InputValidationResult(true);
  }

  static InputValidationResult isValidAccountNumber(String? accountNumber) {
    if (accountNumber == null || accountNumber.trim().isEmpty) {
      return InputValidationResult(false, "Mandatory Field");
    }
    RegExp regex = RegExp(r'^\d{9,18}$');
    if (!regex.hasMatch(accountNumber)) {
      return InputValidationResult(false, "Invalid account number");
    }

    return InputValidationResult(true);
  }

  static InputValidationResult isAbove18Years(DateTime? date) {
    if (date == null) {
      return InputValidationResult(false, "Mandatory Field");
    }
    Duration difference = DateTime.now().difference(date);
    if (difference.inDays < 6570) {
      // 6570 days = 18 years
      return InputValidationResult(false, 'Must be above 18 years of age');
    }
    return InputValidationResult(true);
  }

  static InputValidationResult isBelow18Years(DateTime? date) {
    if (date == null) {
      return InputValidationResult(false, "Mandatory Field");
    }
    Duration difference = DateTime.now().difference(date);
    if (difference.inDays >= 6570) {
      // 6570 days = 18 years
      return InputValidationResult(false, 'Must be below 18 years of age');
    }
    return InputValidationResult(true);
  }

  static InputValidationResult isValidPercentage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return InputValidationResult(false, "Mandatory Field");
    }
    try {
      int percent = int.parse(value);
      if (percent <= 0 || percent > 100) {
        return InputValidationResult(false, 'Invalid percentage');
      }
    } on FormatException {
      return InputValidationResult(false, 'Invalid value');
    }

    return InputValidationResult(true);
  }

  static InputValidationResult isAmountGreaterThan(
      String? value, int minimumAmount) {
    if (value == null || value.trim().isEmpty) {
      return InputValidationResult(false, "Mandatory Field");
    }
    try {
      double parsedValue = double.parse(value);
      if (parsedValue < minimumAmount) {
        return InputValidationResult(
            false, 'Amount should be greater than min amount');
      }
    } on FormatException {
      return InputValidationResult(false, 'Invalid value');
    }

    return InputValidationResult(true);
  }

  static InputValidationResult isValidAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return InputValidationResult(false, "Mandatory Field");
    }

    if (double.tryParse(value) == null) {
      return InputValidationResult(false, 'Invalid value');
    }

    return InputValidationResult(true);
  }
}
