import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailTextController = TextEditingController();
    TextEditingController _passwordTextController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Center(
          child: SizedBox(
        child: Material(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back!",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "please enter your email";
                      } else if (!isValidEmail(value)) {
                        return "please enter a valid email";
                      } else
                        return null;
                    },
                    controller: _emailTextController,
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "please enter your password";
                      } else if (value.length < 6) {
                        return "password must be at least 6 characters";
                      } else
                        return null;
                    },
                    controller: _passwordTextController,
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          final _email = _emailTextController.text;
                          final _password = _passwordTextController.text;
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: _email,
                                password: _password,
                              )
                              .then((_) =>
                                  Navigator.pushNamed(context, "/settings"))
                              .catchError((error) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("oh Snap!"),
                                  content: Text(error.message),
                                  actions: [
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Dismiss"))
                                  ],
                                );
                              },
                            );
                          });
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blueAccent,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        width: 400,
      )),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
