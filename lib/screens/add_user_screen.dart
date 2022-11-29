import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mc_crud_test/models/user.dart';
import 'package:mc_crud_test/services/user_service.dart';
import 'package:mc_crud_test/utils/utils.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();

  DateTime? _selectedDate;

  bool _firstnameValidate = false;
  bool _lastnameValidate = false;
  bool _phoneNumberValidate = false;
  bool _emailValidate = false;
  bool _bankAccountNumberValidate = false;
  bool _dateOfBirthValidate = false;

  String? _firstnameErrorMsg;
  String? _lastnameErrorMsg;
  String? _phoneNumberErrorMsg;
  String? _emailErrorMsg;
  String? _bankAccountNumberErrorMsg;
  String? _dateOfBirthErrorMsg;

  final _userService = UserService();

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  Future<void> _submit() async {
    if (_firstnameController.text.isEmpty) {
      setState(() {
        _firstnameErrorMsg = 'This field cannot be empty';
        _firstnameValidate = false;
      });
    } else if (_firstnameController.text.length < 3) {
      setState(() {
        _firstnameErrorMsg = 'This field should have at least 3 characters';
        _firstnameValidate = false;
      });
    } else {
      setState(() {
        _firstnameErrorMsg = null;
        _firstnameValidate = true;
      });
    }

    if (_lastnameController.text.isEmpty) {
      setState(() {
        _lastnameErrorMsg = 'This field cannot be empty';
        _lastnameValidate = false;
      });
    } else if (_lastnameController.text.length < 3) {
      setState(() {
        _lastnameErrorMsg = 'This field should have at least 3 characters';
        _lastnameValidate = false;
      });
    } else {
      setState(() {
        _lastnameErrorMsg = null;
        _lastnameValidate = true;
      });
    }

    if (_emailController.text.isEmpty) {
      setState(() {
        _emailErrorMsg = 'This field cannot be empty';
        _emailValidate = false;
      });
    } else if (!Utils.isEmail(_emailController.text)) {
      setState(() {
        _emailErrorMsg = 'This is not a valid email address';
        _emailValidate = false;
      });
    } else {
      setState(() {
        _emailErrorMsg = null;
        _emailValidate = true;
      });
    }

    if (_phoneNumberController.text.isEmpty) {
      setState(() {
        _phoneNumberErrorMsg = 'This field cannot be empty';
        _phoneNumberValidate = false;
      });
    } else if (!Utils.isPhoneNumber(_phoneNumberController.text)) {
      setState(() {
        _phoneNumberErrorMsg = 'This is not a valid phone number';
        _phoneNumberValidate = false;
      });
    } else {
      setState(() {
        _phoneNumberErrorMsg = null;
        _phoneNumberValidate = true;
      });
    }

    if (_bankAccountNumberController.text.isEmpty) {
      setState(() {
        _bankAccountNumberErrorMsg = 'This field cannot be empty';
        _bankAccountNumberValidate = false;
      });
    } else if (!Utils.isBankAccountNumber(_bankAccountNumberController.text)) {
      setState(() {
        _bankAccountNumberErrorMsg = 'This is not a valid phone number';
        _bankAccountNumberValidate = false;
      });
    } else {
      setState(() {
        _bankAccountNumberErrorMsg = null;
        _bankAccountNumberValidate = true;
      });
    }

    if (_selectedDate == null) {
      setState(() {
        _dateOfBirthErrorMsg = "Please pick a date";
        _dateOfBirthValidate = false;
      });
    } else {
      setState(() {
        _dateOfBirthErrorMsg = null;
        _dateOfBirthValidate = true;
      });
    }

    if (_firstnameValidate &&
        _lastnameValidate &&
        _phoneNumberValidate &&
        _emailValidate &&
        _bankAccountNumberValidate &&
        _dateOfBirthValidate &&
        true) {
      var user = User();
      user.firstname = _firstnameController.text;
      user.lastname = _lastnameController.text;
      user.phoneNumber = _phoneNumberController.text;
      user.email = _emailController.text;
      user.bankAccountNumber = _bankAccountNumberController.text;
      user.dateOfBirth = _selectedDate.toString();
      try {
        var result = await _userService.saveUser(user);
        Navigator.pop(context, result);
      } catch (error) {
        rethrow;
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New User')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Information',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Firstname',
                  labelText: 'Firstname',
                  errorText: _firstnameErrorMsg,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Lastname',
                  labelText: 'Lastname',
                  errorText: _lastnameErrorMsg,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Email',
                  labelText: 'Email',
                  errorText: _emailErrorMsg,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Phone Number',
                  labelText: 'Phone Number',
                  errorText: _phoneNumberErrorMsg,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _bankAccountNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Bank Account Number',
                  labelText: 'Bank Account Number',
                  errorText: _bankAccountNumberErrorMsg,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "No date chosen!"
                          : "Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}",
                      style: TextStyle(
                          color: (!_dateOfBirthValidate &&
                                  _dateOfBirthErrorMsg != null &&
                                  _selectedDate == null)
                              ? Colors.red
                              : Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text(
                      "Choose Date",
                    ),
                  ),
                ],
              ),
              if (!_dateOfBirthValidate && _dateOfBirthErrorMsg != null)
                Text(
                  _dateOfBirthErrorMsg!,
                  style: const TextStyle(fontSize: 12, color: Colors.red),
                ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: _submit,
                    child: const Text("Save Information"),
                  ),
                  const SizedBox(width: 10.0),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      _firstnameController.text = '';
                      _lastnameController.text = '';
                      _phoneNumberController.text = '';
                      _emailController.text = '';
                      _bankAccountNumberController.text = '';
                      setState(() {
                        _firstnameValidate = false;
                        _lastnameValidate = false;
                        _phoneNumberValidate = false;
                        _emailValidate = false;
                        _bankAccountNumberValidate = false;
                        _dateOfBirthValidate = false;

                        _firstnameErrorMsg = null;
                        _lastnameErrorMsg = null;
                        _phoneNumberErrorMsg = null;
                        _emailErrorMsg = null;
                        _bankAccountNumberErrorMsg = null;
                        _dateOfBirthErrorMsg = null;

                        _selectedDate = null;
                      });
                    },
                    child: const Text("Clear Information"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
