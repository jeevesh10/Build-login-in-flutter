import 'package:flutter/material.dart';
import '../helpers/user_store.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPassController = TextEditingController();

  bool _otpSent = false;
  bool _verified = false;

  String generatedOtp = "123456"; // mock OTP

  void _sendOtp() {
    final phone = _phoneController.text;
    if (phone.length != 10) {
      _showMessage("Phone number must be exactly 10 digits.");
      return;
    }
    if (phone != UserStore().phoneNumber) {
      _showMessage("Phone number not registered.");
      return;
    }

    setState(() {
      _otpSent = true;
    });
    _showMessage("OTP sent to $phone (mock: 123456)");
  }

  void _verifyOtp() {
    if (_otpController.text == generatedOtp) {
      setState(() {
        _verified = true;
      });
      _showMessage("OTP verified. You may now set a new password.");
    } else {
      _showMessage("Invalid OTP.");
    }
  }

  void _resetPassword() {
    if (_newPassController.text.isEmpty) {
      _showMessage("Enter a new password.");
      return;
    }
    UserStore().password = _newPassController.text;
    _showMessage("Password reset successfully.");
    Navigator.pop(context);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Registered Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 12),
            if (!_otpSent)
              ElevatedButton(onPressed: _sendOtp, child: Text("Send OTP")),
            if (_otpSent && !_verified) ...[
              TextField(
                controller: _otpController,
                decoration: InputDecoration(labelText: "Enter OTP"),
              ),
              SizedBox(height: 12),
              ElevatedButton(onPressed: _verifyOtp, child: Text("Verify OTP")),
            ],
            if (_verified) ...[
              TextField(
                controller: _newPassController,
                obscureText: true,
                decoration: InputDecoration(labelText: "New Password"),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text("Reset Password"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
