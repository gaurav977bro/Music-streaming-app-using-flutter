import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'HomeScreen.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey[900],
      child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(30),
          ),
          Container(padding: EdgeInsets.all(20), child: FormContent()),
        ],
      ))),
    );
  }
}

class FormContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: 500,
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.pink),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(-15, -20),
                  color: Colors.pinkAccent,
                  blurRadius: 30)
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            )),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            Icon(Icons.my_library_music, color: Colors.pink, size: 50),
            SizedBox(
              height: 30,
            ),
            Text("Login",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic)),
            SizedBox(
              height: 30,
            ),
            TextFormFields(),
            SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}

// TEXT FORM FOR EMAIL AND PASSOWRD
class TextFormFields extends StatefulWidget {
  @override
  _TextFormFieldsState createState() => _TextFormFieldsState();
}

class _TextFormFieldsState extends State<TextFormFields> {
  int _count = 0;

  bool _tapped = false;

  final _formKey = GlobalKey<FormState>();

  verify(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
          border: Border.all(
              color: Colors.pink, style: BorderStyle.solid, width: 4)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
                autovalidate: true,
                validator: MultiValidator([
                  RequiredValidator(errorText: "Required*"),
                  EmailValidator(errorText: "Invalid Email"),
                ]),
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.pink),
                  hintStyle: TextStyle(color: Colors.green),
                  hintText: "Enter your email",
                  labelStyle: TextStyle(color: Colors.green),
                  labelText: "Email",
                )),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              obscureText: _tapped ? false : true,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: _tapped
                    ? Icon(Icons.lock_open_outlined, color: Colors.pink)
                    : Icon(Icons.lock, color: Colors.pink),
                suffix: GestureDetector(
                    child: _tapped
                        ? Icon(Icons.visibility_off, color: Colors.pink)
                        : Icon(Icons.visibility, color: Colors.pink),
                    onTap: () {
                      _count++;

                      if (_count % 2 != 0) {
                        _tapped = true;
                      } else {
                        _tapped = false;
                      }
                      setState(() {});
                    }),
                hintStyle: TextStyle(color: Colors.green),
                labelStyle: TextStyle(color: Colors.green),
                hintText: "Enter you password",
                labelText: "Password",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidate: true,
              validator: MultiValidator([
                RequiredValidator(errorText: "Required*"),
                MinLengthValidator(5, errorText: "Atleast 6 characters"),
                PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                    errorText:
                        'passwords must have at least one special character')
              ]),
            ),
            SizedBox(height: 50),
            ElevatedButton(
                child: Text("Login"),
                onPressed: () => verify(context),
                style: ElevatedButton.styleFrom(minimumSize: Size(100, 40)))
          ],
        ),
      ),
    );
  }
}
