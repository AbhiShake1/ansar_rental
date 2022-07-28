import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5,
        sigmaY: 5,
      ),
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, .25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const CircularProgressIndicator().p(10),
        ),
      ),
    );
  }
}
