import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/two_pointer.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/models/two_pointer_model.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_state_type.dart';

class LongestUniqueSubstring extends TwoPointer {
  @override
  String get information => throw UnimplementedError();

  @override
  String get name => "Longest Unique Substring";

  @override
  TwoPointerStartPosition get left => TwoPointerStartPosition.start;

  @override
  TwoPointerStartPosition get right => TwoPointerStartPosition.start;

  @override
  Iterable<({
    Pointer leftPointer, 
    TwoPointerNode node, 
    int resultLength, 
    Pointer rightPointer
  })> solve({
    required List<List<TwoPointerNode>> nodes, 
    required Pointer leftPointer, 
    required Pointer rightPointer, 
    required String input
  }) sync* {
    final maxRows = nodes.length;

    final inputLength = input.length;

    // tạo mảng a với length = 256 và a[x] = 0
    // 256 đại diện cho 256 ký tự trong bảng mã ascii
    final a = List.filled(256, 0);

    // chiều dài chuỗi con có các ký tự khác nhau liên tiếp dài nhất
    int ans = 0;

    // vị trí xuất phát của con trỏ phải
    var r = 0;

    // vị trí xuất phát của con trỏ trái
    var l = 0;

    // lưu lại vị trí bắt đầu và kết thúc của chuỗi đạt yêu cầu range = [start, end]
    Pointer start = rightPointer;
    Pointer end = rightPointer;


    // chuỗi kết quả
    String result = "";

    while(r < inputLength) {
      a[input.codeUnitAt(r)]++;

      while(a[input.codeUnitAt(r)] > 1) {
        a[input.codeUnitAt(l)]--;
        l++;

        final node = nodes[leftPointer.row][leftPointer.col];

        // cập nhật vị trí của leftPointer
        leftPointer = updatePointer(
          pointer: leftPointer, 
          maxRows: maxRows, 
          nodes: nodes
        );

        yield (
          node: node, 
          rightPointer: rightPointer, 
          leftPointer: leftPointer, 
          resultLength: result.length
        );
      }


      // cập nhật vị trí của rightPointer
      rightPointer = updatePointer(
        pointer: rightPointer, 
        maxRows: maxRows, 
        nodes: nodes
      );

      // độ dài của chuỗi con 
      final newAns = r - l + 1;

      // ---- đã tìm ra chuỗi con mới dài hơn ----
      if(newAns > ans) {
        ans = newAns;

        start = leftPointer;
        end = rightPointer;

        for(var row in nodes) {
          for(var node in row) {
            if(node.row > end.row) break;
            if(node.row == end.row && node.col > end.col) break;            

            final inRange = _isInRange(row: node.row, col: node.col, start: start, end: end);

            // ---- nằm trong phạm vi từ start -> end => state = result ----
            if(inRange) {
              node = node.copyWith(state: TwoPointerNodeState.result);
              nodes[node.row][node.col] = node;

              yield (
                node: node, 
                rightPointer: rightPointer, 
                leftPointer: leftPointer, 
                resultLength: result.length
              );
            } else 
              // ---- Node không nằm trong phạm vi start -> end nhưng nó có state = result => loại bỏ node => state = discard ----
              if(node.state == TwoPointerNodeState.result) {
                node = node.copyWith(state: TwoPointerNodeState.discarded);
                nodes[node.row][node.col] = node;

                yield (
                  node: node, 
                  rightPointer: rightPointer, 
                  leftPointer: leftPointer, 
                  resultLength: result.length
                );
              }
          }
        }
      } else {
        // ---- nếu không tìm ra được chuỗi con dài hơn => các node sẽ được chuyển về state = processing ------


        // node hiện tại
        final node = nodes[rightPointer.row][rightPointer.col];      
        nodes[rightPointer.row][rightPointer.col] = node.copyWith(state: TwoPointerNodeState.processing);
        
        yield (node: nodes[rightPointer.row][rightPointer.col], rightPointer: rightPointer, leftPointer: leftPointer, resultLength: result.length);
      }

      r++;
      
    }
  }

  /// hàm cập nhật pointer
  /// 
  /// xử lý các trường hợp: pointer.col++, pointer.row++
  Pointer updatePointer({
    required Pointer pointer, required int maxRows, required List<List<TwoPointerNode>> nodes
  }) {
    final maxCols = nodes[pointer.row].length;
    final row = pointer.row;
    final col = pointer.col;
    if(col < maxCols - 1) {
      return (row: row, col: col + 1);
    } else if(col == maxCols - 1 && row < maxRows - 1) {
      return (row: row + 1, col: 0);
    }

    return pointer;
  }

  /// Kiếm tra `row` & `col` có nằm trong range = [`start`, `end`] hay không
  bool _isInRange({
    required int row,
    required int col,
    required Pointer start,
    required Pointer end,
  }) {
    final minRow = start.row <= end.row ? start.row : end.row;
    final maxRow = start.row >= end.row ? start.row : end.row;

    if(row > maxRow || row < minRow) return false;

    if(row == minRow) {
      return col >= start.col;
    }

    if(row == maxRow) {
      return col <= end.col;
    }

    return true;
  }

}