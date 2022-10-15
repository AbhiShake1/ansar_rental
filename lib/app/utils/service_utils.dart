import 'dart:ui';

import 'package:ansar_rental/app/views/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Future<void> callService(
  Future<void> Function() asyncFunction, {
  bool showLoading = true,
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
      loadingWidget:
          showLoading ? const LoadingWidget() : const SizedBox.shrink(),
    );
