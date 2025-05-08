// screens/signup_screen.dart
import 'package:flutter/material.dart';
import '../helpers/user_store.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      UserStore().register(_phoneController.text, _passController.text);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Sign-Up Successful")));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.length != 10) {
                    return "Phone number must be exactly 10 digits.";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Password required"
                            : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: Text("Sign Up")),
            ],
          ),
        ),
      ),
    );
  }
}
