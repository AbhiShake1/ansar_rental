import 'package:ansar_rental/app/modules/home/bindings/home_binding.dart';
import 'package:ansar_rental/app/modules/home/views/home_view.dart';
import 'package:ansar_rental/app/modules/login/bindings/login_binding.dart';
import 'package:ansar_rental/app/modules/login/middlewares/redirect_middleware.dart';
import 'package:ansar_rental/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      middlewares: [
        RedirectMiddleware(),
      ],
    ),
  ];
}
