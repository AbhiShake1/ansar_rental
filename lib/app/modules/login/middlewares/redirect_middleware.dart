import 'package:ansar_rental/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RedirectMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) => RouteSettings(
        name: FirebaseAuth.instance.currentUser == null
            ? Routes.LOGIN
            : Routes.HOME,
      );
}
