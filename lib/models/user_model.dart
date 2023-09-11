const String tblUser = 'tblUser';
const String tblUserColId = 'userId';
const String tblUserColName = 'name';
const String tblUserColPassword = 'password';
const String tblUserColMobileNo = 'mobileNumber';
const String tblUserColEmail = 'email';
const String tblUserColAddress = 'address';
const String tblUserColStatus = 'status';
const String tblUserColImage = 'image';
const String tblUserColIsLoggedIn = 'loggedIn';
const String tblUserColLoginTime = 'loginTime';
const String tblUserColLogoutTime = 'logoutTime';

class UserModel {
  int? userId;
  String name;
  String password;
  String? mobileNo;
  String? email;
  String? address;
  String? status;
  String? image;
  bool isLoggedIn;
  String? loginTime;
  String? logoutTime;

  UserModel(
      {this.userId,
      required this.name,
      required this.password,
      this.mobileNo,
      this.email,
      this.address,
      this.status,
      this.image,
      required this.isLoggedIn,
      this.loginTime,
      this.logoutTime});

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
      userId: map[tblUserColId],
      name: map[tblUserColName],
      password: map[tblUserColPassword],
      mobileNo: map[tblUserColMobileNo],
      email: map[tblUserColEmail],
      address: map[tblUserColEmail],
      status: map[tblUserColEmail],
      image: map[tblUserColEmail],
      isLoggedIn: map[tblUserColIsLoggedIn] == 0 ? false : true,
      loginTime: map[tblUserColLoginTime],
      logoutTime: map[tblUserColLogoutTime]);
}
