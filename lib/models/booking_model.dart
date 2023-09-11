const String tblBooking = 'tblBooking';
const String tblBookingColId = 'id';
const String tblBookingColUserId = 'userId';
const String tblBookingColCarId = 'carId';
const String tblBookingColDriverId = 'driverId';
const String tblBookingColStatus = 'status';
const String tblBookingColPickupAddress = 'pickupAddress';
const String tblBookingColFromDate = 'fromDate';
const String tblBookingColFromTime = 'fromTime';
const String tblBookingColTotalFare = 'totalFare';
const String tblBookingColEntryUser = 'entryUser';
const String tblBookingColEntryDate = 'entryDate';
const String tblBookingColApprovedUser = 'approvedUser';
const String tblBookingColApprovedDate = 'approvedDate';

class BookingModel{
  int? id;
  int carId;
  int userId;
  int? driverId;
  String status;
  String pickupAddress;
  String fromDate;
  String fromTime;
  double totalFare;
  String? entryUser;
  String? entryDate;
  String? approvedUser;
  String? approvedDate;

  BookingModel(
      {this.id,
      required this.carId,
      required this.userId,
      this.driverId,
      required this.status,
      required this.pickupAddress,
      required this.fromDate,
      required this.fromTime,
      required this.totalFare,
      this.entryUser,
      this.entryDate,
      this.approvedUser,
      this.approvedDate});

  factory BookingModel.fromMap(Map<String, dynamic> map) => BookingModel(
    id: map[tblBookingColId],
    carId: map[tblBookingColCarId],
    userId: map[tblBookingColUserId],
    driverId: map[tblBookingColDriverId],
    status: map[tblBookingColStatus],
    pickupAddress: map[tblBookingColPickupAddress],
    fromDate: map[tblBookingColFromDate],
    fromTime: map[tblBookingColFromTime],
    totalFare: map[tblBookingColTotalFare],
    entryUser: map[tblBookingColCarId],
    entryDate: map[tblBookingColCarId],
    approvedUser: map[tblBookingColApprovedUser],
    approvedDate: map[tblBookingColApprovedDate],
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblBookingColCarId: carId,
      tblBookingColUserId: userId,
      tblBookingColDriverId: driverId,
      tblBookingColStatus: status,
      tblBookingColPickupAddress: pickupAddress,
      tblBookingColFromDate: fromDate,
      tblBookingColFromTime: fromTime,
      tblBookingColTotalFare: totalFare,
      tblBookingColEntryUser: entryUser,
      tblBookingColEntryDate: entryDate,
      tblBookingColApprovedUser: entryUser,
      tblBookingColApprovedDate: entryDate,
    };
    if (id != null) {
      map[tblBookingColId] = id;
    }
    return map;
  }
}