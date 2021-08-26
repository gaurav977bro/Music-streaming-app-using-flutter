import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:form_field_validator/form_field_validator.dart';

import 'HomeScreen.dart';

enum MobileVerificationState {
  SHOW_PHONENUMBER_PAGE,
  SHOW_OTP_PAGE,
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  final numberController = TextEditingController();
  final otpController = TextEditingController();
  bool showLoading = false;

  var VerificationId;

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_PHONENUMBER_PAGE;

  void signWithCredential(AuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    } on FirebaseException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getLogin(context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 200, left: 20, right: 20),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(10, 10),
                              color: Colors.black,
                              blurRadius: 20)
                        ],
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text("Phone Verification",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Correct Format = [+][Country-code][number]",
                              style: TextStyle(color: Colors.blue)),
                          SizedBox(height: 25),
                          TextFormField(
                            controller: numberController,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot be empty*"),
                              MinLengthValidator(10,
                                  errorText: "Must be 10 digits"),
                            ]),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: "Enter Phone Number",
                            ),
                          ),
                          SizedBox(height: 25),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  showLoading = true;
                                  await _auth.verifyPhoneNumber(
                                      //1
                                      phoneNumber: numberController.text,
                                      //2
                                      verificationCompleted:
                                          (phoneAuthCredential) async {
                                        setState(() {
                                          showLoading = false;
                                        });
                                        //signWithCredential(phoneAuthCredential);
                                      },
                                      //3
                                      verificationFailed:
                                          (phoneVerificationFailed) {
                                        setState(() {
                                          showLoading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    phoneVerificationFailed
                                                        .message)));
                                      },
                                      //4
                                      codeSent: (verificationId,
                                          resendingToken) async {
                                        setState(() {
                                          showLoading = false;
                                          currentState = MobileVerificationState
                                              .SHOW_OTP_PAGE;
                                          this.VerificationId = verificationId;
                                        });
                                      },
                                      //5
                                      codeAutoRetrievalTimeout:
                                          (verificationId) async {});
                                }
                              },
                              child: Text("Send OTP")),
                        ],
                      ),
                    )))));
  }

  getOtp(context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 200, left: 20, right: 20),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(10, 10),
                              color: Colors.black,
                              blurRadius: 20)
                        ],
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text("OTP Verification",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          SizedBox(height: 25),
                          TextFormField(
                            controller: otpController,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot be empty*"),
                            ]),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: "Enter OTP",
                            ),
                          ),
                          SizedBox(height: 25),
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  AuthCredential phoneAuthCredential =
                                      PhoneAuthProvider.credential(
                                          verificationId: this.VerificationId,
                                          smsCode: otpController.text);

                                  signWithCredential(phoneAuthCredential);
                                }
                              },
                              child: Text("Verify OTP")),
                        ],
                      ),
                    )))));
  }

  @override
  Widget build(BuildContext context) {
    return showLoading
        ? Center(child: CircularProgressIndicator())
        : currentState == MobileVerificationState.SHOW_PHONENUMBER_PAGE
            ? getLogin(context)
            : getOtp(context);
  }
}
