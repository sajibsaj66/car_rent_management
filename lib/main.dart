
import 'package:car_rent_management/new/pages/details_page.dart';
import 'package:car_rent_management/new/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/add_car_page.dart';
import 'pages/add_driver_page.dart';
import 'pages/add_fare_page.dart';
import 'pages/admin_dashboard_page.dart';
import 'pages/admin_login_page.dart';
import 'pages/booking_list_page.dart';
import 'pages/booking_page.dart';
import 'pages/car_details_page.dart';
import 'pages/car_list_page.dart';
import 'pages/driver_details_page.dart';
import 'pages/driver_list_page.dart';
import 'pages/login_email_page.dart';
import 'pages/login_phone_page.dart';
import 'pages/order_details_page.dart';
import 'pages/otp_verification_page.dart';
import 'pages/signin_option_page.dart';
import 'pages/user_dashboard_page.dart';
import 'providers/admin_provider.dart';
import 'providers/booking_provider.dart';
import 'providers/car_provider.dart';
import 'providers/driver_provider.dart';
import 'providers/fare_provider.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AdminProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => CarProvider()),
    ChangeNotifierProvider(create: (context) => DriverProvider()),
    ChangeNotifierProvider(create: (context) => FareProvider()),
    ChangeNotifierProvider(create: (context) => BookingProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Rent Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SigninOptionPage.routeName,
      routes: {
        SigninOptionPage.routeName: (context) => SigninOptionPage(),
        LoginPhonePage.routeName: (context) => LoginPhonePage(),
        LoginEmailPage.routeName: (context) => LoginEmailPage(),
        OtpVerificationPage.routeName: (context) => OtpVerificationPage(),
        UserDashboardPage.routeName: (context) => UserDashboardPage(),
        AdminDashboardPage.routeName: (context) => AdminDashboardPage(),
        AdminLoginPage.routeName: (context) => AdminLoginPage(),
        CarDetailsPage.routeName: (context) => CarDetailsPage(),
        AddCarPage.routeName: (context) => AddCarPage(),
        CarListPage.routeName: (context) => CarListPage(),
        DriverDetailsPage.routeName: (context) => DriverDetailsPage(),
        AddDriverPage.routeName: (context) => AddDriverPage(),
        DriverListPage.routeName: (context) => DriverListPage(),
        AddFarePage.routeName: (context) => AddFarePage(),
        BookingPage.routeName: (context) => BookingPage(),
        OrderDetailsPage.routeName: (context) => OrderDetailsPage(),
        BookingListPage.routeName: (context) => BookingListPage(),
        HomePageNew.routeName: (context) => HomePageNew(),
      },
    );
  }
}
