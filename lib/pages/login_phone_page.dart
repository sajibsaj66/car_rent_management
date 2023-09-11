import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/helper_functions.dart';
import 'signin_option_page.dart';
import 'user_dashboard_page.dart';

class LoginPhonePage extends StatefulWidget {
  static const String routeName = '/loginPhone';

  const LoginPhonePage({Key? key}) : super(key: key);

  @override
  State<LoginPhonePage> createState() => _LoginPhonePageState();
}

class _LoginPhonePageState extends State<LoginPhonePage> {
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  bool submit = false;
  String errMsg = '';
  bool obscureText = true;
  bool isLogin = false;
  String loginOption = 'phone';

  @override
  void dispose() {
    // TODO: implement dispose
    phoneController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController.addListener(() {
      setState(() {
        if (phoneController.text.length == 11 &&
            passController.text.length == 6) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });

    passController.addListener(() {
      setState(() {
        if (phoneController.text.length == 11 &&
            passController.text.length == 6) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, SigninOptionPage.routeName);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            //replace with our own icon data.
          )),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('Continue with your phone number',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4c505b),
                        fontSize: 18,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  maxLength: 11,
                                  cursorColor: Color(0xff9F2B68),
                                  cursorHeight: 30,
                                  autofocus: true,
                                  keyboardType: TextInputType.number,
                                  controller: phoneController,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    labelStyle:
                                        TextStyle(color: Color(0xff9F2B68)),
                                    //prefixText: '+88',
                                    prefixIcon: const Icon(Icons.phone),
                                    /*prefixIconConstraints:
                                        BoxConstraints(maxWidth: 100),*/
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    //hintText: "Phone Number",
                                    /*focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),*/
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: const BorderSide(
                                            color: Color(0xff9F2B68), width: 1)),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length != 11) {
                                      return 'Please fill up valid phone number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: obscureText,
                                  controller: passController,
                                  maxLength: 6,
                                  cursorColor: Color(0xff9F2B68),
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle:
                                          TextStyle(color: Color(0xff9F2B68)),
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            obscureText = !obscureText;
                                          });
                                        },
                                        icon: Icon(obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                      ),
                                      //hintText: 'Password',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                              color: Color(0xff9F2B68),
                                              width: 1))),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length != 6) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 400,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xff9F2B68)),
                                    onPressed: (submit)
                                        ? () {
                                            //print(isLogin);
                                            isLogin = true;
                                            //print(isLogin);
                                            _authenticate();
                                          }
                                        : null,
                                    child: Text('Continue'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                errMsg,
                                style: const TextStyle(fontSize: 18),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _authenticate() async {
    //print(isLogin);
    final provider = Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      //print(1);
      final phone = phoneController.text;
      final pass = passController.text;
      final user = await provider.getUserByMobile(phone);
      //print(user);
      if (isLogin) {
        if (user == null) {
          _setErrorMsg('User does not exist');
        } else {
          //check password
          if (pass == user.password) {
            await setLoginStatus(true);
            await setUserId(user.userId!);
            if (mounted)
              Navigator.pushReplacementNamed(
                  context, UserDashboardPage.routeName,
                  arguments: [user]);
          } else {
            //password did not match
            _setErrorMsg('Wrong password');
          }
        }
      }
    }
  }

  _setErrorMsg(String msg) {
    setState(() {
      errMsg = msg;
    });
  }
}
