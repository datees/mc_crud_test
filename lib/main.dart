import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mc_crud_test/screens/edit_user_screen.dart';
import 'package:mc_crud_test/screens/view_user_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mc_crud_test/screens/add_user_screen.dart';
import 'package:mc_crud_test/models/user.dart';
import 'package:mc_crud_test/services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MC CRUD TEST',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _userList;
  final _userService = UserService();
  bool _loading = false;

  getAllUsersDetails() async {
    var users = await _userService.readAllUsers();
    _userList = <User>[];
    users.forEach((user) {
      var userModel = User();
      userModel.id = user["id"];
      userModel.firstname = user["firstname"];
      userModel.lastname = user["lastname"];
      userModel.dateOfBirth = user["dateOfBirth"];
      userModel.phoneNumber = user["phoneNumber"];
      userModel.email = user["email"];
      userModel.bankAccountNumber = user["bankAccountNumber"];
      setState(() {
        _userList.add(userModel);
      });
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _userList = <User>[];
    getAllUsersDetails();
    super.initState();
  }

  _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: const Text(
            'Are You Sure to Delete',
            style: TextStyle(color: Colors.teal, fontSize: 20),
          ),
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  var result = await _userService.deleteUser(userId);
                  if (result != null) {
                    Navigator.pop(context);
                    getAllUsersDetails();
                    _showSnackbar('User Detail Deleted Success');
                  }
                },
                child: const Text('Delete')),
            TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MC CRUD TEST")),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _userList.isEmpty
              ? const Center(
                  child: Text("There is no user to show."),
                )
              : ListView.builder(
                  itemCount: _userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          "${_userList[index].firstname} ${_userList[index].lastname}",
                        ),
                        subtitle: Text(_userList[index].email!),
                        leading: const Icon(Icons.person),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditUserScreen(user: _userList[index]),
                                ),
                              ).then((data) {
                                if (data != null) {
                                  getAllUsersDetails();
                                  _showSnackbar('User updated successfully');
                                }
                              }),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.teal,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _deleteFormDialog(context, _userList[index].id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewUserScreen(user: _userList[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUserScreen(),
            ),
          ).then((data) {
            if (data != null) {
              getAllUsersDetails();
              _showSnackbar('User added successfully');
            }
          });
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
