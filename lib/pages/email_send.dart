import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailSend extends StatefulWidget {
  const EmailSend({Key? key}) : super(key: key);

  @override
  State<EmailSend> createState() => _MainPageState();
}

class _MainPageState extends State<EmailSend> {
  Future sendEmail() async {
    final user = await GoogleAuthApi.signIn();
    if (user == null) return;
    final email = 'khaledkandli55@gmail.com';
    final auth = await user.authentication;
    final accessToken = '';
    final smptServer = gmailSaslXoauth2(email, accessToken);
    final message = Message()
      ..from = Address(email, 'Khaled')
      ..recipients = ['khaledkandli55@gmail.com']
      ..subject = 'Hello'
      ..text = 'this is atext email';
    try {
      await send(message, smptServer);
      showSnackBar('sent successfully');
    } on MailerException catch (erorr) {
      print(erorr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('email'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Send Email"),
          onPressed: () {
            sendEmail();
          },
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

class GoogleAuthApi {
  static final _googleSignIn =
  GoogleSignIn(scopes: ['https://mail.google.com/']);
  static Future<GoogleSignInAccount?> signIn() async {
    if (await _googleSignIn.isSignedIn()) {
      return _googleSignIn.currentUser;
    } else {
      return await _googleSignIn.signIn();
    }
  }
}