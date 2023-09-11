const String tblDriver = 'tblDriver';
const String tblDriverColId = 'driverId';
const String tblDriverColName = 'name';
const String tblDriverColAddress = 'address';
const String tblDriverColEmail = 'email';
const String tblDriverColNID = 'nid';
const String tblDriverColMobileNo = 'seatNo';
const String tblDriverColEntryUser = 'entryUser';
const String tblDriverColEntryDate = 'entryDate';
const String tblDriverColImage = 'image';
const String tblDriverColIsAvailable = 'isAvailable';

class DriverModel {
  int? driverId;
  String name;
  String address;
  String mobileNo;
  String? email;
  String nid;
  String? entryUser;
  String? entryDate;
  String? image;
  bool isAvailable = true;

  DriverModel(
      {this.driverId,
      required this.name,
      required this.address,
      required this.mobileNo,
      this.email,
      required this.nid,
      this.entryUser,
      this.entryDate,
      required this.image,
      required this.isAvailable});

  factory DriverModel.fromMap(Map<String, dynamic> map) => DriverModel(
        driverId: map[tblDriverColId],
        name: map[tblDriverColName],
        address: map[tblDriverColAddress],
        email: map[tblDriverColEmail],
        nid: map[tblDriverColNID],
        mobileNo: map[tblDriverColMobileNo],
        entryUser: map[tblDriverColEntryUser],
        entryDate: map[tblDriverColEntryDate],
        image: map[tblDriverColImage],
        isAvailable: map[tblDriverColIsAvailable] == null ? false :
        map[tblDriverColIsAvailable] == 0 ? false : true,
      );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblDriverColName: name,
      tblDriverColAddress: address,
      tblDriverColEmail: email,
      tblDriverColNID: nid,
      tblDriverColMobileNo: mobileNo,
      tblDriverColEntryUser: entryUser,
      tblDriverColEntryDate: entryDate,
      tblDriverColImage: image,
      tblDriverColIsAvailable : isAvailable,
    };
    if (driverId != null) {
      map[tblDriverColId] = driverId;
    }
    return map;
  }
}
