import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admin_login_page.dart';
import 'login_email_page.dart';
import 'login_phone_page.dart';

class SigninOptionPage extends StatefulWidget {
  static const String routeName = '/signinOption';

  const SigninOptionPage({Key? key}) : super(key: key);

  @override
  State<SigninOptionPage> createState() => _SigninOptionPageState();
}

class _SigninOptionPageState extends State<SigninOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/signin_option.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(),
              Container(
                padding: const EdgeInsets.only(left: 35, top: 110),
                child: const Text(
                  'Car Renting ',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              const Text('''Hire reliable service experts for
               your home & office.''',
                  style: TextStyle(
                    color: Color(0xff4c505b),
                    fontSize: 18,
                  )),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff9F2B68)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginPhonePage.routeName);
                      },
                      icon: const Icon(CupertinoIcons.phone),
                      label: const Text('Continue with Phone')),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('or Connect with',
                  style: TextStyle(
                    color: Color(0xff4c505b),
                    fontSize: 18,
                  )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff9F2B68)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginEmailPage.routeName);
                      },
                      icon: const Icon(CupertinoIcons.mail),
                      label: const Text('Continue with Email')),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  //width: 400,
                  child: TextButton.icon(
                      /*style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Color(0xff9F2B68)),
                      ),*/
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AdminLoginPage.routeName);
                      },
                      icon: const Icon(CupertinoIcons.person_2_fill),
                      label: const Text('Admin Login')),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'By logging or registering, yor agree to our\n',
                            style: Theme.of(context).textTheme.bodySmall,
                            children: <InlineSpan>[
                              WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      //minimumSize: const Size(0, 0),
                                      textStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    onPressed: () {},
                                    child: const Text('Terms and Services'),
                                  )),
                              const TextSpan(text: ' and '),
                              WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      //minimumSize: Size.zero,
                                      textStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    onPressed: () {},
                                    child: const Text('Privacy Policy'),
                                  )),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
