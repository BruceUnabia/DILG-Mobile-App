import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.onLogin});

  final VoidCallback onLogin;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  bool _passwordVisible = false;
  bool rememberMe = false;
  String emailError = '';
  String passwordError = '';
  TextEditingController _passwordController = TextEditingController();
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  void checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;

    setState(() {
      isAuthenticated = _isAuthenticated;
    });

    // if (isAuthenticated) {
    //   Navigator.pushReplacementNamed(context, '/home');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 34,
                backgroundImage: AssetImage('assets/dilg-main.png'),
              ),
              SizedBox(height: 15),
              Text(
                'Department of the Interior and Local Government - Bohol Province',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 0, 0, 255)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Sign in to your Account',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText: emailError.isNotEmpty ? emailError : null,
                      ),
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText:
                            passwordError.isNotEmpty ? passwordError : null,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      obscureText: !_passwordVisible,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                        ),
                        Text('Remember Me'),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              emailError = _email.isEmpty
                                  ? 'Please enter your email.'
                                  : '';
                              passwordError = _password.isEmpty
                                  ? 'Please enter your password.'
                                  : '';
                            });

                            if (_email.isNotEmpty && _password.isNotEmpty) {
                              bool loginSuccessful = true;

                              if (loginSuccessful) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setBool('isAuthenticated', true);

                                setState(() {
                                  isAuthenticated = true;
                                });

                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              Text(
                '© DILG-Bohol Province 2024',
                style: TextStyle(
                  fontSize: 10,
                  color: const Color.fromARGB(255, 6, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
