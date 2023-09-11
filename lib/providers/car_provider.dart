import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/car_model.dart';
import '../models/fare_model.dart';

class CarProvider extends ChangeNotifier {
  List<CarModel> carList = [];
  int? totalCar;

  //late CarModel carModel;

  Future<int> insertCar(CarModel carModel) => DbHelper.insertCar(carModel);

  Future<int> updateCar(CarModel carModel) => DbHelper.updateCar(carModel);

  Future<int> insertCarFare(CarFareModel carFareModel) => DbHelper.insertCarFare(carFareModel);

  Future<int> updateCarFare(CarFareModel carFareModel) => DbHelper.updateCarFare(carFareModel);

  Future<Map<String, dynamic>> getCarFareByCarId(int carId) => DbHelper.getCarFareByCarId(carId);

  void getAllCars() async {
    carList = await DbHelper.getAllCars();
    notifyListeners();
  }

  Future<Map<String, dynamic>> getTotalCar() => DbHelper.getTotalCar();

  void deleteCar(int carId) async {
    await DbHelper.deleteCar(carId);
    getAllCars();
  }

  Future<CarModel> getCarById(int carId) =>
      DbHelper.getCarById(carId);
}
