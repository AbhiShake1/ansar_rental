import 'package:ansar_rental/app/bindings/initial_binding.dart';
import 'package:ansar_rental/app/config/constants.dart';
import 'package:ansar_rental/app/config/theme.dart';
import 'package:ansar_rental/app/routes/app_pages.dart';
import 'package:ansar_rental/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'ADMIN',
  );

  await GetStorage.init(AppConst.cacheUser);

  //ignore errors
  // FlutterError.onError = (_) {};

  // FlutterError.onError = (details) {
  //   log(details.exceptionAsString(), stackTrace: details.stack);
  // };

  runApp(
    ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        initialBinding: InitialBinding(),
        title: 'Ansar Rental',
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
      ),
    ),
  );
}
