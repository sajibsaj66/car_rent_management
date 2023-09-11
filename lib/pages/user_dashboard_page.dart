import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/car_model.dart';
import '../models/user_model.dart';
import '../providers/booking_provider.dart';
import '../providers/car_provider.dart';
import '../providers/driver_provider.dart';
import '../providers/user_provider.dart';
import '../utils/helper_functions.dart';
import 'booking_page.dart';
import 'signin_option_page.dart';

class UserDashboardPage extends StatefulWidget {
  static const String routeName = '/userDashboard';

  const UserDashboardPage({Key? key}) : super(key: key);

  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  late String loginOption;
  late UserProvider userProvider;
  late CarProvider carProvider;
  late UserModel userModel;
  late DriverProvider driverProvider;
  late BookingProvider bookingProvider;
  String? carFare;
  int? bookingId;

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    bookingProvider = Provider.of<BookingProvider>(context, listen: false);

    final argList = ModalRoute.of(context)!.settings.arguments as List;
    if (argList != null) {
      userModel = argList[0];
    }
    carProvider = Provider.of<CarProvider>(context, listen: false);
    carProvider.getAllCars();
    driverProvider = Provider.of<DriverProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade50,
        appBar: AppBar(
            backgroundColor: Colors.green,
            //add appbar
            title: Text("Home"),
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
        drawer: Drawer(
          child: SafeArea(
              child: Column(
            children: [
              ListTile(
                dense: true,
                title: Text("Home Page",style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.home, color: Colors.blueGrey,),
                onTap: () {
                  //action when this menu is pressed
                },
              ),
              /*ListTile(
                dense: true,
                title: Text("Order Details"),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, UserDashboardPage.routeName,arguments: []);
                  //action when this menu is pressed
                },
              ),*/
              ListTile(
                dense: true,
                title: Text('Logout',style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),),
                leading: Icon(Icons.logout, color: Colors.blueGrey,),
                onTap: () async {
                  await setLoginStatus(false);
                  Navigator.pushReplacementNamed(
                      context, SigninOptionPage.routeName);
                },
              )
            ],
          )),
        ),
        body: Consumer<CarProvider>(
          builder: (context, provider, child) => ListView.builder(
            itemCount: provider.carList.length,
            itemBuilder: (context, index) {
              final car = provider.carList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, BookingPage.routeName,
                          arguments: [car.carId, car.carModel, userModel]),
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
                                title: Text(car.brand,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        )),
                                subtitle: Text(car.carModel,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        )),
                                /*trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FutureBuilder<Map<String, dynamic>>(
                                        future: carProvider
                                            .getCarFareByCarId(car.carId!),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            final map = snapshot.data!;
                                            carFare = map['carFare'];
                                          }
                                          if (snapshot.hasError) {
                                            return const Text('Error loading1');
                                          }
                                          return const Text('');
                                        })
                                  ],
                                ),*/
                              ),
                              FutureBuilder<Map<String, dynamic>>(
                                  future:
                                      carProvider.getCarFareByCarId(car.carId!),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final map = snapshot.data!;
                                      carFare = map['carFare'].toString();

                                      return Text('BDT $carFare',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ));
                                    }
                                    if (snapshot.hasError) {
                                      return const Text('Error loading1');
                                    }
                                    return const Text('');
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
        //add drawer
        //when you add drawer, the menu icon will appear on appbar
        );
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, BookingPage.routeName,
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
                      title: Text(car.brand,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      subtitle: Text(car.carModel,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
