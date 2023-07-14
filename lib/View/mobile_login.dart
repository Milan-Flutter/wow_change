import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wow/View/vrify_login.dart';
import '../constant.dart';

class mobile_login extends StatefulWidget {
  const mobile_login({super.key});

  @override
  State<mobile_login> createState() => _mobile_loginState();
}

class _mobile_loginState extends State<mobile_login> {
  TextEditingController _phoneController = TextEditingController();

  Future<void> check_login() async {
    Response response = await post(
        Uri.parse("https://mechodalgroup.xyz/whoclone/api/check_number.php"),
        body: {'mobile': _phoneController.text.toString()});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String message = data['message'];
      if (message == "Login Successful") {
        String id = data['id'];
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: otp_login(
                  mobile_number: _phoneController.text.toString(),
                  id: id.toString(),
                )));
      } else if (message == "") {
        Fluttertoast.showToast(msg: "This User is Not Registerd.");
      }
    } else {
      Fluttertoast.showToast(msg: "Please try agian");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Image.asset(
                'assets/all.png', // replace with your image path
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .235,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/img_1.png",
                          height: 40,
                          width: 35,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .05,
                        ),
                        Text(
                          "App Logo",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xff111A41),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                    ),
                    Text(
                      "Mobile Login",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "Please enter your valid phone number. We will send you a 6-digit code to verify your account.",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone_android),
                          hintText: '99999 99999',
                          hintStyle:
                              TextStyle(fontSize: 12, color: Color(0xff3F2D20)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: main_color,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color:
                                  main_color, // Set the border color when the TextField is focused
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .08,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: main_color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          if (_phoneController.text.length == 10) {
                            check_login();
                          } else {
                            Fluttertoast.showToast(
                              msg: "Enter Valid Number",
                            );
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .06,
                          width: MediaQuery.of(context).size.width * .75,
                          child: Center(
                            child: Text(
                              'Verify Otp',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
