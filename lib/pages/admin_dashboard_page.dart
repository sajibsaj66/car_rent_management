import 'dart:io';

import 'package:car_rent_management/pages/signin_option_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/admin_model.dart';
import '../providers/admin_provider.dart';
import '../providers/booking_provider.dart';
import '../providers/car_provider.dart';
import '../providers/driver_provider.dart';
import '../utils/helper_functions.dart';
import 'add_car_page.dart';
import 'add_driver_page.dart';
import 'booking_list_page.dart';
import 'car_list_page.dart';
import 'driver_list_page.dart';

class AdminDashboardPage extends StatefulWidget {
  static const String routeName = '/adminDashboard';

  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  late AdminProvider adminProvider;
  late CarProvider carProvider;
  late AdminModel adminModel;
  late DriverProvider driverProvider;
  late BookingProvider bookingProvider;

  @override
  void didChangeDependencies() {
    adminProvider = Provider.of<AdminProvider>(context, listen: false);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    adminModel = argList[0];
    carProvider = Provider.of<CarProvider>(context, listen: false);
    carProvider.getTotalCar();
    driverProvider = Provider.of<DriverProvider>(context, listen: false);
    driverProvider.getTotalDriver();
    bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    bookingProvider.getTotalBooking();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
          backgroundColor: Colors.green,
          //add appbar
          title: Text('Dashboard'),
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
            ListTile(
              dense: true,
              title: Text("Add Car",style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),),
              leading: Icon(Icons.car_rental, color: Colors.blueGrey,),
              onTap: () {
                Navigator.pushNamed(context, AddCarPage.routeName,
                    arguments: [adminModel]);
                //action when this menu is pressed
              },
            ),
            ListTile(
              dense: true,
              title: Text("Add Driver", style: TextStyle(
                color: Colors.blueGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),),
              leading: Icon(Icons.person_add, color: Colors.blueGrey,),
              onTap: () {
                Navigator.pushNamed(context, AddDriverPage.routeName,
                    arguments: [adminModel]);
                //action when this menu is pressed
              },
            ),
            /*ListTile(
              dense: true,
              title: Text("Add Fare",style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),),
              leading: Icon(Icons.money, color: Colors.blueGrey,),
              onTap: () {
                //action when this menu is pressed
              },
            ),*/
            ListTile(
              dense: true,
              title: Text('Logout',style: TextStyle(
                color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),),
              leading: Icon(Icons.logout, color: Colors.red,),
              onTap: () async {
                await setLoginStatus(false);
                Navigator.pushReplacementNamed(
                    context, SigninOptionPage.routeName);
              },
            )
          ],
        )),
      ), //add drawer
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.pushNamed(context, CarListPage.routeName,
                    arguments: [adminModel]),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Car',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Image.asset(
                          'images/rolls_royce.png',
                          width: double.infinity,
                          height: 160,
                          //fit: BoxFit.cover,
                        ),
                        /*Image.file(
                    File(car.image),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),*/
                        ListTile(
                          title: FutureBuilder<Map<String, dynamic>>(
                            future: carProvider.getTotalCar(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final map = snapshot.data!;
                                return Text('Total: ${map['totalCar'] ?? 0.0}',style:
                                  TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green
                                  )
                                  );
                              }
                              if (snapshot.hasError) {
                                return const Text('Error loading');
                              }
                              return const Text('Loading');
                            },
                          ),
                          //subtitle: Text(car.carModel),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () => Navigator.pushNamed(
                    context, DriverListPage.routeName,
                    arguments: [adminModel]),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Driver',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Image.asset(
                          'images/dri.jpg',
                          width: double.infinity,
                          height: 200,
                          //fit: BoxFit.cover,
                        ),
                        /*Image.file(
                    File(car.image),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),*/
                        ListTile(
                          title: FutureBuilder<Map<String, dynamic>>(
                            future: driverProvider.getTotalDriver(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final map = snapshot.data!;
                                return Text(
                                    'Total: ${map['totalDriver'] ?? 0.0}',
                                    style:
                                    TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green
                                    )
                                );
                              }
                              if (snapshot.hasError) {
                                return const Text('Error loading');
                              }
                              return const Text('Loading');
                            },
                          ),
                          //subtitle: Text(car.carModel),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(
                    context, BookingListPage.routeName,),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Booking',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Image.asset(
                          'images/carrent.PNG',
                          width: double.infinity,
                          height: 200,
                          //fit: BoxFit.cover,
                        ),
                        /*Image.file(
                    File(car.image),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),*/
                        /*ListTile(
                          title: FutureBuilder<Map<String, dynamic>>(
                            future: bookingProvider.getTotalBooking(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print(snapshot.hasData);
                                final map = snapshot.data!;
                                return Text(
                                    'Total: ${map['totalBooking'] ?? 0.0}',
                                    style:
                                    TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green
                                    )
                                );
                              }
                              if (snapshot.hasError) {
                                return const Text('Error loading');
                              }
                              return const Text('Loading');
                            },
                          ),
                          //subtitle: Text(car.carModel),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //when you add drawer, the menu icon will appear on appbar
    );
  }
}
