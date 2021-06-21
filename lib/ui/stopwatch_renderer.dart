import 'dart:math';

import 'package:flutter/material.dart';

import 'clock_markers.dart';

class StopwatchRenderer extends StatelessWidget {
  const StopwatchRenderer({Key? key, required this.radius}) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var i = 0; i < 60; i++) ...{
          Positioned(
            left: radius,
            top: radius,
            child: ClockSecondsTickMarker(
              seconds: i,
              radius: radius,
            ),
          ),
        },
        for (var i = 5; i <= 60; i += 5) ...{
          Positioned(
            left: radius,
            top: radius,
            child: ClockTextMarker(
              radius: radius,
              maxValue: 60,
              value: i,
            ),
          )
        },
      ],
    );
  }
}
