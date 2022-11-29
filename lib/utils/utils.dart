class Utils {
  static bool isEmail(String email) {
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  static bool isPhoneNumber(String phoneNumber) {
    String p =
        r'^\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(phoneNumber);
  }

  static bool isBankAccountNumber(String bankAccountNumber) {
    String p = r"^[0-9]{7,14}$";
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(bankAccountNumber);
  }
}
