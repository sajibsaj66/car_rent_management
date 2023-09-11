import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/admin_model.dart';
import '../models/car_model.dart';
import '../providers/admin_provider.dart';
import '../providers/car_provider.dart';
import '../providers/user_provider.dart';
import '../utils/helper_functions.dart';
import '../utils/utils.dart';
import 'signin_option_page.dart';

class AddCarPage extends StatefulWidget {
  static const String routeName = '/addCar';

  const AddCarPage({Key? key}) : super(key: key);

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  late CarProvider carProvider;
  late AdminProvider adminProvider;
  late UserProvider userProvider;
  late AdminModel adminModel;
  final modelController = TextEditingController();
  final descriptionController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  String? selectedBrand;
  String? selectedSeatNo;
  String? imagePath;
  String errMsg = '';
  int? carId;

  @override
  void didChangeDependencies() {
    carProvider = Provider.of(context, listen: false);
    //print('test');
    /*carId = ModalRoute.of(context)!.settings.arguments as int?;
    if (carId != null) {
      _setData();
    }*/
    adminProvider = Provider.of<AdminProvider>(context, listen: false);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    adminModel = argList[0];
    //print(adminModel);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    modelController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(carId == null ? 'Add Car' : 'Update Car'),
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
      /*appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(carId == null ? 'Add Car' : 'Update Car'),
        actions: [
          IconButton(
            onPressed: () async {
              await setLoginStatus(false);
              Navigator.pushReplacementNamed(
                  context, SigninOptionPage.routeName);
            },
            icon: const Icon(Icons.logout),
          )

*//*
          IconButton(
              onPressed: saveCar,
              icon: Icon(carId == null ? Icons.save : Icons.update))
*//*
        ],
      ),*/
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
                Navigator.pushReplacementNamed(context, AddCarPage.routeName,arguments: [adminModel]);
                //action when this menu is pressed
              },
            ),
            ListTile(
              dense: true,
              title: Text("Add Driver"),
              leading: Icon(Icons.person_add),
              onTap: () {
                Navigator.pushReplacementNamed(context, AddDriverPage.routeName,arguments: [adminModel]);
                //action when this menu is pressed
              },
            ),
            ListTile(
              dense: true,
              title: Text("Add Fare"),
              leading: Icon(Icons.money),
              onTap: () {
                //action when this menu is pressed
              },
            ),
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
              child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1))),
                  hint: Text('Select Brand Type'),
                  items: carBrandTypes
                      .map((e) => DropdownMenuItem(value: e, child: Text(e!)))
                      .toList(),
                  value: selectedBrand,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a brand';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedBrand = value;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.green,
                controller: modelController,
                decoration: InputDecoration(
                    labelText: 'Enter Model',
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.grey, width: 1))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter model';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 2,
                cursorColor: Colors.green,
                controller: descriptionController,
                decoration: InputDecoration(
                    labelText: 'Enter Description',
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
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
                  hint: Text('Select Seat No'),
                  items: carSeatNo
                      .map((e) => DropdownMenuItem(value: e, child: Text(e!)))
                      .toList(),
                  value: selectedSeatNo,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a seat no';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedSeatNo = value;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  imagePath == null
                      ? const Icon(
                          Icons.car_rental,
                          size: 50,
                          color: Colors.green,
                        )
                      : Image.file(
                          File(imagePath!),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                  TextButton.icon(
                    onPressed: getImage,
                    icon: const Icon(
                      Icons.photo_album,
                      color: Colors.green,
                    ),
                    label: const Text('Select from Gallery',
                        style: TextStyle(color: Colors.green)),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 400,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: saveCar,
                  child: Text(carId == null ? 'Save' : 'Update'),
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

  void saveCar() {
    if (modelController.text == null) {
      showMsg(context, 'Please enter model');
      return;
    }
    if (descriptionController.text == null) {
      showMsg(context, 'Please enter description');
      return;
    }
    if (imagePath == null) {
      showMsg(context, 'Please select an image');
      return;
    }
    if (_fromKey.currentState!.validate()) {
      final car = CarModel(
          carModel: modelController.text,
          image: imagePath!,
          description: descriptionController.text,
          seatNo: int.parse(selectedSeatNo!),
          brand: selectedBrand!,
          entryUser: adminModel.name,
          entryDate: datetime,
          isAvailable: true);

      if (carId != null) {
        car.carId = carId;
        carProvider.updateCar(car).then((value) {
          Navigator.pop(context, car.carId);
        }).catchError((error) {
          print(error.toString());
        });
      } else {
        carProvider.insertCar(car).then((value) {
          carProvider.getAllCars();
          //Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AddCarPage.routeName,
              arguments: [adminModel]);
        }).catchError((error) {
          print(error.toString());
        });
      }
    }
  }

  void getImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        imagePath = file.path;
      });
    }
  }
}
