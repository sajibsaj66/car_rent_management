const String tblAdmin = 'tblAdmin';
const String tblAdminColId = 'adminId';
const String tblAdminColName = 'name';
const String tblAdminColPassword = 'password';
const String tblAdminColMobileNo = 'mobileNumber';
const String tblAdminColEmail = 'email';
const String tblAdminColEntryUser = 'entryUser';
const String tblAdminColEntryDate = 'entryDate';
const String tblAdminColIsSuperAdmin = 'isSuperAdmin';
const String tblAdminColIsLoggedIn = 'loggedIn';
const String tblAdminColLoginTime = 'loginTime';
const String tblAdminColLogoutTime = 'logoutTime';


class AdminModel {
  int? adminId;
  String name;
  String password;
  String? mobileNo;
  String? email;
  String? entryUser;
  String? entryDate;
  bool isLoggedIn;
  bool isSuperAdmin;
  String? loginTime;
  String? logoutTime;


  AdminModel({
    this.adminId,
    required this.name,
    required this.password,
    this.mobileNo,
    this.email,
    required this.isSuperAdmin,
    this.entryUser,
    this.entryDate,
    required this.isLoggedIn,
    this.loginTime,
    this.logoutTime
  });


  factory AdminModel.fromMap
      (Map<String, dynamic> map) =>
      AdminModel(
          adminId: map[tblAdminColId],
          name: map[tblAdminColName],
          password: map[tblAdminColPassword],
          mobileNo: map[tblAdminColMobileNo],
          email: map[tblAdminColEmail],
          isSuperAdmin: map[tblAdminColIsSuperAdmin] == 0 ? false : true,
          entryUser: map[tblAdminColEntryUser],
          entryDate: map[tblAdminColEntryDate],
          isLoggedIn: map[tblAdminColIsLoggedIn] == 0 ? false : true,
          loginTime: map[tblAdminColLoginTime],
          logoutTime: map[tblAdminColLogoutTime]
      );

}