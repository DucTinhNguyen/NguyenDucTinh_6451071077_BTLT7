import 'package:flutter/material.dart';
import '../views/user_list_screen.dart';

class AppRoutes {
  static const String userList = '/users';

  static Map<String, WidgetBuilder> routes = {
    userList: (context) => UserListScreen(),
  };
}