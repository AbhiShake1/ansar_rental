import 'dart:ui';

import 'package:ansar_rental/app/widgets/widgets.dart';
import 'package:get/get.dart';

Future<void> callService(
  Future<void> Function() asyncFunction, {
  VoidCallback? onSuccess,
  void Function(dynamic error)? onFailure,
}) =>
    Get.showOverlay(
      asyncFunction: () async {
        try {
          await asyncFunction();
          onSuccess?.call();
        } catch (e) {
          onFailure?.call(e);
        }
      },
      loadingWidget: const LoadingWidget(),
    );
