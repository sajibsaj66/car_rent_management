import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/booking_provider.dart';
import '../providers/car_provider.dart';
import '../providers/driver_provider.dart';
import '../providers/user_provider.dart';
import 'user_dashboard_page.dart';

class OrderDetailsPage extends StatefulWidget {
  static const String routeName = '/orderDetails';

  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late CarProvider carProvider;
  late DriverProvider driverProvider;
  late BookingProvider bookingProvider;
  late UserProvider userProvider;
  late UserModel userModel;
  int? id;

  @override
  void didChangeDependencies() {
    bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    id = argList[0];
    userModel = argList[1];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Order Details')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: bookingProvider.getOrderDetailByBookingId(id!),
          builder: (context, snapshot) {
            print(id);
            if (snapshot.hasData) {
              final map = snapshot.data!;
              return ListView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Car Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Image.file(
                  File(map['carImage']),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                ListTile(
                    title: Text('Brand: ${map['carBrand']}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Model: ${map['carModel']}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Car Fare: ${map['totalFare'] ?? 0.0}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Driver Information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Text('Driver Name: ${map['driverName'] ?? ''}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Phone No: ${map['driverPhone']}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Status: ${map['status'] ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Pickup Address: ${map['pickupAddress'] ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Date: ${map['fromDate'] ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Time: ${map['fromTime'] ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, UserDashboardPage.routeName,
                          arguments: [userModel]);
                    },
                    child: Text('OK'),
                  ),
                )
              ]);
            }
            if (snapshot.hasError) {
              return const Text('Error loading1');
            }
            return const Text('Loading');
          },
        ),
      ),
    );
  }
}
