import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'email_send.dart';
import 'login_phone_page.dart';

class OtpVerificationPage extends StatefulWidget {
  static const String routeName = '/otpVerification';

  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, LoginPhonePage.routeName);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            //replace with our own icon data.
          )),
      body: Container(
        child: OtpTextField(
          numberOfFields: 6,
          borderColor: Color(0xff9F2B68),
          autoFocus: true,
          cursorColor: Color(0xff9F2B68),
          //set to true to show as box or false to show as dash
          showFieldAsBox: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here
          },
          //runs when every textfield is filled
          onSubmit: (String verificationCode) async {
            if (verificationCode == '123456') {
              final user = await GoogleAuthApi.signIn();
              if (user == null) return;
              final email = 'mmohan2005@gmail.com';
              final auth = await user.authentication;
              final accessToken = '';
              final smptServer = gmailSaslXoauth2(email, accessToken);
              final message = Message()
                ..from = Address(email, 'Khaled')
                ..recipients = ['naazmul2020@gmail.com']
                ..subject = 'Hello'
                ..text = 'this is a test email';
              try {
                await send(message, smptServer);
                showSnackBar('sent successfully');
              } on MailerException catch (erorr) {
                print(erorr);
              }

              /*showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Alert'),
                      content: Text('$result ||$msg'),
                    );
                  });*/


              /*final Email email = Email(
                body: verificationCode,
                subject: 'test otp flutter',
                recipients: ['naazmul2020@gmail.com'],
                cc: ['mmohan2005@gmail.com'],
                //bcc: ['bcc@example.com'],
                //attachmentPaths: ['/path/to/attachment.zip'],
                isHTML: false,
              );

              await FlutterEmailSender.send(email);*/

              /*SmsStatus result = await BackgroundSms.sendMessage(
                  phoneNumber: "+8801842378006", message: "test otp", simSlot: 1);
              print(SmsStatus.sent);
              print(result);
              var msg = SmsStatus.sent;*/
              /*if (result == SmsStatus.sent) {
                Navigator.popAndPushNamed(context, SigninOptionPage.routeName);
              } else {
                Navigator.popAndPushNamed(context, LoginEmailPage.routeName);
              }*/

              /*showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Alert'),
                      content: Text('$result ||$msg'),
                    );
                  });*/

              //Navigator.popAndPushNamed(context, SigninOptionPage.routeName);

            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Alert'),
                      content: Text('Invalid OTP'),
                    );
                  });
            }
            /*showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Verification Code"),
                    content: Text('Code entered is $verificationCode'),
                  );
                },);*/
          }, // end onSubmit
        ),
      ),
    );
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
