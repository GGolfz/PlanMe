import 'package:flutter/material.dart';
import 'package:planme_flutter/configs/color.dart';
import 'package:planme_flutter/configs/fontStyle.dart';
import 'package:planme_flutter/model/authenicateException.dart';
import 'package:planme_flutter/widgets/achievement/achievement_alert.dart';
import 'package:provider/provider.dart';
import 'package:planme_flutter/providers/authenicateProvider.dart';
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
          LoginForm(isLogin),
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

class LoginForm extends StatefulWidget {
  final bool isLogin;
  LoginForm(this.isLogin);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _form = GlobalKey<FormState>();

  var _passwordFocusNode = FocusNode();

  UserInfo userInfo = UserInfo(email: '', password: '');
  var emailError;
  var passwordError;
  var isLoading = false;
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    setState(() {
      isLoading = true;
    });
    _form.currentState.save();
    List<dynamic> alert;
    try {
      if (widget.isLogin) {
        alert = await Provider.of<Authenicate>(context, listen: false)
            .login(userInfo);
      } else {
        alert = await Provider.of<Authenicate>(context, listen: false)
            .register(userInfo);
      }
      Navigator.of(context).pushReplacementNamed('/calendar');
      if (alert != null && alert.length > 0) {
        showDialog(
            context: context,
            builder: (ctx) => AchievementAlert(
                alert.length > 1 ? alert.sublist(1) : [],
                alert[0]['level_name'],
                alert[0]['level_img']));
      }
      setState(() {
        emailError = null;
        passwordError = null;
        isLoading = false;
      });
    } on AuthenicateException catch (error) {
      setState(() {
        emailError = error.emailError;
        passwordError = error.passwordError;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          customTextField(
              context, "Email", false, emailError, _passwordFocusNode, null,
              (value) {
            userInfo = UserInfo(email: value, password: userInfo.password);
          }, TextInputAction.next),
          SizedBox(
            height: 15,
          ),
          customTextField(context, "Password", true, passwordError, null,
              _passwordFocusNode, (value) {
            userInfo = UserInfo(email: userInfo.email, password: value);
          }, TextInputAction.done),
          SizedBox(
            height: 25,
          ),
          customButton(
              isLoading
                  ? CircularProgressIndicator()
                  : renderText(widget.isLogin ? "Log In" : "Register",
                      landingButtonText),
              isLoading ? null : _saveForm)
        ],
      ),
    );
  }
}

Widget customButton(Widget child, Function handleClick) {
  return GestureDetector(
    onTap: handleClick,
    child: Container(
      child: child,
      width: 130,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(10)),
    ),
  );
}

Widget customTextField(
    BuildContext context,
    String text,
    bool isPassword,
    String errorText,
    FocusNode focusNode,
    FocusNode currentFocusNode,
    Function onSave,
    TextInputAction action) {
  var borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
          style: BorderStyle.solid, width: 2, color: Color(0xFFEBEBEB)));
  return TextFormField(
    style: TextStyle(fontSize: 16),
    obscureText: isPassword,
    textInputAction: action,
    onFieldSubmitted: (_) {
      if (focusNode != null) {
        FocusScope.of(context).requestFocus(focusNode);
      }
    },
    focusNode: currentFocusNode,
    onSaved: onSave,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        hintText: text,
        errorText: errorText,
        errorBorder: borderStyle,
        focusedErrorBorder: borderStyle,
        enabledBorder: borderStyle,
        focusedBorder: borderStyle,
        fillColor: Colors.white,
        filled: true),
  );
}
