import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/booking_model.dart';
import '../models/car_model.dart';
import '../models/user_model.dart';
import '../providers/booking_provider.dart';
import '../providers/car_provider.dart';
import '../providers/driver_provider.dart';
import '../providers/user_provider.dart';
import '../utils/helper_functions.dart';
import '../utils/utils.dart';
import 'order_details_page.dart';

class BookingPage extends StatefulWidget {
  static const String routeName = '/userBooking';

  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int? id;
  int? carId;
  late String carModel;
  late CarProvider carProvider;
  late DriverProvider driverProvider;
  late BookingProvider bookingProvider;
  late UserProvider userProvider;
  late UserModel userModel;
  DateTime? releaseDate;
  String? selectedTime;
  String? carTotalFare;
  int? bookingId;
  final pickupAddressController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    carProvider = Provider.of<CarProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    driverProvider = Provider.of<DriverProvider>(context, listen: false);
    bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    carId = argList[0];
    carModel = argList[1];
    userModel = argList[2];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    pickupAddressController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Place Order')),
      body: Center(
        child: FutureBuilder<CarModel>(
          future: carProvider.getCarById(carId!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final car = snapshot.data!;
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                          'Car Information',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                  Image.file(
                    File(car.image),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  /*FutureBuilder<bool>(
                      future: userProvider.didUserFavorite(id!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final isFavorite = snapshot.data!;
                          return TextButton.icon(
                            onPressed: () {
                              _favoriteMovie(isFavorite);
                            },
                            icon: Icon(isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border),
                            label: Text(isFavorite
                                ? 'Remove from Favorite'
                                : 'Add to Favorite'),
                          );
                        }
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return const Text('Failed to load favorite');
                        }
                        return const Text('Loading');
                      },
                    ),*/
                  ListTile(
                      title: Text('Brand: ${car.brand}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Model: ${car.carModel}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          /*FutureBuilder<Map<String, dynamic>>(
                              future: userProvider.getAvgRatingByMovieId(id!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final map = snapshot.data!;
                                  return Text('${map[avgRating] ?? 0.0}');
                                }
                                if (snapshot.hasError) {
                                  return const Text('Error loading');
                                }
                                return const Text('Loading');
                              },
                            ),*/
                        ],
                      )),
                  /*Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Budget: \$${movie.budget}'),
                    ),*/
                  /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Description: ${car.description!}',style: TextStyle(fontWeight: FontWeight.bold)),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: carProvider.getCarFareByCarId(carId!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final map = snapshot.data!;
                          carTotalFare = map['carFare'].toString();
                          return Text(
                            'Car Fare: ${map['carFare'] ?? 0.0}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Text('Error loading1');
                        }
                        return const Text('Loading');
                      },
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('Driver Information',style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 2,
                      cursorColor: Colors.green,
                      controller: pickupAddressController,
                      decoration: InputDecoration(
                          labelText: 'Enter Pickup Address',
                          labelStyle: TextStyle(color: Colors.green),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                              BorderSide(color: Colors.blue, width: 1))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter pickup address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: selectDate,
                          icon: const Icon(Icons.calendar_month),
                          label: const Text('Select Date'),
                        ),
                        Text(releaseDate == null
                            ? 'No date chosen'
                            : getFormattedDate(releaseDate!, 'dd/MM/yyyy'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                BorderSide(color: Colors.blue, width: 1))),
                        hint: Text('Select Time',style: TextStyle(color: Colors.green),),
                        items: bookingTime
                            .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e!)))
                            .toList(),
                        value: selectedTime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select time';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedTime = value;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: saveOrder,
                      child: Text(id == null ? 'Place Order' : 'Update Order'),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder<Map<String, dynamic>>(
                          future: bookingProvider.getMaxBookingId(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final map = snapshot.data!;
                              bookingId = map['id'];
                            }
                            if (snapshot.hasError) {
                              return const Text('Error loading1');
                            }
                            return const Text('');
                          }))
                ],
              );
            }
            if (snapshot.hasError) {
              return const Text('Failed to load data');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  void selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selectedDate != null) {
      setState(() {
        releaseDate = selectedDate;
      });
    }
  }

  void saveOrder() {
    //print('test2');
    /*if (pickupAddressController.text == null) {
      showMsg(context, 'Please enter pickup address');
      return;
    }
    if (releaseDate == null) {
      showMsg(context, 'Please select a date');
      return;
    }*/
    //print('3');
    //if (_fromKey.currentState!.validate()) {
    //print('4');
    //carTotalFare = carProvider.getCarFareByCarId(carId);

    final booking = BookingModel(
        id: bookingId,
        carId: carId!,
        userId: userModel.userId!,
        status: 'Pending',
        pickupAddress: pickupAddressController.text,
        fromTime: selectedTime!,
        fromDate: getFormattedDate(releaseDate!, datePattern),
        totalFare: double.parse(carTotalFare!),
        entryUser: userModel.name,
        entryDate: datetime);
    //print('4.1');
    //print(id);
    if (id != null) {
      booking.id = id;
      bookingProvider.updateBooking(booking).then((value) {
        /*Navigator.pop(context, booking.carId);*/
        Navigator.pushReplacementNamed(context, OrderDetailsPage.routeName,
            arguments: [bookingId,userModel]);
      }).catchError((error) {
        print(error.toString());
      });
    } else {
      bookingProvider.insertBooking(booking).then((value) {
        //bookingProvider.getAllBooking();
        //Navigator.pop(context);
        Navigator.pushReplacementNamed(context, OrderDetailsPage.routeName,
            arguments: [bookingId,userModel]);
      }).catchError((error) {
        print(error.toString());
      });
    }
    //}
  }
}