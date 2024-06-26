import 'package:culinary_project/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:culinary_project/pages/homepage.dart';
import 'package:culinary_project/pages/loginpage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:culinary_project/service/database_service.dart';
import 'package:culinary_project/widgets/widgets.dart';

class BuyerRegistration extends StatefulWidget {
  const BuyerRegistration({super.key});

  @override
  State<BuyerRegistration> createState() => _BuyerRegistrationState();
}

class _BuyerRegistrationState extends State<BuyerRegistration> {
  // String programDropDown = "Select your Program";
  String categoryDropDown = "Select your category";
  // String yearDropDown = "Select your year";
  String genderselected = "Select your gender";
  // String seatTypeDropDown = "Select Seat Type";
  bool _agreedTo = false;
  final _formKey = GlobalKey<FormState>();
  // DateTime admissionSelectedDate = DateTime.now();
  String fullName = "";
  String gender = "";
  String contactNumber = "";
  String emailAddress = "";
  String city = "";
  String state = "";
  String username = "";
  String password = "";
  String confirmPassword = "";
  // String businessName = "";
  // String description = "";
  // String category = "";
  String buildingNo = "";
  String district = "";
  String pincode = "";
  // String loginId = "";

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    // if (EmailValidator.validate(value)) {
    //   return 'Please enter valid email ';
    // }
    return null;
  }

  String? validatepassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an password';
    }
    if (value.length < 6) {
      return 'Password must be 8 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Buyer Registeration",
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: const Text(
                          "Create your account ",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      const SizedBox(height: 15),

                      const Icon(
                        Icons.person_rounded,
                        color: Constants.secondaryColor,
                        size: 100,
                      ),

                      //register info
                      //name
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                  return 'Enter Correct Name';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                fullName = value;
                              },
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Enter your Name",
                                  hintText: "Name"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16), //email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              validator: validateEmail,
                              onChanged: (value) {
                                emailAddress = value;
                              },
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Enter your Email",
                                  hintText: "Email"),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16), //gender
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the Gender';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    gender = value;
                                  },
                                  decoration: textInputDecoration.copyWith(
                                      labelText: "Enter the Gender",
                                      hintText: "Gender"),
                                ),
                              ])),

                      const SizedBox(height: 16), //contact
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                contactNumber = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^(\+91[\s-]?)?(\d{10})$')
                                        .hasMatch(value)) {
                                  return 'Enter Correct Contact';
                                } else {
                                  return null;
                                }
                              },
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Enter your Mobile no.",
                                  hintText: "Contact details"),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16), //building no.
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Building/Block No.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    buildingNo = value;
                                  },
                                  decoration: textInputDecoration.copyWith(
                                      labelText: "Enter Building No.",
                                      hintText: "Building No."),
                                ),
                              ])),

                      SizedBox(height: 16), //district
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the district';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    district = value;
                                  },
                                  decoration: textInputDecoration.copyWith(
                                      labelText: "Enter the district",
                                      hintText: "District"),
                                ),
                              ])),

                      SizedBox(height: 16), //city
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the city';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    city = value;
                                  },
                                  decoration: textInputDecoration.copyWith(
                                      labelText: "Enter the City",
                                      hintText: "City"),
                                ),
                              ])),

                      SizedBox(height: 16), //state
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the state';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    state = value;
                                  },
                                  decoration: textInputDecoration.copyWith(
                                      labelText: "Enter the state",
                                      hintText: "State"),
                                ),
                              ])),

                      SizedBox(height: 16), //pin
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the pin code';
                                    } else if (value.length != 6) {
                                      return 'Pin code must have exactly 6 digits';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    pincode = value;
                                  },
                                  decoration: textInputDecoration.copyWith(
                                      labelText: "Enter the pincode",
                                      hintText: "Pincode"),
                                ),
                              ])),

                      SizedBox(height: 16), //username
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the username';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    username = value;
                                  },
                                  decoration: textInputDecoration.copyWith(
                                      labelText: "Enter the username",
                                      hintText: "Username"),
                                ),
                              ])),

                      const SizedBox(height: 16), //create password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              validator: validatepassword,
                              onChanged: (value) {
                                password = value;
                              },
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Create Password",
                                  hintText: "Create Password"),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16), //confirm password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your Password';
                                } else if (value != password) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              obscureText: true,
                              onChanged: (value) {
                                confirmPassword = value;
                              },
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Confirm the password",
                                  hintText: "Confirm Password"),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Add a spacer
                      const SizedBox(width: 8),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _agreedTo,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _agreedTo = value ?? false;
                                    });
                                  },
                                ),
                                Text(
                                  'I confirm that given information is correct !',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 19),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() && _agreedTo) {
                            // Validation successful, navigate to home page
                            DatabaseService.addBuyer(
                                context,
                                fullName,
                                emailAddress,
                                contactNumber,
                                buildingNo,
                                district,
                                city,
                                state,
                                pincode,
                                username,
                                password);
                            // showSnackBar(context, Colors.green,
                            //     "Buyer registered successfully!");
                            nextScreen(context, LoginPage());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _agreedTo
                                ? Constants.secondaryColor
                                : Colors.grey),
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Container(
                      //   decoration: const BoxDecoration(color: Colors.deepOrangeAccent),
                      //   child: const Center(
                      //     child: Text("Sign In"),
                      //   ),
                      // )
                    ])),
          ),
        ),
      ),
    );
  }
}
