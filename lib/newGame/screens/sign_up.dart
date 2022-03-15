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
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Hangman",
            style: TextStyle(fontFamily: "Marker", fontSize: 30)),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 20)),
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
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle:
                          const TextStyle(color: Colors.white, fontSize: 20),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(showPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: Colors.white,
                      ),
                    ),
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
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(60, 40),
                    ),
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
                    child: Text(
                      _signUp ? "Sign Up" : "Log In",
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    style:
                        TextButton.styleFrom(minimumSize: const Size(60, 40)),
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
