import 'package:car_rent_management/pages/signin_option_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/admin_model.dart';
import '../models/fare_model.dart';
import '../providers/admin_provider.dart';
import '../providers/car_provider.dart';
import '../utils/helper_functions.dart';
import '../utils/utils.dart';
import 'car_details_page.dart';

class AddFarePage extends StatefulWidget {
  static const String routeName = '/addFare';

  const AddFarePage({Key? key}) : super(key: key);

  @override
  State<AddFarePage> createState() => _AddFarePageState();
}

class _AddFarePageState extends State<AddFarePage> {
  late CarProvider carProvider;
  late AdminProvider adminProvider;
  late AdminModel adminModel;
  final _fromKey = GlobalKey<FormState>();
  final fareController = TextEditingController();
  final carIdController = TextEditingController();
  final carModelController = TextEditingController();
  String errMsg = '';
  int? carId;
  String? carModel;
  int? id;

  @override
  void didChangeDependencies() {
    carProvider = Provider.of(context, listen: false);
    //print('test');
    /*carId = ModalRoute.of(context)!.settings.arguments as int?;
    print(carId);
    if (carId != null) {
      _setData();
    }*/
    adminProvider = Provider.of<AdminProvider>(context, listen: false);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    //adminModel = argList[0];
    carId = argList[0];
    carModel = argList[1];

    carIdController.text = carId.toString();
    carModelController.text = carModel.toString();
    //print(adminModel);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    fareController.dispose();
    carIdController.dispose();
    carModelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(id == null ? 'Add Fare' : 'Update Fare'),
        actions: [
          IconButton(
            onPressed: () async {
              await setLoginStatus(false);
              Navigator.pushReplacementNamed(
                  context, SigninOptionPage.routeName);
            },
            icon: const Icon(Icons.logout),
          )

/*
          IconButton(
              onPressed: saveCar,
              icon: Icon(carId == null ? Icons.save : Icons.update))
*/
        ],
      ),
      /*drawer: Drawer(
        child: SafeArea(
            child: Column(
          children: [
            ListTile(
              dense: true,
              title: Text("Home Page"),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, AdminDashboardPage.routeName,
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
                Navigator.pushReplacementNamed(context, AddDriverPage.routeName,
                    arguments: [adminModel]);
                //action when this menu is pressed
              },
            ),
            *//* ListTile(
                  dense: true,
                  title: Text("Add Fare"),
                  leading: Icon(Icons.money),
                  onTap: () {
                    //action when this menu is pressed
                  },
                ),*//*
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
      body: Form(
        key: _fromKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.green,
                controller: carIdController,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter car id';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.green,
                controller: carModelController,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter car id';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.green,
                controller: fareController,
                decoration: InputDecoration(
                    labelText: 'Enter Fare',
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter fare';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 400,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: saveCarFare,
                  child: Text(id == null ? 'Save' : 'Update'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              errMsg,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  void _setData() {}

  void saveCarFare() {
    if (fareController.text == null) {
      showMsg(context, 'Please enter fare');
      return;
    }
    if (_fromKey.currentState!.validate()) {
      final carFare = CarFareModel(
          carId: carId!,
          carFare: double.parse(fareController.text),
          isInsideDhaka: true,
          entryUser: 'test',
          entryDate: datetime);

      if (id != null) {
        carFare.id = id;
        carProvider.updateCarFare(carFare).then((value) {
          Navigator.pop(context, carFare.id);
        }).catchError((error) {
          print(error.toString());
        });
      } else {
        carProvider.insertCarFare(carFare).then((value) {
          carProvider.getAllCars();
          //Navigator.pop(context);
          Navigator.pushReplacementNamed(context, CarDetailsPage.routeName,
              arguments: [carId, carModel]);
        }).catchError((error) {
          print(error.toString());
        });
      }
    }
  }
}
