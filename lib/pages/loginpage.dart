import 'package:culinary_project/pages/homepage.dart';
import 'package:culinary_project/pages/register_option.dart';
import 'package:culinary_project/shared/constants.dart';
import 'package:culinary_project/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  bool changebutton = false;

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      nextScreen(context, HomePage());
      setState(() {
        changebutton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Log in",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Constants.secondaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  "lib/assets/login.png",
                  fit: BoxFit.cover,
                  height: 200,
                  width: 500,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text("Welcome",
                    style: textDecoration.copyWith(
                        color: Colors.black, fontSize: 40)),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            labelText: "Enter your username",
                            hintText: "Username"),
                        onChanged: (value) {
                          name = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a username!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a Password!";
                          } else if (value.length < 6) {
                            return "Password should be longer than 6 characters!";
                          } else {
                            return null;
                          }
                        },
                        decoration: textInputDecoration.copyWith(
                            labelText: "Enter your password",
                            hintText: "Password"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Material(
                  color: Constants.secondaryColor,
                  borderRadius: BorderRadius.circular(changebutton ? 30 : 10),
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () => moveToHome(context),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: changebutton ? 50 : 100,
                      height: 50,
                      alignment: Alignment.center,
                      child: changebutton
                          ? Icon(Icons.done, color: Colors.white)
                          : const Text("Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the registration page
                    nextScreen(context, RegisterOptions());
                  },
                  child: Text(
                    "Not Registered? Register",
                    style: TextStyle(
                      color: Colors.blue, // Customize the color as needed
                      decoration:
                          TextDecoration.underline, // Underline the text
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
