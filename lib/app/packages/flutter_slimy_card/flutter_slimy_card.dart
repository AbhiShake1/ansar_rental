import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class FlutterSlimyCard extends StatefulWidget {
  const FlutterSlimyCard({
    super.key,
    this.color = const Color(0xffFF6347),
    this.cardWidth = 300,
    this.topCardHeight = 300,
    this.bottomCardHeight = 150,
    this.borderRadius = 25,
    required this.topCardWidget,
    required this.bottomCardWidget,
    this.slimeEnabled = true,
  });

  final Color color;
  final double cardWidth;
  final double topCardHeight;
  final double bottomCardHeight;
  final double borderRadius;
  final Widget topCardWidget;
  final Widget bottomCardWidget;
  final bool slimeEnabled;

  @override
  _FlutterSlimyCardState createState() => _FlutterSlimyCardState();
}

class _FlutterSlimyCardState extends State<FlutterSlimyCard> {
  bool? isSeparated;
  double? bottomDimension;
  double? initialBottomDimension;
  double? finalBottomDimension;
  double? gap;
  double? gapInitial;
  double? gapFinal;
  double? x;
  double? y;
  late Widget topCardWidget;
  late Widget bottomCardWidget;
  Animation<double>? arrowAnimation;

  void action() {
    if (isSeparated!) {
      isSeparated = false;
      gap = gapInitial;
      bottomDimension = initialBottomDimension;
    } else {
      isSeparated = true;
      gap = gapFinal;
      bottomDimension = finalBottomDimension;
    }
  }

  @override
  void initState() {
    isSeparated = false;
    initialBottomDimension = 0;
    finalBottomDimension = widget.bottomCardHeight;
    bottomDimension = initialBottomDimension;
    topCardWidget = widget.topCardWidget;
    bottomCardWidget = widget.bottomCardWidget;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    x = (widget.borderRadius < 10) ? 10 : widget.borderRadius;
    y = (widget.borderRadius < 2) ? 2 : widget.borderRadius;
    gapInitial = ((widget.topCardHeight - x! - widget.cardWidth / 4) > 0)
        ? (widget.topCardHeight - x! - widget.cardWidth / 4)
        : 0;
    gapFinal = ((widget.topCardHeight + x! - widget.cardWidth / 4 + 50) > 0)
        ? (widget.topCardHeight + x! - widget.cardWidth / 4 + 20)
        : 2 * x! + 20;
    gap = gapInitial;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(action),
      child: [
        Column(
          children: [
            AnimatedContainer(
              duration: 1800.milliseconds,
              height: gap,
              curve: Curves.elasticOut,
            ),
            Container(
              height: bottomDimension,
              width: widget.cardWidth,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: [
                  Lottie.asset(
                    'assets/lottie/home.json',
                  ).opacity(value: .2),
                  bottomCardWidget,
                ].stack(),
              ),
            ).pOnly(bottom: 10),
          ],
        ),
        topCardWidget,
        110.heightBox,
      ].stack(alignment: Alignment.topCenter),
    );
  }
}
