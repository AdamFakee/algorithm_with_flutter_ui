import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_provider.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TwoPointerPositionWidget extends StatelessWidget {
  final bool leftPointer;
  final ({double top, double left}) Function(int, int) caculatePosition;

  const TwoPointerPositionWidget({super.key, required this.leftPointer, required this.caculatePosition});


  final double _translateDy = 25;

  @override
  Widget build(BuildContext context) {
    return leftPointer ? leftPointerWidget() : rightPointerWidget();
  }

  Widget rightPointerWidget () {
    return Consumer(
      builder: (context, ref, child) {
        final rightPointer = ref.watch(twoPointerProvider).rightPointer;

        final pos = caculatePosition(rightPointer.row, rightPointer.col);


        return AnimatedPositioned(
          top: pos.top - _translateDy,
          left: pos.left,
          duration: Duration(milliseconds: 200),
          child: Icon(
            Icons.arrow_downward,
            color: AppColors.right,
            size: 24,
          ),
        );
      },
    );
  }

  Widget leftPointerWidget () {
    return Consumer(
      builder: (context, ref, child) {
        final leftPointer = ref.watch(twoPointerProvider).leftPointer;

        final pos = caculatePosition(leftPointer.row, leftPointer.col);


        return AnimatedPositioned(
          top: pos.top + _translateDy,
          left: pos.left,
          duration: Duration(milliseconds: 200),
          child: Icon(
            Icons.arrow_upward,
            color: AppColors.left,
            size: 24,
          ),
        );
      },
    );
  }
}