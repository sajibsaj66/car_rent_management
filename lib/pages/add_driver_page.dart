import 'dart:io';

import 'package:car_rent_management/pages/signin_option_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/admin_model.dart';
import '../models/driver_model.dart';
import '../providers/admin_provider.dart';
import '../providers/driver_provider.dart';
import '../providers/user_provider.dart';
import '../utils/helper_functions.dart';
import '../utils/utils.dart';

class AddDriverPage extends StatefulWidget {
  static const String routeName = '/addDriver';

  const AddDriverPage({Key? key}) : super(key: key);

  @override
  State<AddDriverPage> createState() => _AddDriverPageState();
}

class _AddDriverPageState extends State<AddDriverPage> {
  late DriverProvider driverProvider;
  late AdminProvider adminProvider;
  late UserProvider userProvider;
  late AdminModel adminModel;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final nidController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  String? imagePath;
  String errMsg = '';
  int? driverId;

  @override
  void didChangeDependencies() {
    driverProvider = Provider.of(context, listen: false);
    //print('test');
    /*carId = ModalRoute.of(context)!.settings.arguments as int?;
    print(carId);
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
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    nidController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(driverId == null ? 'Add Driver' : 'Update Driver'),
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
              child: TextFormField(
                cursorColor: Colors.green,
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Enter Name',
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.green,
                controller: mobileController,
                decoration: InputDecoration(
                    labelText: 'Enter Mobile',
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.green,
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Enter Email',
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.green,
                controller: nidController,
                decoration: InputDecoration(
                    labelText: 'Enter NID',
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter nid';
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
                controller: addressController,
                decoration: InputDecoration(
                    labelText: 'Enter Address',
                    labelStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
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
                  child: Text(driverId == null ? 'Save' : 'Update'),
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
    if (nameController.text == null) {
      showMsg(context, 'Please enter name');
      return;
    }
    if (mobileController.text == null) {
      showMsg(context, 'Please enter mobile no');
      return;
    }
    if (emailController.text == null) {
      showMsg(context, 'Please enter email');
      return;
    }
    if (nidController.text == null) {
      showMsg(context, 'Please enter nid');
      return;
    }
    if (addressController.text == null) {
      showMsg(context, 'Please enter address');
      return;
    }
    if (imagePath == null) {
      showMsg(context, 'Please select an image');
      return;
    }
    if (_fromKey.currentState!.validate()) {
      final driver = DriverModel(
          name: nameController.text,
          image: imagePath!,
          address: addressController.text,
          mobileNo: mobileController.text,
          email: emailController.text,
          nid: nidController.text,
          entryUser: adminModel.name,
          entryDate: datetime,
          isAvailable: true);

      if (driverId != null) {
        driver.driverId = driverId;
        driverProvider.updateDriver(driver).then((value) {
          Navigator.pop(context, driver.driverId);
        }).catchError((error) {
          print(error.toString());
        });
      } else {
        driverProvider.insertDriver(driver).then((value) {
          driverProvider.getAllDrivers();
          //Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AddDriverPage.routeName,
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
