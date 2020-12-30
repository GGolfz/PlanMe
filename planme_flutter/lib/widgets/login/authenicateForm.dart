import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import './layoutRender.dart';

class AuthenicateForm extends StatefulWidget {
  @override
  _AuthenicateFormState createState() => _AuthenicateFormState();
}

class _AuthenicateFormState extends State<AuthenicateForm> {
  var isLogin = true;
  void _changeState(bool newState) {
    setState(() {
      isLogin = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      child: Column(
        children: [
          isLogin ? LoginForm() : RegisterForm(),
          SizedBox(
            height: 30,
          ),
          stateChanger(isLogin, _changeState)
        ],
      ),
    );
  }
}

Widget stateChanger(bool isLogin, Function changeState) {
  return GestureDetector(
    child: Text(
      isLogin ? "Create Account" : "Login",
      style: landingStateText,
    ),
    onTap: () => changeState(!isLogin),
  );
}

class RegisterForm extends StatelessWidget {
  var _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          customTextField("Email", false),
          SizedBox(
            height: 15,
          ),
          customTextField("Password", true),
          SizedBox(
            height: 25,
          ),
          customButton("REGISTER", () {})
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  var _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          customTextField("Email", false),
          SizedBox(
            height: 15,
          ),
          customTextField("Password", true),
          SizedBox(
            height: 15,
          ),
          renderText("Forget Password ?", landingForgetText),
          SizedBox(
            height: 15,
          ),
          customButton("LOG IN", () {
            Navigator.of(context).pushReplacementNamed('/calendar');
          })
        ],
      ),
    );
  }
}

Widget customButton(String text, Function handleClick) {
  return GestureDetector(
    onTap: handleClick,
    child: Container(
      child: Text(
        text,
        style: landingButtonText,
      ),
      width: 130,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10)),
    ),
  );
}

Widget customTextField(String text, bool isPassword) {
  return TextFormField(
    style: TextStyle(fontSize: 16),
    obscureText: isPassword,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        hintText: text,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                style: BorderStyle.solid, width: 2, color: Color(0xFFEBEBEB))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                style: BorderStyle.solid, width: 2, color: Color(0xFFEBEBEB))),
        fillColor: Colors.white,
        filled: true),
  );
}
