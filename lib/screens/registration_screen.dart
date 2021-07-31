import 'package:covid_19/components/navigator_menu.dart';
import 'package:covid_19/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:covid_19/components/rounded_button.dart';
import 'package:flutter/services.dart';
import 'package:covid_19/components/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController(text: UserData.logindata.getString('email'));
  final _addressController = TextEditingController(text: UserData.logindata.getString('userAddress'));
  final _dobController = TextEditingController(text: UserData.logindata.getString('userDOB'));
  final _passController = TextEditingController();
  final _passConfirmController = TextEditingController();
  final _nameController = TextEditingController(text: UserData.logindata.getString('name'));
  final _formKey = GlobalKey<FormState>();
  static String _currentDate = "2002-12-31";
  static String _userAddress;
  static String _userGender;
  static List<String> _todayList = DateTime.now().toString().split(' ')[0].split('-');
  static String _maxDate=(int.parse(_todayList[0])-18).toString()+'-12-31';
  static String _minDate=(int.parse(_todayList[0])-100).toString()+'-01-01';
  bool _autoEmailValidate = false;
  bool _autoAddressValidate = false;
  bool _autoPasswordValidate = false;
  bool _autoNameValidate = false;
  bool _autoDobValidate = false;
  bool _isLoading = true;
  bool _errorDisplay = false;
  bool _lockNLoaded = false;
  bool isUpdate = false;
  String _errorMessage;
  bool _passwordVisible;
  bool _checkBoxV;
  int selectedRadioTile;

  @override
  void initState() {
    _passwordVisible = true;
    _checkBoxV = false;
    selectedRadioTile =UserData.logindata.getString('userGender')=='Male'?1:2;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _passConfirmController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Map<String, dynamic> userData = {
    "isNewUser": true,
    "isInfected": null,
    "userDOB": _currentDate,
    "userAddress": _userAddress,
    "userGender": _userGender
  };

  Future<bool> registerUser(String email, String pass, String name) async {
    setState(() {
      _isLoading = false;
    });
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser user = result.user;
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = name;
      user.updateProfile(info);
      CollectionReference collectionReference =
          Firestore.instance.collection('users');
      collectionReference.document('${user.uid}').setData(userData);
      user.sendEmailVerification();
      _isLoading = true;
      return true;
    } on PlatformException catch (e) {
      if (e.code == "ERROR_NETWORK_REQUEST_FAILED") {
        _errorMessage = "No internet access found on device";
      } else {
        _errorMessage = "Email already registered, please try again";
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

  Future<bool> updateUser(String email, String pass, String name) async {
    setState(() {
      _isLoading = false;
    });
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      _auth.currentUser();
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: UserData.logindata.getString('email'),
          password: UserData.logindata.getString('pass'));
      FirebaseUser user = result.user;
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = name;
      await user.updateProfile(info).then((value) => print(user.displayName));
      await user.updateEmail(email).then((value) => print('email updated'));
      await user.updatePassword(pass).then((value) => print('pass updated'));
      await currentUserLogout(context);
      if (user.isEmailVerified == false)
       await user
            .sendEmailVerification()
            .then((value) => print('email verify sent'));
      _isLoading = true;
      return true;
    } on PlatformException catch (e) {
      if (e.code == "ERROR_NETWORK_REQUEST_FAILED") {
        _errorMessage = "No internet access found on device";
      } else {
        _errorMessage = "Email already registered, please try again";
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

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UpdateArgs args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      isUpdate = true;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
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
                                    _lockNLoaded
                                        ? Navigator.popAndPushNamed(
                                            context, LoginScreen.id)
                                        : setState(() {
                                            _errorDisplay = false;
                                            _errorMessage = "";
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
                    height: 20.0,
                  ),
                  TyperAnimatedTextKit(
                    text: isUpdate ? ['Update'] : ['Registration'],
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 70.0,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your full name'),
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(45),
                        BlacklistingTextInputFormatter.singleLineFormatter,
                      ],
                      onTap: () {
                        setState(() {
                          _autoNameValidate = true;
                        });
                      },
                      validator: (value) {
                        return Validation.nameValidation(value);
                      },
                      autovalidate: _autoNameValidate,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
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
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.multiline,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your address'),
                      onTap: () {
                        setState(() {
                          _autoAddressValidate = true;
                        });
                      },
                      validator: (value) {
                        return Validation.addressValidation(value);
                      },
                      autovalidate: _autoAddressValidate,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: TextFormField(
                      readOnly: true,
                      controller: _dobController,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your DOB'),
                      onTap: () {
                        try {
                          setState(() {
                            showDatePicker(
                              context: context,
                              confirmText: 'Select Date of Birth',
                              initialDate: DateTime.parse(_currentDate),
                              firstDate: DateTime.parse(_minDate),
                              lastDate: DateTime.parse(_maxDate),
                            ).then((value) {
                              setState(() {
                                _currentDate = value.toString().split(' ')[0];
                                _dobController.text = _currentDate;
                              });
                            });
                            _autoDobValidate = true;
                          });
                        } catch (e) {
                          setState(() {
                            _currentDate = "2002-12-31";
                            _dobController.text = _currentDate;
                          });
                        }
                      },
                      validator: (value) {
                        return Validation.dobValidation(value);
                      },
                      autovalidate: _autoDobValidate,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: TextFormField(
                      controller: _passController,
                      obscureText: _passwordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password'),
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
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: TextFormField(
                      controller: _passConfirmController,
                      obscureText: _passwordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Confirm your password'),
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
                        return Validation.passwordConfirmValidation(
                            value, _passController.text);
                      },
                      autovalidate: _autoPasswordValidate,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: RadioListTile(
                            value: 1,
                            groupValue: selectedRadioTile,
                            title: Text("Male"),
                            onChanged: (val) {
                              setSelectedRadioTile(val);
                            },
                            activeColor: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: RadioListTile(
                            value: 2,
                            groupValue: selectedRadioTile,
                            title: Text("Female"),
                            onChanged: (val) {
                              setSelectedRadioTile(val);
                            },
                            activeColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CheckboxListTile(
                    title: Text("Show Password"),
                    activeColor: Colors.red[900],
                    value: _checkBoxV,
                    onChanged: (newValue) {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                        _checkBoxV = !_checkBoxV;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  _isLoading
                      ? isUpdate
                          ? RoundedButton(
                              colour: Colors.redAccent.shade700,
                              title: 'Update',
                              onPressed: () async {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                final email =
                                    _emailController.text.toString().trim();
                                final pass =
                                    _passController.text.toString().trim();
                                final name =
                                    _nameController.text.toString().trim();
                                _userAddress =
                                _addressController.text.toString().trim();
                                _currentDate=
                                _dobController.text.toString().trim();
                                _userGender=
                                selectedRadioTile==1?'Male':'Female';
                                Map<String, dynamic> dbData = {
                                  "userDOB": _currentDate,
                                  "userAddress": _userAddress,
                                  "userGender": _userGender
                                };
                                userData.addAll(dbData);
                                if (_formKey.currentState.validate()) {
                                  CollectionReference collectionReference = Firestore.instance.collection('users');
                                  await collectionReference.document(UserData.logindata.getString('uid')).setData(userData,merge: false);
                                  bool result =
                                      await updateUser(email, pass, name);
                                  if (result) {
                                    setState(() {
                                      _lockNLoaded = true;
                                    });
                                  } else {
                                    print('Error');
                                  }
                                }
                              },
                            )
                          : RoundedButton(
                              colour: Colors.redAccent.shade700,
                              title: 'Register',
                              onPressed: () async {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                final email =
                                    _emailController.text.toString().trim();
                                final pass =
                                    _passController.text.toString().trim();
                                final name =
                                    _nameController.text.toString().trim();
                                _userAddress =
                                    _addressController.text.toString().trim();
                                _currentDate=
                                    _dobController.text.toString().trim();
                                _userGender=
                                selectedRadioTile==1?'Male':'Female';
                                Map<String, dynamic> dbData = {
                                  "userDOB": _currentDate,
                                  "userAddress": _userAddress,
                                  "userGender": _userGender
                                };
                                userData.addAll(dbData);
                                print(userData);
                                if (_formKey.currentState.validate()) {
                                  bool result =
                                      await registerUser(email, pass, name);
                                  if (result) {
                                    setState(() {
                                      _errorMessage =
                                          "Email verification sent on registered email";
                                      _errorDisplay = true;
                                      _lockNLoaded = true;
                                    });
                                  } else {
                                    print('Error');
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
