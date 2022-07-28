import 'package:ansar_rental/app/routes/app_pages.dart';
import 'package:ansar_rental/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      title: 'Ansar Rental',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
