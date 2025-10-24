import 'package:algorithm_with_flutter_ui/features/two_pointer/screen/widgets/two_pointer_node_widget.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/screen/widgets/two_pointer_position_widget.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_provider.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TwoPointerNodeBoard extends ConsumerWidget {
  const TwoPointerNodeBoard({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final nodes = ref.watch(twoPointerProvider).nodes;

    return SizedBox(
      width: double.infinity,
      height: 400,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxRows = nodes.length;
          final maxCols = nodes[0].length;

          final totalNodesHeight = Sizes.twoPointerNodeWidth * maxRows + Sizes.twoPointerVertical * (maxRows - 1);
          final totalNodesWidth = Sizes.twoPointerNodeWidth * maxCols + Sizes.twoPointerNodeHorizontal * (maxCols - 1);

          // Vị trí bắt đầu (top-left) để căn giữa lưới (Căn giữa toàn bộ nodes)
          final startTop = (400 - totalNodesHeight) / 2;
          final startLeft = (constraints.maxWidth - totalNodesWidth) / 2;

          // tính toán vị trí của node hoặc con trỏ dựa trên chỉ số (row, col)
          ({double top, double left}) caculatePostion(int row, int col) {
            final double left = startLeft + col * (Sizes.twoPointerNodeWidth + Sizes.twoPointerNodeHorizontal);
            final double top = startTop + row * (Sizes.twoPointerNodeWidth + Sizes.twoPointerVertical);
            return (left: left, top: top);
          }

          return Stack(
            children: [
              // danh sách các nodes
              ...List.generate(nodes.length, (row) {
                return List.generate(nodes[row].length, (col) {
                  final pos = caculatePostion(row, col);
                  return Positioned(
                    top: pos.top,
                    left: pos.left,
                    child: TwoPointerNodeWidget(row: row, col: col)
                  );
                });
              }).expand((e) => e),

              // con trỏ phải
              TwoPointerPositionWidget(
                leftPointer: false,
                caculatePosition: caculatePostion,
              ),

              // con trỏ trái
              TwoPointerPositionWidget(
                leftPointer: true,
                caculatePosition: caculatePostion, 
              )
            ]
          );
        }
      ),
    );
  }
}
