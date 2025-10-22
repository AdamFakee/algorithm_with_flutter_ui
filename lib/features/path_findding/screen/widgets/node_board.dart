import 'package:algorithm_with_flutter_ui/utils/consts/sizes.dart';
import 'package:algorithm_with_flutter_ui/utils/extentions/context_extensions.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/screen/widgets/node_widget.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/state/path_findding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NodeBoard extends ConsumerWidget {
  const NodeBoard({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final nodes = ref.read(pathFinddingProvider).nodes;

    // chỉ định dùng với widget nào
    final boxKey = GlobalObjectKey('board_key');

    
    (int, int) caculateNodeCoordinate (Offset globalPosition) {
      final totalRow = ref.read(pathFinddingProvider.notifier).totalRow;
      final totalCol = ref.read(pathFinddingProvider.notifier).totalCol;

      final boardBox = boxKey.currentContext?.findRenderObject() as RenderBox;
      // toạ độ của cú click ở trong box
      final localPosition = boardBox.globalToLocal(globalPosition);
      final boardWidth = boardBox.size.width;

      final nodeSize = boardWidth / totalRow;

      final row = (localPosition.dy ~/ nodeSize).clamp(0, totalCol - 1);
      final col = (localPosition.dx ~/ nodeSize).clamp(0, totalRow - 1);
      return (row, col);
    }

    void onDragStart(DragStartDetails details) {
      final (row, col) = caculateNodeCoordinate(details.globalPosition);
      ref.read(pathFinddingProvider.notifier).onDragStart(row, col);
    }

    void onDragUpdate(DragUpdateDetails details) {
      final (row, col) = caculateNodeCoordinate(details.globalPosition);
      ref.read(pathFinddingProvider.notifier).onDragUpdate(row, col);
    }

    void onDragEnd(DragEndDetails details) {
      final (row, col) = caculateNodeCoordinate(details.globalPosition);
      ref.read(pathFinddingProvider.notifier).onDragEnd(row, col);
    }

    return GestureDetector(
      onPanStart: onDragStart,
      onPanUpdate: onDragUpdate,
      onPanEnd: onDragEnd,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          key: boxKey,
          width: context.width - Sizes.padding * 2,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            )
          ),
          child: Column(
            children: List.generate(nodes.length, (row) {
              return Row(
                children: List.generate(nodes[row].length, (col) {
                  return NodeWidget(row: row, col: col);
                })
              );
            })
          ),
        ),
      ),
    );
  }
}