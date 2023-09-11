import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/booking_model.dart';
class BookingProvider extends ChangeNotifier {
  List<BookingModel> bookingList = [];
  int? totalBooking;

  Future<int> insertBooking(BookingModel bookingModel) => DbHelper.insertBooking(bookingModel);

  Future<int> updateBooking(BookingModel bookingModel) => DbHelper.updateBooking(bookingModel);

  void getAllBooking() async {
    bookingList = await DbHelper.getAllBooking();
    notifyListeners();
  }

  Future<Map<String, dynamic>> getTotalBooking() => DbHelper.getTotalBooking();

  Future<Map<String, dynamic>> getOrderDetailByBookingId(int bookingId) => DbHelper.getOrderDetailByBookingId(bookingId);

  Future<Map<String, dynamic>> getMaxBookingId() => DbHelper.getMaxBookingId();
}