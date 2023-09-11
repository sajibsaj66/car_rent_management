import 'dart:io';

import 'package:car_rent_management/pages/signin_option_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/admin_model.dart';
import '../models/car_model.dart';
import '../providers/admin_provider.dart';
import '../providers/car_provider.dart';
import '../providers/user_provider.dart';
import '../utils/helper_functions.dart';
import 'car_details_page.dart';

class CarListPage extends StatefulWidget {
  static const String routeName = '/carList';

  const CarListPage({Key? key}) : super(key: key);

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  late CarProvider carProvider;
  late UserProvider userProvider;
  late AdminModel adminModel;
  late AdminProvider adminProvider;

  @override
  void didChangeDependencies() {
    carProvider = Provider.of<CarProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    carProvider.getAllCars();
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
            title: Text('Car List'),
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
        body: Consumer<CarProvider>(
          builder: (context, provider, child) => ListView.builder(
            itemCount: provider.carList.length,
            itemBuilder: (context, index) {
              final car = provider.carList[index];
              return CarItem(car: car);
            },
          ),
        ));
  }
}

class CarItem extends StatelessWidget {
  const CarItem({
    Key? key,
    required this.car,
  }) : super(key: key);

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, CarDetailsPage.routeName,
          arguments: [car.carId, car.carModel]),
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
                File(car.image),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(car.brand),
                subtitle: Text(car.carModel),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
