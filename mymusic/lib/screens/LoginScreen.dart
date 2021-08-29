import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:form_field_validator/form_field_validator.dart';

import 'HomeScreen.dart';

void main() {
  runApp(Login());
}

enum MobileVerificationState {
  Show_login,
  show_otp,
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();

  MobileVerificationState currentState = MobileVerificationState.Show_login;

  FirebaseAuth _auth = FirebaseAuth.instance;

  var phoneController = TextEditingController();
  var otpController = TextEditingController();
  var VerificationId;

  bool showLoading = false;
  bool tapped = false;

// For verification after OTP is revieved
  void signIn(AuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      var _authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
        ;
      });
      if (_authCredential != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    } on FirebaseException catch (e) {
      setState(() {
        showLoading = false;
        ;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    }
  }

  // Page show to take phone number
  getLogin(context) {
    return Container(
      child: Form(
        key: _key,
        child: Column(
          children: [
            Text("Phone Verification",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Format => [+] [country code] [phone number]",
                style: TextStyle(color: Colors.black, fontSize: 15)),
            SizedBox(height: 30),
            TextFormField(
              controller: phoneController,
              autovalidate: true,
              validator: MultiValidator([
                RequiredValidator(errorText: "Required*"),
                MinLengthValidator(10, errorText: "Invalid Phone number*")
              ]),
              decoration: InputDecoration(
                  hintText: "Phone number",
                  labelText: "Number",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 10),
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 8, shadowColor: Colors.black),
              child: tapped ? Icon(Icons.check) : Text("Send OTP"),
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  setState(() {
                    showLoading = true;
                    tapped = true;
                  });
                  ;

                  await _auth.verifyPhoneNumber(
                      // 1
                      phoneNumber: phoneController.text,
                      // 2
                      verificationCompleted: (phoneAuthCredential) async {
                        setState(() {
                          showLoading = false;
                        });
                      },
                      // 3
                      verificationFailed: (verificationFailed) async {
                        setState(() {
                          showLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(verificationFailed.message),
                        ));
                      },
                      // 4
                      codeSent: (verificationId, resendingToken) async {
                        setState(() {
                          showLoading = false;
                          currentState = MobileVerificationState.show_otp;
                          this.VerificationId = verificationId;
                        });
                      },
                      // 5
                      codeAutoRetrievalTimeout: (phoneAuthCredential) async {});
                }
              },
            )
          ],
        ),
      ),
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(10, 20), blurRadius: 20)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
    );
  }

  // Page showed after recieving OTP
  getOtp(context) {
    return Container(
      child: Column(
        children: [
          Text("OTP Verification",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          TextFormField(
            controller: otpController,
            validator: MultiValidator([
              RequiredValidator(errorText: "Required*"),
            ]),
            decoration: InputDecoration(
                hintText: "Enter OTP",
                labelText: "OTP",
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 10),
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 8, shadowColor: Colors.black),
            child: Text("Verify OTP"),
            onPressed: () async {
              AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                  verificationId: VerificationId, smsCode: otpController.text);

              signIn(phoneAuthCredential);
            },
          )
        ],
      ),
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(10, 20), blurRadius: 20)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            child: SafeArea(
                child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 150, left: 20, right: 20),
              child: Container(
                  child: showLoading
                      ? Center(child: CircularProgressIndicator())
                      : currentState == MobileVerificationState.Show_login
                          ? getLogin(context)
                          : getOtp(context)),
            ))));
  }
}
