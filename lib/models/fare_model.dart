const String tblCarFare = 'tblCarFare';
const String tblCarFareColId = 'id';
const String tblCarFareColCarId = 'carId';
const String tblCarFareColCarFare = 'carFare';
const String tblCarFareColIsInsideDhaka = 'isInsideDhaka';
const String tblCarFareColEntryUser = 'entryUser';
const String tblCarFareColEntryDate = 'entryDate';

class CarFareModel {
  int? id;
  int carId;
  double carFare;
  bool isInsideDhaka = true;
  String? entryUser;
  String? entryDate;

  CarFareModel(
      {this.id,
      required this.carId,
      required this.carFare,
      required this.isInsideDhaka,
      this.entryUser,
      this.entryDate});

  factory CarFareModel.fromMap(Map<String, dynamic> map) => CarFareModel(
        id: map[tblCarFareColId],
        carId: map[tblCarFareColCarId],
        carFare: map[tblCarFareColCarFare],
        isInsideDhaka: map[tblCarFareColIsInsideDhaka] == null
            ? false
            : map[tblCarFareColIsInsideDhaka] == 0
                ? false
                : true,
        entryUser: map[tblCarFareColEntryUser],
        entryDate: map[tblCarFareColEntryDate],
      );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblCarFareColCarId: carId,
      tblCarFareColCarFare: carFare,
      tblCarFareColIsInsideDhaka: isInsideDhaka,
      tblCarFareColEntryUser: entryUser,
      tblCarFareColEntryDate: entryDate,
    };
    if (id != null) {
      map[tblCarFareColId] = id;
    }
    return map;
  }
}
