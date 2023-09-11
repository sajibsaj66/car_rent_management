import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/driver_model.dart';
class DriverProvider extends ChangeNotifier {
  List<DriverModel> driverList = [];
  int? totalDriver;

  Future<int> insertDriver(DriverModel driverModel) =>
      DbHelper.insertDriver(driverModel);

  Future<int> updateDriver(DriverModel driverModel) =>
      DbHelper.updateDriver(driverModel);

  void deleteDriver(int driverId) async {
    await DbHelper.deleteDriver(driverId);
    getAllDrivers();
  }

  Future<DriverModel> getDriverById(int driverId) =>
      DbHelper.getDriverById(driverId);

  void getAllDrivers() async {
    driverList = await DbHelper.getAllDrivers();
    notifyListeners();
  }

  Future<Map<String, dynamic>> getTotalDriver() => DbHelper.getTotalDriver();
}
