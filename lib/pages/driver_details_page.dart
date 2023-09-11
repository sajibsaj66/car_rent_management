import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/admin_model.dart';
import '../models/driver_model.dart';
import '../providers/admin_provider.dart';
import '../providers/driver_provider.dart';
import '../providers/user_provider.dart';

class DriverDetailsPage extends StatefulWidget {
  static const String routeName = '/driverDetails';

  const DriverDetailsPage({Key? key}) : super(key: key);

  @override
  State<DriverDetailsPage> createState() => _DriverDetailsPageState();
}

class _DriverDetailsPageState extends State<DriverDetailsPage> {
  int? driverId;
  late String name;
  late DriverProvider driverProvider;
  late UserProvider userProvider;
  late AdminModel adminModel;
  late AdminProvider adminProvider;

  @override
  void didChangeDependencies() {
    driverProvider = Provider.of<DriverProvider>(context, listen: false);
    adminProvider = Provider.of<AdminProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    driverId = argList[0];
    name = argList[1];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(name), actions: [
        /*IconButton(
          onPressed: () => Navigator.pushNamed(context, AddDriverPage.routeName,
                  arguments: adminModel)
              .then((value) => setState(() {
                    name = value as String;
                  })),
          icon: const Icon(Icons.edit),
        ),*/
        IconButton(
          onPressed: _deleteDriver,
          icon: const Icon(Icons.delete),
        ),
      ]),
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
      body: Center(
        child: FutureBuilder<DriverModel>(
          future: driverProvider.getDriverById(driverId!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final driver = snapshot.data!;
              return ListView(
                children: [
                  Image.file(
                    File(driver.image!),
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
                      title: Text(driver.driverId.toString()),
                      subtitle: Text(driver.name),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(driver.address),
                  ),
                  /*if (!userProvider.userModel.isAdmin)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: RatingCommentWidget(
                        movieId: id!,
                        onComplete: () {
                          setState(() {});
                        },
                      ),
                    ),*/
                  /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'All Comments',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),*/
                  /*AllCommentsWidget(
                    movieId: id!,
                  )*/
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

  void _deleteDriver() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete $name?'),
              content: Text('Are you sure to delete $name?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('NO'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    driverProvider.deleteDriver(driverId!);
                    Navigator.pop(context);
                  },
                  child: const Text('YES'),
                )
              ],
            ));
  }
}
