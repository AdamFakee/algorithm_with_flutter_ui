import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/two_pointer.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/models/two_pointer_model.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_state_type.dart';

class SmallestWindown extends TwoPointer {
  @override
  String get information => throw UnimplementedError();

  @override
  String get name => "Smallest Window";

  @override
  TwoPointerStartPosition get left => TwoPointerStartPosition.start;

  @override
  TwoPointerStartPosition get right => TwoPointerStartPosition.start;

  @override
  Iterable<({TwoPointerNode node, Pointer rightPointer, Pointer leftPointer, int resultLength})> solve ({
    required List<List<TwoPointerNode>> nodes, 
    required Pointer leftPointer, 
    required Pointer rightPointer,
    required String input
  }) sync* {
    final maxRows = nodes.length;

    /// `se` chứa các ký tự khác nhau có trong input
    final se = input.split('').toSet();
    final size = se.length;
    final inputLength = input.length;

    // tạo mảng a với length = 256 và a[x] = 0
    // 256 đại diện cho 256 ký tự trong bảng mã ascii
    final a = List.filled(256, 0);

    // vị trí xuất phát của con trỏ phải
    var r = 0;

    // vị trí xuất phát của con trỏ trái
    var l = 0;

    // đếm số ký tự khác nhau
    int cnt = 0;

    // chuỗi kết quả
    String result = input;

    // chiều dài chuỗi con có các ký tự khác nhau ngắn nhất
    int ans = 99999;


    while(r < inputLength) {
      final cntApear = ++a[input.codeUnitAt(r)];
      if(cntApear == 1) cnt++;

      // kiểm tra chuỗi đã đủ ký tự khác nhau hay chưa 
      // cập nhật kết quả nếu đủ điều kiện 
      if(cnt == size) {
        final newAns = r - l + 1;
        if(newAns < ans) {
          ans = newAns;
          result = input.substring(l, r + 1);
        }
      }

      // cập nhật node
      final node = nodes[rightPointer.row][rightPointer.col];
      nodes[rightPointer.row][rightPointer.col] = node.copyWith(state: TwoPointerNodeState.processing);

      // cập nhật vị trí của rightPointer
      rightPointer = updatePointer(
        pointer: rightPointer, 
        maxRows: maxRows, 
        nodes: nodes
      );

      yield (node: nodes[rightPointer.row][rightPointer.col], rightPointer: rightPointer, leftPointer: leftPointer, resultLength: result.length);


      while(a[input.codeUnitAt(l)] > 1) {
        a[input.codeUnitAt(l)]--;
        l++;

        final node = nodes[leftPointer.row][leftPointer.col];
        nodes[leftPointer.row][leftPointer.col] = node.copyWith(state: TwoPointerNodeState.discarded);

        // cập nhật vị trí của leftPointer
        leftPointer = updatePointer(
          pointer: leftPointer, 
          maxRows: maxRows, 
          nodes: nodes
        );

        yield (node: nodes[leftPointer.row][leftPointer.col], rightPointer: rightPointer, leftPointer: leftPointer, resultLength: result.length);
      }

      r++;
    }
  }

  // hàm cập nhật pointer
  // xử lý các trường hợp: pointer.col++, pointer.row++
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
}