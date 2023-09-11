import 'package:flutter/material.dart';

class BookingListPage extends StatefulWidget {
  static const String routeName = '/bookingList';

  const BookingListPage({Key? key}) : super(key: key);

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar:
          AppBar(backgroundColor: Colors.green, title: Text('Booking List')),
    );
  }
}
