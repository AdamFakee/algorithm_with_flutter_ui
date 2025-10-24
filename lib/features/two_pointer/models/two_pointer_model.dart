import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:flutter/material.dart';

enum TwoPointerNodeState {
  none(AppColors.white),
  processing(AppColors.primary), // đang được duyệt
  result(AppColors.yellow), // kết quả cuối cùng
  discarded(Colors.red); // được duyệt nhưng bị huỷ vì không hợp lệ hoặc không tối ưu

  const TwoPointerNodeState(this.color);
  final Color color;
}

class TwoPointerNode {
  final int row;
  final int col;
  String value;
  final TwoPointerNodeState state;

  TwoPointerNode({
    required this.row,
    required this.col,
    required this.value,
    this.state = TwoPointerNodeState.none,
  });

  TwoPointerNode copyWith({
    String? value,
    int? row,
    int? col,
    TwoPointerNodeState? state,
  }) {
    return TwoPointerNode(
      row: row ?? this.row,
      col: col ?? this.col,
      value: value ?? this.value,
      state: state ?? this.state,
    );
  }
}




