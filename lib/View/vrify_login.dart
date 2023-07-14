import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import 'bottom_navigation.dart';

class otp_login extends StatefulWidget
{
  const otp_login({super.key, required this.mobile_number, required this.id});
  final String? mobile_number;
  final String? id;
  @override
  State<otp_login> createState() => _otp_loginState();
}

class _otp_loginState extends State<otp_login> {


  String? code;
  String? vid;
  String? _verificationId;
  OtpFieldController _otpController = OtpFieldController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> signInWithPhoneNumber(String phoneNumber) async
  {
    String? verificationId;
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieve the SMS code and sign in the user
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Failed to verify phone number: ${e.message}');
      },
      codeSent: (String id, int? resendToken) {
        // Save the verification ID to use later
        verificationId = id;
        setState(() {
          _verificationId = id;
        });
      },
      codeAutoRetrievalTimeout: (String id) {
        // Auto-retrieval timed out, handle the error here
      },
    );
    return verificationId;
  }

  Future<void> _signInWithOTP() async {
    if (_verificationId != null && code!.isNotEmpty) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: _verificationId!, smsCode: code.toString());
        await FirebaseAuth.instance.signInWithCredential(credential);
        Fluttertoast.showToast(msg: "OTP Valid Successful");

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool("isLogin", true);
        sharedPreferences.setString("user", "user");
        sharedPreferences.setString("user_id", widget.id.toString());
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => botttom_navigate(status: '1')));
        Fluttertoast.showToast(msg: "Login Successful");
      } on FirebaseAuthException catch (e) {
        print('Failed to sign in with OTP: ${e.message}');
        Fluttertoast.showToast(msg: "Please Enter Valid Otp");
      }
    }
  }

  void otp(String otpcode) {
    setState(() {
      code = otpcode.toString();
      print("rrss" + code.toString());
    });
  }

  @override
  void initState()
  {
    print(widget.mobile_number);
    signInWithPhoneNumber("+91" + widget.mobile_number.toString());
    super.initState();
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
                      height: MediaQuery.of(context).size.height * .234,
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
                      height: MediaQuery.of(context).size.height * .19,
                    ),
                    Text(
                      "OTP Verification",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "Type the verification code we’ve sent you",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .07,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .9,
                      child: OTPTextField(
                        controller: _otpController,
                        length: 6,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 45,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.box,
                        onCompleted: otp,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .015,
                    ),
                    InkWell(
                      onTap: () {
                        signInWithPhoneNumber(
                            "+91" + widget.mobile_number.toString());
                      },
                      child: InkWell(
                        onTap: () {
                          signInWithPhoneNumber(
                              "+91" + widget.mobile_number.toString());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "I didn’t get the ",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff73665C)),
                            ),
                            Text(
                              "Code",
                              style: TextStyle(fontSize: 12, color: main_color),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: main_color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          onPressed: () async {
                            _signInWithOTP();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * .06,
                            width: MediaQuery.of(context).size.width * .75,
                            child: Center(
                              child: Text(
                                'Login',
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
