import 'dart:io';

import 'package:car_rent_management/about.dart';
import 'package:car_rent_management/maps/gMapsHtml.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:unicons/unicons.dart';

import '../../profile/profile_main.dart';
import '../../settings.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/homePage/most_rented.dart';
import '../widgets/homePage/top_brands.dart';

class HomePageNew extends StatefulWidget {
  static const String routeName = '/';
  const HomePageNew({Key? key}) : super(key: key);

  @override
  _HomePageNewState createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //check the size of device
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                CupertinoIcons.arrow_right_arrow_left_circle_fill,
                color: Colors.white70,
                size: 30, // Change Custom Drawer Icon Color
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations
                  .of(context)
                  .openAppDrawerTooltip,
            );
          },
        ),
        elevation: 4,
        shadowColor: Colors.blueAccent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent.shade400, Colors.purple.shade700],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            borderRadius: const BorderRadius.only(
              // bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60)),
          ),
        ),
        title: const Text('Car Rent'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            // bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular((60))),
        ),
      ),
      drawer: (Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.94,
        // width: MediaQuery.of(context).size.width,

        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topRight: Radius.elliptical(170.0, 400.0),
            bottomRight: Radius.elliptical(190.0, 400.0),
          ),
        ),
        width: 280,

        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.only(right: 55),
                  child: DigitalClock(
                    digitAnimationStyle: Curves.linear,
                    is24HourTimeFormat: false,
                    areaDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    hourMinuteDigitTextStyle: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 27,
                    ),
                    amPmDigitTextStyle: const TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold),
                  ),
                ),
                // const Icon(
                //   CupertinoIcons.clock,
                //   color: Colors.grey,
                // ),
                const SizedBox(height: 15.0),
                Container(
                  height: 90,
                  width: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.blue),
                    image: const DecorationImage(
                        image: AssetImage('images/user.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 13.0),
                const Text(
                  "Maruf Ahmed",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                // const Text('Meditech ',
                //     style: TextStyle(color: Colors.blue, fontSize: 15.0)),
                const SizedBox(height: 27),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileMain()));
                    },
                  child: Row(
                    children: const [
                      Icon(
                        CupertinoIcons.profile_circled,
                        color: Colors.blueAccent,
                        size: 40,
                      ),
                      SizedBox(width: 50),
                      Text('Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17))
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            Theme(
                              data: ThemeData.light(),
                              child: CupertinoAlertDialog(
                                title: Text(
                                  'Rating',
                                  style: boldTextStyle(size: 18),
                                ).paddingOnly(bottom: 9),
                                content: Column(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 5,
                                      minRating: 1,
                                      itemSize: 35,
                                      direction: Axis.horizontal,
                                      itemPadding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) =>
                                          Icon(
                                            Icons.star,
                                            color: Colors.blueAccent.shade700,
                                          ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                  ],
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text(
                                      "Cancel",style: TextStyle(
                                      color: Colors.red,fontWeight: FontWeight.bold
                                    ),
                                    ),
                                    onPressed: () {
                                      finish(context);
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text('Submit',style: TextStyle(
                                        color: Colors.green.shade700,fontWeight: FontWeight.bold
                                    ),),
                                    onPressed: () {
                                      toasty(context, 'Submitted!',
                                          gravity: ToastGravity.BOTTOM_LEFT);
                                      finish(context);
                                    },
                                  )
                                ],
                              ),
                            ));
                  },
                  child: Row(
                    children: const [
                      Icon(
                        CupertinoIcons.star,
                        color: Colors.blueAccent,
                        size: 40,
                      ),
                      SizedBox(width: 50),
                      Text('Rate Us',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Share.share(
                        'https://github.com/marufahmedofficial/car_rent_management');
                  },
                  child: Row(
                    children: const [
                      Icon(
                        CupertinoIcons.share,
                        color: Colors.blueAccent,
                        size: 40,
                      ),
                      SizedBox(width: 50),
                      Text('Share',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children:[
                    Icon(
                      CupertinoIcons.info_circle,
                      color: Colors.blueAccent,
                      size: 40,
                    ),
                    SizedBox(width: 50),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutPage()
                            )
                        );
                      },
                      child: Text('About',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('Exit?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            content: Text('Do you really want to Exit?',
                                style: TextStyle(fontSize: 18)),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('Cancel',
                                    style: TextStyle(fontSize: 18,color: Colors.teal)),
                                onPressed: () {
                                  Navigator.pop(context); //close Dialog
                                },
                              ),
                              CupertinoDialogAction(
                                  child: Text('Yes',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red.shade700)),
                                  onPressed: () {
                                    if (Platform.isAndroid) {
                                      SystemNavigator.pop();
                                    } else if (Platform.isIOS) {
                                      exit(0);
                                    }
                                  })
                            ],
                          );
                        });


                  },
                  child: Row(
                    children: const [
                      Icon(
                        CupertinoIcons.arrow_right_circle,
                        color: Colors.blueAccent,
                        size: 38,
                      ),
                      SizedBox(width: 50),
                      Text('Exit',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10.0,
        shape: const CircularNotchedRectangle(),
        color: Colors.grey.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: () {

              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      CupertinoIcons.home,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(color: Colors.blueAccent),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => YoutubeScreen()
                    )
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      CupertinoIcons.location_solid,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Location",
                      style: TextStyle(color: Colors.blueAccent),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileMain()
                    )
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      CupertinoIcons.profile_circled,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(color: Colors.blueAccent),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Settings()
                    )
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      CupertinoIcons.settings_solid,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Setting",
                      style: TextStyle(color: Colors.blueAccent),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.04,
                left: size.width * 0.05,
                right: size.width * 0.05,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: themeData.cardColor, //section bg color
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.04,
                      ),
                      child: Align(
                        child: Text(
                          'Enjoy Our features',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color:  Colors.blue.shade900,
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.01,
                      ),
                      child: Align(
                        child: Text(
                          'Enjoy the fun driving in Enterprise',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.blue.shade700,
                            fontSize: size.width * 0.035,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.03,
                        left: size.width * 0.04,
                        bottom: size.height * 0.025,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.65,
                            height: size.height * 0.06,
                            child: TextField(
                              //searchbar
                              style: GoogleFonts.poppins(
                                color: themeData.primaryColor,
                              ),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.width * 0.04,
                                  right: size.width * 0.04,
                                ),
                                enabledBorder: textFieldBorder(),
                                focusedBorder: textFieldBorder(),
                                border: textFieldBorder(),
                                hintStyle: GoogleFonts.poppins(
                                    color:  Colors.blueGrey
                                ),
                                hintText: 'Search a car',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.025,
                            ),
                            child: Container(
                              height: size.height * 0.06,
                              width: size.width * 0.14,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Color(0xff3b22a1), //filters bg color
                              ),
                              child: Icon(
                                UniconsLine.sliders_v,
                                color: Colors.white,
                                size: size.height * 0.032,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildTopBrands(size, themeData),
            buildMostRented(size, themeData),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1.0,
      ),
    );
  }
}
