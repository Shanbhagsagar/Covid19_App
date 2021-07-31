import 'package:covid_19/screens/forgot_password_screen.dart';
import 'package:covid_19/screens/home_screen.dart';
import 'package:covid_19/screens/onboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:covid_19/constants.dart';
import 'package:covid_19/components/rounded_button.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'package:covid_19/components/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _autoEmailValidate = false;
  bool _autoPasswordValidate = false;
  bool _isLoading = true;
  bool _errorDisplay = false;
  bool _emailIsVerified = false;
  String _errorMessage;
  final db = Firestore.instance;
  bool _passwordVisible;
  bool _checkBoxV;

  @override
  void initState() {
    _passwordVisible = true;
    _checkBoxV = false;
    super.initState();
  }


  @override
  void dispose() {
    _passController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<FirebaseUser> login(String email, String pass) async {
    setState(() {
      _isLoading = false;
    });
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      user.isEmailVerified?_emailIsVerified=true:user.sendEmailVerification();
      return user;
    } on PlatformException catch (e) {
      if (e.code == "ERROR_NETWORK_REQUEST_FAILED") {
        _errorMessage = "No internet access";
      } else {
        _errorMessage = "Invalid email/password. Please try again";
      }
      setState(() {
        _errorMessage;
        _isLoading = true;
        _errorDisplay = true;
      });
      print(e);
      return null;
    } on Exception catch (e) {
      print(e);
      return null;
    }
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
                    height: 80.0,
                  ),
                  TyperAnimatedTextKit(
                    text: ['Login'],
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
                      controller: _emailController,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: TextFormField(
                      controller: _passController,
                      obscureText:  _passwordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter password'),
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(35),
                        BlacklistingTextInputFormatter.singleLineFormatter,
                      ],
                      onTap: () {
                        setState(() {
                          _autoPasswordValidate = true;
                        });
                      },
                      validator: (value) {
                        return Validation.passwordValidation(value);
                      },
                      autovalidate: _autoPasswordValidate,
                      enableInteractiveSelection: false,
                    ),
                  ),
                  CheckboxListTile(
                    title: Text("Show Password"),
                    activeColor:Colors.red[900],
                    value: _checkBoxV,
                    onChanged: (newValue) {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                        _checkBoxV = !_checkBoxV;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  ),
                  _isLoading
                      ? RoundedButton(
                          colour: Colors.redAccent.shade700,
                          title: 'Login',
                          onPressed: () async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            final email =
                                _emailController.text.toString().trim();
                            final pass = _passController.text.toString().trim();
                            if (_formKey.currentState.validate()) {
                              FirebaseUser user = await login(email, pass);
                              if (user != null) {
                                if (_emailIsVerified)
                                  {
                                    DocumentSnapshot documentReference = await db.collection('users').document(user.uid).get();
                                    UserData.logindata.setBool('userexist', true);
                                    UserData.logindata.setString('email', email);
                                    UserData.logindata.setString('uid', user.uid);
                                    UserData.logindata.setString('name', user.displayName);
                                    UserData.logindata.setString('pass', pass);
                                    UserData.logindata.setString('userAddress', documentReference['userAddress']);
                                    UserData.logindata.setString('userDOB', documentReference['userDOB']);
                                    UserData.logindata.setString('userGender', documentReference['userGender']);
                                    documentReference.data['isNewUser']?true:UserData.logindata.setBool('isinfected', documentReference.data['isInfected']);
                                    documentReference.data['isNewUser']?
                                    Navigator.pushNamedAndRemoveUntil(context, OnboardingScreen.id, (Route<dynamic> route) => false):
                                    Navigator.pushNamedAndRemoveUntil(context, HomeSreen.id, (Route<dynamic> route) => false);
                                  }
                                else {
                                  setState(() {
                                    _errorMessage =
                                        "Email not verified re-verification email sent, please re-verify";
                                    _errorDisplay = true;
                                    _isLoading = true;
                                  });
                                }
                              } else {
                                print("Error on login");
                              }
                            }
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.red.shade900),
                          ),
                        ),
                  _isLoading
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                              child: Center(
                                child: Text(
                                  'Recover Account',
                                ),
                              ),
                            shape: Border(
                              top: BorderSide(color: Colors.yellow),
                              bottom: BorderSide(color: Colors.yellow),
                            ),
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, PasswordRecovery.id);
                              },
                            ),
                        ],
                      )
                      : Center(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
