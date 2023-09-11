import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/admin_model.dart';
import '../models/car_model.dart';
import '../providers/car_provider.dart';
import '../providers/user_provider.dart';
import 'add_car_page.dart';
import 'add_fare_page.dart';

class CarDetailsPage extends StatefulWidget {
  static const String routeName = '/carDetails';

  const CarDetailsPage({Key? key}) : super(key: key);

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  int? carId;
  late String carModel;
  late CarProvider carProvider;
  late UserProvider userProvider;
  late AdminModel adminModel;

  @override
  void didChangeDependencies() {
    carProvider = Provider.of<CarProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    carId = argList[0];
    carModel = argList[1];
    /*if(carId != null) {
      _setData();
    }*/
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(carModel), actions: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AddCarPage.routeName,
                  arguments: adminModel)
              .then((value) => setState(() {
                    carModel = value as String;
                  })),
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          onPressed: _deleteCar,
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
        child: FutureBuilder<CarModel>(
          future: carProvider.getCarById(carId!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final car = snapshot.data!;
              return ListView(
                children: [
                  Image.file(
                    File(car.image),
                    width: double.infinity,
                    height: 250,
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
                      title: Text(car.brand),
                      subtitle: Text(car.carModel),
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
                    child: Text(car.description!),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AddFarePage.routeName,
                            arguments: [carId,carModel]);
                      },
                      child: Text('Add Fare'),
                    ),
                  )
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

  void _deleteCar() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete $carModel?'),
              content: Text('Are you sure to delete $carModel?'),
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
                    carProvider.deleteCar(carId!);
                    Navigator.pop(context);
                  },
                  child: const Text('YES'),
                )
              ],
            ));
  }

  /*void _setData() {
    final movie = carProvider.getCarById(carId!);
    nameController.text = movie.name;
    descriptionController.text = movie.description;
    budgetController.text = movie.budget.toString();
    selectedType = movie.type;
    imagePath = movie.image;
    releaseDate = DateFormat(datePattern).parse(movie.release_date);

  }*/
}
