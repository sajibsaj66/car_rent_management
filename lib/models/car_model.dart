const String tblCar = 'tblCar';
const String tblCarColId = 'carId';
const String tblCarColCarModel = 'carModel';
const String tblCarColBrand = 'brand';
const String tblCarColDes = 'description';
const String tblCarColSeatNo = 'seatNo';
const String tblCarColImage = 'image';
const String tblCarColEntryUser = 'entryUser';
const String tblCarColEntryDate = 'entryDate';
const String tblCarColIsAvailable = 'isAvailable';

class CarModel {
  int? carId;
  String carModel;
  String brand;
  String? description;
  int seatNo;
  String image;
  String? entryUser;
  String? entryDate;
  bool isAvailable = true;

  CarModel(
      {this.carId,
      required this.carModel,
      required this.brand,
      this.description,
      required this.seatNo,
      required this.image,
      this.entryUser,
      this.entryDate,
      required this.isAvailable});

  factory CarModel.fromMap(Map<String, dynamic> map) => CarModel(
        carId: map[tblCarColId],
        carModel: map[tblCarColCarModel],
        brand: map[tblCarColBrand],
        description: map[tblCarColDes],
        seatNo: map[tblCarColSeatNo],
        image: map[tblCarColImage],
        entryUser: map[tblCarColEntryUser],
        entryDate: map[tblCarColEntryDate],
        isAvailable: map[tblCarColIsAvailable] == null ? false :
        map[tblCarColIsAvailable] == 0 ? false : true,
      );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblCarColCarModel: carModel,
      tblCarColBrand: brand,
      tblCarColDes: description,
      tblCarColSeatNo: seatNo,
      tblCarColImage: image,
      tblCarColEntryUser: entryUser,
      tblCarColEntryDate: entryDate,
      tblCarColIsAvailable: isAvailable,
    };
    if (carId != null) {
      map[tblCarColId] = carId;
    }
    return map;
  }
}
