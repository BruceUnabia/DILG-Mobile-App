import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String _confirmPasswordError = '';
  String _passwordError = '';

  void _showPasswordChangedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password Changed!'),
          content: Text('Your password has been successfully updated.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Close the modal
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.0),
            Text(
              'Change Password',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Please enter your password',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: Colors.black),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
                errorText: _passwordError.isNotEmpty ? _passwordError : null,
              ),
              obscureText: _obscurePassword,
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _confirmPasswordController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: Colors.black),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
                errorText: _confirmPasswordError.isNotEmpty
                    ? _confirmPasswordError
                    : null,
              ),
              obscureText: _obscureConfirmPassword,
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                _resetPassword();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Center(
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetPassword() {
    setState(() {
      // Check if passwords are empty
      if (_passwordController.text.isEmpty ||
          _confirmPasswordController.text.isEmpty) {
        _passwordError = 'Password cannot be empty';
        _confirmPasswordError = 'Password cannot be empty';
      } else if (_passwordController.text == _confirmPasswordController.text) {
        // Check if the password contains special characters
        if (!_containsSpecialCharacters(_passwordController.text)) {
          _passwordError = 'Password must contain special characters (!@%)';
          _confirmPasswordError =
              'Password must contain special characters (!@%)';
          return;
        }
        // Implement your logic to change the password
        _showPasswordChangedDialog(context);
      } else {
        _passwordError = 'Password do not match';
        _confirmPasswordError = 'Password do not match';
      }
    });
  }

  bool _containsSpecialCharacters(String value) {
    String pattern = r'(?=.*[!@%$^&*])';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }
}
