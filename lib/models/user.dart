class User {
  int? id;
  String? firstname;
  String? lastname;
  String? dateOfBirth;
  String? phoneNumber;
  String? email;
  String? bankAccountNumber;

  userMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['firstname'] = firstname;
    mapping['lastname'] = lastname;
    mapping['dateOfBirth'] = dateOfBirth.toString();
    mapping['phoneNumber'] = phoneNumber;
    mapping['email'] = email;
    mapping['bankAccountNumber'] = bankAccountNumber;

    return mapping;
  }
}
