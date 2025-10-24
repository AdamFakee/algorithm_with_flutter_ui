import 'package:flutter/material.dart';

class RectangleContainer extends StatelessWidget {
  final double? width;
  final double? height;

  const RectangleContainer({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black
        )
      ),
    );
  }
}