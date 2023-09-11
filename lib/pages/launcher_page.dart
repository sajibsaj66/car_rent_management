import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'signin_option_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/';

  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    // TODO: implement initState
    redirectUser();
    super.initState();
  }

  Future<void> redirectUser() async {
    /*if (await getLoginStatus()) {
      final id = await getUserId();
      await Provider.of<UserProvider>(context, listen: false).getUserById(id);
      Navigator.pushReplacementNamed(context, MovieListPage.routeName);
    } else {

    }*/
    await Navigator.pushReplacementNamed(context, SigninOptionPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


}
