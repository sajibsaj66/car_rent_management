import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/admin_model.dart';
import '../models/driver_model.dart';
import '../providers/admin_provider.dart';
import '../providers/driver_provider.dart';
import '../providers/user_provider.dart';
import '../utils/helper_functions.dart';
import 'driver_details_page.dart';
import 'signin_option_page.dart';

class DriverListPage extends StatefulWidget {
  static const String routeName = '/driverList';

  const DriverListPage({Key? key}) : super(key: key);

  @override
  State<DriverListPage> createState() => _DriverListPageState();
}

class _DriverListPageState extends State<DriverListPage> {
  late DriverProvider driverProvider;
  late UserProvider userProvider;
  late AdminModel adminModel;
  late AdminProvider adminProvider;

  @override
  void didChangeDependencies() {
    driverProvider = Provider.of<DriverProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    driverProvider.getAllDrivers();
    adminProvider = Provider.of<AdminProvider>(context, listen: false);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    adminModel = argList[0];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
          backgroundColor: Colors.green,
        //add appbar
          title: Text('Driver List'),
          actions: [
            IconButton(
              onPressed: () async {
                await setLoginStatus(false);
                Navigator.pushReplacementNamed(
                    context, SigninOptionPage.routeName);
              },
              icon: const Icon(Icons.logout),
            )
          ]),
      /*drawer: Drawer(
        child: SafeArea(
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  title: Text("Home Page"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AdminDashboardPage.routeName,
                        arguments: [adminModel]);
                    //action when this menu is pressed
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text("Add Car"),
                  leading: Icon(Icons.car_rental),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AddCarPage.routeName,
                        arguments: [adminModel]);
                    //action when this menu is pressed
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text("Add Driver"),
                  leading: Icon(Icons.person_add),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AddDriverPage.routeName,
                    );
                    //action when this menu is pressed
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text("Add Fare"),
                  leading: Icon(Icons.money),
                  onTap: () {
                    //action when this menu is pressed
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text('Logout'),
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    await setLoginStatus(false);
                    Navigator.pushReplacementNamed(
                        context, SigninOptionPage.routeName);
                  },
                )
              ],
            )),
      ),*/
      body: Consumer<DriverProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.driverList.length,
          itemBuilder: (context, index) {
            final driver = provider.driverList[index];
            return DriverItem(driver: driver);
          },
        ),
      ),
    );
  }
}

class DriverItem extends StatelessWidget {
  const DriverItem({
    Key? key,
    required this.driver,
  }) : super(key: key);

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, DriverDetailsPage.routeName,
          arguments: [driver.driverId, driver.name]),
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(35),
                topLeft: Radius.circular(35),
                topRight: Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.file(
                File(driver.image!),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(driver.driverId.toString()),
                subtitle: Text(driver.name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
