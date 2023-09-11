import 'package:car_rent_management/pages/signin_option_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/admin_provider.dart';
import '../utils/helper_functions.dart';
import 'admin_dashboard_page.dart';

class AdminLoginPage extends StatefulWidget {
  static const String routeName = '/adminLogin';

  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool submit = false;
  String errMsg = '';
  bool obscureText = true;
  bool isLogin = false;
  String loginOption = 'email';

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener(() {
      setState(() {
        if ((emailController.text.contains('@') &&
                emailController.text.contains('.com')) &&
            passController.text.length == 6) {
          submit = true;
        } else {
          submit = false;
        }
      });
    });

    passController.addListener(() {
      setState(() {
        if ((emailController.text.contains('@') &&
                emailController.text.contains('.com')) &&
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
      body: Container(
        child: Column(
          children: [
            Container(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Continue with your email',
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
                                cursorColor: Color(0xff9F2B68),
                                cursorHeight: 30,
                                autofocus: true,
                                controller: emailController,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle:
                                      TextStyle(color: Color(0xff9F2B68)),
                                  //prefixText: '+88',
                                  prefixIcon: const Icon(Icons.email),
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
                                  if (value == null || value.isEmpty) {
                                    return 'Please fill up valid email';
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
    );
  }

  void _authenticate() async {
    //print(isLogin);
    final provider = Provider.of<AdminProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      //print(1);
      final email = emailController.text;
      final pass = passController.text;
      final userAdmin = await provider.getAdminUserByEmail(email);
      //print(userAdmin);
      if (isLogin) {
        if (userAdmin == null) {
          _setErrorMsg('User does not exist');
        } else {
          //check password
          if (pass == userAdmin.password) {
            await setLoginStatus(true);
            await setUserId(userAdmin.adminId!);
            if (mounted)
              Navigator.pushReplacementNamed(
                  context, AdminDashboardPage.routeName,
                  arguments: [userAdmin]);
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
