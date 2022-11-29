import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mc_crud_test/models/user.dart';

class ViewUserScreen extends StatefulWidget {
  final User user;

  const ViewUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewUserScreen> createState() => _ViewUserScreenState();
}

class _ViewUserScreenState extends State<ViewUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.firstname!} ${widget.user.lastname!}"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text(
              "Full Details",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Firstname",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.user.firstname!,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "LastName",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.user.lastname!,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.user.email!,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Phone Number",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.user.phoneNumber!,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Bank Account Number",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.user.bankAccountNumber!,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Date of Birth",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  DateFormat.yMd().format(DateTime.parse(widget.user.dateOfBirth!)),
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
