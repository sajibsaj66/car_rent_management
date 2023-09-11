
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

import '../models/admin_model.dart';
import '../models/booking_model.dart';
import '../models/car_model.dart';
import '../models/driver_model.dart';
import '../models/fare_model.dart';
import '../models/user_model.dart';

class DbHelper {
  static const String createTableAdmin = '''create table $tblAdmin(
  $tblAdminColId integer primary key autoincrement,
  $tblAdminColName text,
  $tblAdminColPassword text,
  $tblAdminColMobileNo text,
  $tblAdminColEmail text,
  $tblAdminColEntryUser text,
  $tblAdminColEntryDate text,
  $tblAdminColIsSuperAdmin integer,
  $tblAdminColIsLoggedIn integer,
  $tblAdminColLoginTime text,
  $tblAdminColLogoutTime text)''';

  static const String createTableUser = '''create table $tblUser(
  $tblUserColId integer primary key autoincrement,
  $tblUserColName text,
  $tblUserColPassword text,
  $tblUserColMobileNo text,
  $tblUserColEmail text,
  
  $tblUserColAddress text,
  $tblUserColStatus text,
  $tblUserColImage text,
  $tblUserColIsLoggedIn integer,
  $tblUserColLoginTime text,
  $tblUserColLogoutTime text)''';

  static const String createTableCar = '''create table $tblCar(
  $tblCarColId integer primary key autoincrement,
  $tblCarColCarModel text,
  $tblCarColBrand text,
  $tblCarColDes text,
  $tblCarColSeatNo integer,
  $tblCarColImage text,
  $tblCarColEntryUser text,
  $tblCarColEntryDate text,
  $tblCarColIsAvailable integer)''';

  static const String createTableDriver = '''create table $tblDriver(
  $tblDriverColId integer primary key autoincrement,
  $tblDriverColName text,
  $tblDriverColAddress text,
  $tblDriverColEmail text,
  $tblDriverColNID text,
  $tblDriverColMobileNo text,
  $tblDriverColEntryUser text,
  $tblDriverColEntryDate text,
  $tblDriverColImage text,
  $tblDriverColIsAvailable integer)''';

  static const String createTableCarFare = '''create table $tblCarFare(
  $tblCarFareColId integer primary key autoincrement,
  $tblCarFareColCarId integer,
  $tblCarFareColCarFare double,
  $tblCarFareColIsInsideDhaka integer,
  $tblCarFareColEntryUser text,
  $tblCarFareColEntryDate text)''';

  static const String createTableBooking = '''create table $tblBooking(
  $tblBookingColId integer primary key autoincrement,
  $tblBookingColUserId integer,
  $tblBookingColCarId integer,
  $tblBookingColDriverId integer,
  $tblBookingColStatus text,
  $tblBookingColPickupAddress text,
  $tblBookingColFromDate text,
  $tblBookingColFromTime text,
  $tblBookingColTotalFare double,
  $tblBookingColEntryUser text,
  $tblBookingColEntryDate text,
  $tblBookingColApprovedUser text,
  $tblBookingColApprovedDate text
  )''';

  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = Path.join(rootPath, 'rentcar_db');

    return openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      await db.execute(createTableAdmin);
      await db.execute(createTableUser);
      await db.execute(createTableCar);
      await db.execute(createTableDriver);
      await db.execute(createTableCarFare);
      await db.execute(createTableBooking);
      //await db.execute('alter table $tblBooking add column $tblBookingColUserId integer');
      /*await db.execute(createTableRating);
      await db.execute(createTableFavorite);*/
    } /*, onUpgrade: (db, oldVersion, newVersion) async {
      if (newVersion == 2) {
        await db.execute(
            'alter table $tblDriver add column $tblDriverColImage text');
        await db.execute('alter table $tblBooking add column $tblBookingColUserId integer');
        */ /*await db.execute('ALTER TABLE $tblAdmin RENAME COLUMN admin TO isSuperAdmin');
        await db.execute('ALTER TABLE $tblCar MODIFY brand text');*/ /*
      }
      if (newVersion == 3) {
        await db.execute(
            'alter table $tblCar add column $tblCarColIsAvailable integer');
        await db.execute(
            'alter table $tblDriver add column $tblDriverColIsAvailable integer');
        await db.execute('alter table $tblBooking add column $tblBookingColUserId integer');
        */ /*await db.execute('ALTER TABLE $tblAdmin RENAME COLUMN admin TO isSuperAdmin');
        await db.execute('ALTER TABLE $tblCar MODIFY brand text');*/ /*
      }
      if (newVersion == 4) {
        await db.execute(createTableCarFare);
        await db.execute('alter table $tblBooking add column $tblBookingColUserId integer');
        */ /*await db.execute('ALTER TABLE $tblAdmin RENAME COLUMN admin TO isSuperAdmin');
        await db.execute('ALTER TABLE $tblCar MODIFY brand text');*/ /*
      }
      if (newVersion == 5) {
        await db.execute(createTableBooking);
        await db.execute('alter table $tblBooking add column $tblBookingColUserId integer');
        */ /*await db.execute('ALTER TABLE $tblAdmin RENAME COLUMN admin TO isSuperAdmin');
        await db.execute('ALTER TABLE $tblCar MODIFY brand text');*/ /*
      }
      if (newVersion == 6) {
        await db.execute('alter table $tblBooking add column $tblBookingColUserId integer');
        */ /*await db.execute('ALTER TABLE $tblAdmin RENAME COLUMN admin TO isSuperAdmin');
        await db.execute('ALTER TABLE $tblCar MODIFY brand text');*/ /*
      }*/
        /*else if(newVersion == 3){
        await db.execute('alter table $tblCar add column $tblCarColImage text');
        await db.execute('ALTER TABLE $tblCar MODIFY brand text');
      }
      else if(newVersion == 4){
        await db.execute('ALTER TABLE $tblCar RENAME COLUMN brandId TO brand');
        await db.execute('ALTER TABLE $tblCar MODIFY brand text');
      }
      else if(newVersion == 5){
        await db.execute('ALTER TABLE $tblCar MODIFY brand text');
      }*/
        );
  }

  /*static Future<int> insertAdmin(AdminModel adminModel) async {
    final db = await open();
    return db.insert(tblAdmin, adminModel.toMap());
  }*/

  static Future<int> insertCar(CarModel carModel) async {
    final db = await open();
    return db.insert(tblCar, carModel.toMap());
  }

  static Future<int> updateCar(CarModel carModel) async {
    final db = await open();
    return db.update(
      tblCar,
      carModel.toMap(),
      where: '$tblCarColId = ?',
      whereArgs: [carModel.carId],
    );
  }

  static Future<int> insertBooking(BookingModel bookingModel) async {
    final db = await open();
    return db.insert(tblBooking, bookingModel.toMap());
  }

  static Future<int> updateBooking(BookingModel bookingModel) async {
    final db = await open();
    return db.update(
      tblBooking,
      bookingModel.toMap(),
      where: '$tblBookingColId= ?',
      whereArgs: [bookingModel.id],
    );
  }

  static Future<List<BookingModel>> getAllBooking() async {
    final db = await open();
    final mapList = await db.query(tblBooking);
    return List.generate(
        mapList.length, (index) => BookingModel.fromMap(mapList[index]));
  }

  static Future<Map<String, dynamic>> getTotalBooking() async {
    final db = await open();
    final mapList =
        await db.rawQuery('SELECT count(*) totalBooking FROM $tblBooking');
    return mapList.first;
  }

  static Future<Map<String, dynamic>> getCarFareByCarId(int carId) async {
    final db = await open();
    final mapList = await db.rawQuery(
        'select carFare from $tblCarFare where carId=$carId group by $tblBookingColCarId');
    return mapList.first;
  }

  static Future<Map<String, dynamic>> getOrderDetailByBookingId(
      int bookingId) async {
    final db = await open();
    final mapList = await db.rawQuery(
        '''select a.id,a.userId,a.carId,a.driverId,a.status,a.pickupAddress,a.fromDate,a.fromTime,a.totalFare,b.brand carBrand,b.carModel,b.image carImage,b.isAvailable carIsAvailable
                    ,c.image driverImage,c.name driverName,c.email driverEmail,d.name userName,'' driverPhone 
                    from tblbooking a 
                    left join tblcar b on a.carId=b.carId
                    left join tbldriver c on a.driverId=c.driverId
                    left join tbluser d on a.userId=d.userId
                    where a.id=$bookingId''');
    return mapList.first;
  }

  static Future<Map<String, dynamic>> getMaxBookingId() async {
    final db = await open();
    final mapList = await db.rawQuery(
        'select max(id)+1 id from tblbooking');
    return mapList.first;
  }

  static Future<int> insertCarFare(CarFareModel carFareModel) async {
    final db = await open();
    return db.insert(tblCarFare, carFareModel.toMap());
  }

  static Future<int> updateCarFare(CarFareModel carFareModel) async {
    final db = await open();
    return db.update(
      tblCarFare,
      carFareModel.toMap(),
      where: '$tblCarFareColId= ?',
      whereArgs: [carFareModel.id],
    );
  }

  static Future<List<CarModel>> getAllCars() async {
    final db = await open();
    final mapList = await db.query(tblCar);
    return List.generate(
        mapList.length, (index) => CarModel.fromMap(mapList[index]));
  }

  static Future<List<DriverModel>> getAllDrivers() async {
    final db = await open();
    final mapList = await db.query(tblDriver);
    return List.generate(
        mapList.length, (index) => DriverModel.fromMap(mapList[index]));
  }

  static Future<Map<String, dynamic>> getTotalCar() async {
    final db = await open();
    final mapList = await db.rawQuery('SELECT count(*) totalCar FROM $tblCar');
    return mapList.first;
  }

  static Future<int> insertDriver(DriverModel driverModel) async {
    final db = await open();
    return db.insert(tblDriver, driverModel.toMap());
  }

  static Future<int> updateDriver(DriverModel driverMode) async {
    final db = await open();
    return db.update(
      tblDriver,
      driverMode.toMap(),
      where: '$tblDriverColId = ?',
      whereArgs: [driverMode.driverId],
    );
  }

  static Future<int> deleteDriver(int driverId) async {
    final db = await open();
    return db.delete(
      tblDriver,
      where: '$tblDriverColId = ?',
      whereArgs: [driverId],
    );
  }

  static Future<Map<String, dynamic>> getTotalDriver() async {
    final db = await open();
    final mapList =
        await db.rawQuery('SELECT count(*) totalDriver FROM $tblDriver');
    return mapList.first;
  }

  static Future<int> deleteCar(int carId) async {
    final db = await open();
    return db.delete(
      tblCar,
      where: '$tblCarColId = ?',
      whereArgs: [carId],
    );
  }

  static Future<CarModel> getCarById(int carId) async {
    final db = await open();
    final mapList = await db.query(
      tblCar,
      where: '$tblCarColId = ?',
      whereArgs: [carId],
    );
    return CarModel.fromMap(mapList.first);
  }

  static Future<DriverModel> getDriverById(int driverId) async {
    final db = await open();
    final mapList = await db.query(
      tblDriver,
      where: '$tblDriverColId = ?',
      whereArgs: [driverId],
    );
    return DriverModel.fromMap(mapList.first);
  }

  static Future<UserModel?> getUserByMobile(String mobile) async {
    final db = await open();
    final mapList = await db.query(
      tblUser,
      where: '$tblUserColMobileNo = ?',
      whereArgs: [mobile],
    );
    if (mapList.isEmpty) return null;
    return UserModel.fromMap(mapList.first);
  }

  static Future<UserModel?> getUserByEmail(String email) async {
    final db = await open();
    final mapList = await db.query(
      tblUser,
      where: '$tblUserColEmail = ?',
      whereArgs: [email],
    );
    if (mapList.isEmpty) return null;
    return UserModel.fromMap(mapList.first);
  }

  static Future<AdminModel?> getAdminUserByMobile(String mobile) async {
    final db = await open();
    final mapList = await db.query(
      tblUser,
      where: '$tblAdminColMobileNo = ?',
      whereArgs: [mobile],
    );
    if (mapList.isEmpty) return null;
    return AdminModel.fromMap(mapList.first);
  }

  static Future<AdminModel?> getAdminUserByEmail(String email) async {
    final db = await open();
    final mapList = await db.query(
      tblAdmin,
      where: '$tblAdminColEmail = ?',
      whereArgs: [email],
    );
    if (mapList.isEmpty) return null;
    return AdminModel.fromMap(mapList.first);
  }
}
