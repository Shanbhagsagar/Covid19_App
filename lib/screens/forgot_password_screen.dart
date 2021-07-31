import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:covid_19/constants.dart';
import 'package:covid_19/components/rounded_button.dart';
import 'package:flutter/services.dart';
import 'package:covid_19/components/validation.dart';

class PasswordRecovery extends StatefulWidget {
  static const String id = 'recovery_screen';
  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final _passRecoveryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _autoEmailValidate = false;
  bool _isLoading = true;
  bool _errorDisplay = false;
  String _errorMessage="Please enter valid email / check your internet connection";

  @override
  void dispose() {
    _passRecoveryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [Colors.yellow, Colors.red]),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _errorDisplay
                      ? Container(
                          color: Colors.amber,
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, left: 3.0),
                                child: Icon(Icons.error_outline),
                              ),
                              Expanded(
                                child: Text(
                                  _errorMessage,
                                  maxLines: 3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      _errorDisplay = false;
                                    });
                                    if(_errorMessage=="Please check your email")
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 20,
                        ),
                  SizedBox(
                    height: 100.0,
                  ),
                  TyperAnimatedTextKit(
                    text: ['Recover'],
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 100.0,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: TextFormField(
                      controller: _passRecoveryController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email'),
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(35),
                        BlacklistingTextInputFormatter.singleLineFormatter,
                      ],
                      onTap: () {
                        setState(() {
                          _autoEmailValidate = true;
                        });
                      },
                      validator: (value) {
                        return Validation.emailValidation(value);
                      },
                      autovalidate: _autoEmailValidate,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _isLoading
                      ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RoundedButton(
                        colour: Colors.redAccent.shade700,
                        title: 'Reset Password',
                        onPressed: () async {
                          FocusScopeNode currentFocus =
                          FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          final email = _passRecoveryController.text.toString().trim();
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = false;
                            });
                            await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => _errorMessage="Please check your email").catchError((e){print(e);});
                            setState(() {
                              _errorMessage;
                              _isLoading = true;
                              _errorDisplay = true;
                            });
                          }
                        },
                      ),
                    ],
                  )
                      : Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.red.shade900),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}