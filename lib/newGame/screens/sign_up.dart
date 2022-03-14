import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/providers/auth_state_hang.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _signUp = false;
  bool showPassword = false;
  String _emailCheck = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                const FlutterLogo(
                  size: 100.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white)),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                          .hasMatch(_emailController.text)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: Icon(showPassword
                                ? Icons.visibility_off
                                : Icons.visibility))),
                    controller: _passwordController,
                    obscureText: !showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 8) {
                        return "Password need to be 8 characters long";
                      }
                      return null;
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _signUp
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<AuthState>(context, listen: false)
                                  .signOnWithEmail(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                          }
                        : () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<AuthState>(context, listen: false)
                                  .signInWithEmail(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                          },
                    child: Text(_signUp ? "Sign Up" : "Log In"),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _signUp = !_signUp;
                      });
                    },
                    child: Text(!_signUp ? "Sign Up" : "Log In"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
