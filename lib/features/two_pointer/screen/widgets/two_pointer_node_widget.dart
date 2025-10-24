import 'package:algorithm_with_flutter_ui/features/two_pointer/models/two_pointer_model.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_provider.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TwoPointerNodeWidget extends ConsumerWidget {
  final int row;
  final int col;

  const TwoPointerNodeWidget({super.key, required this.row, required this.col});

  @override
  Widget build(BuildContext context, ref) {
    final node = ref.watch(twoPointerProvider.select((state) {
      // khi state.nodes được gán lại với kích thước nhỏ hơn
      // => node.row & node.col sẽ vượt quá kích thước => gây ra lỗi RangeError
      // => Lỗi này xảy ra khả năng là state.nodes vừa cập nhật => gây trigger cho node (ở widget này) thay đổi => báo lỗi
      // => Cách xử lý: tạo nodes rỗng để chờ widget cha re-build 
      if (row >= state.nodes.length || col >= state.nodes[row].length) {
        // Widget cha re-build và loại bỏ widget này.
        return TwoPointerNode(row: row, col: col, value: ''); 
      }
      return state.nodes[row][col];
    }));

    return Container(
      width: Sizes.twoPointerNodeWidth,
      height: Sizes.twoPointerNodeWidth,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black
        ),
        color: node.state.color
      ),
      child: Center(
        child: Text(
          node.value, 
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: node.state != TwoPointerNodeState.none ? Colors.white : Colors.black
          ),
        )
      )
    );
  }
}