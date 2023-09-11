
import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel userModel;

  Future<UserModel?> getUserByMobile(String mobile) =>
      DbHelper.getUserByMobile(mobile);

  Future<UserModel?> getUserByEmail(String email) =>
      DbHelper.getUserByEmail(email);
}
