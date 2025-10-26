import 'package:algorithm_with_flutter_ui/features/common/state/language_code/language_code_state_type.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/minimum_window_substring/minimun_window_substring_description.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/two_pointer.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/models/two_pointer_model.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_state_type.dart';

class MinimumWindowSubstring extends TwoPointer {
  final _description = MinimunWindowSubstringDescription();

  @override
  String get information => '';

  @override
  TwoPointerStartPosition get left => TwoPointerStartPosition.start;

  @override
  TwoPointerStartPosition get right => TwoPointerStartPosition.start;

  @override
  String get name => 'Minimum Window Substring';

  @override
  String get problem => _description.markdown;

  @override
  String code(LanguageCode language) {
    switch (language) {
      case LanguageCode.cpp: 
        return _description.cppCode;
      case LanguageCode.dart:
        return _description.dartCode;
    }
  }

  @override
  Iterable<({Pointer leftPointer, TwoPointerNode node, int resultLength, Pointer rightPointer})> solve({required List<List<TwoPointerNode>> nodes, required Pointer leftPointer, required Pointer rightPointer, required String input}) sync* {
    // chuỗi t mặc định
    final t = 'abcd';

    int maxRows = nodes.length;

    int r = 0;
    int l = 0;
    int inputLength = input.length;

    // chiều dài của kết quả
    int ans = 9999;

    // lưu lại vị trí bắt đầu và kết thúc của chuỗi đạt yêu cầu range = [start, end]
    Pointer start = rightPointer;
    Pointer end = rightPointer;

    // dùng để đếm chuỗi input
    final a = List.filled(256, 0);

    // dùng để đếm chuỗi t
    final b = List.filled(256, 0);

    // đếm số lần xuất hiện của mỗi ký tự có trong t
    for(int i = 0; i < t.length; i++) {
      b[t.codeUnitAt(i)]++;
    }

    while(r < inputLength) {
      // khoảng từ left -> right đã đủ điều kiện để xét cập nhật hay chưa
      bool ok = true;

      a[input.codeUnitAt(r)]++;

      // node hiện tại
      final node = nodes[rightPointer.row][rightPointer.col];      

      nodes[rightPointer.row][rightPointer.col] = node.copyWith(state: TwoPointerNodeState.processing);

      // cập nhật vị trí của rightPointer
      rightPointer = updatePointer(
        pointer: rightPointer, 
        maxRows: maxRows, 
        nodes: nodes
      );
      
      yield (node: nodes[rightPointer.row][rightPointer.col], rightPointer: rightPointer, leftPointer: leftPointer, resultLength: 0);

      


      /// kiểm tra khoảng từ left -> right có ký tự nào trong [input] có số lần xuất hiện
      /// vượt quá số lần xuất hiện của ký tự đó trong [t] hay không 
      for (var code = 'a'.codeUnitAt(0); code <= 'z'.codeUnitAt(0); code++) {
        if(a[code] < b[code]) {
          ok = false;
          break;
        }
      }

      // chuỗi từ left -> right đạt yêu cầu
      // nếu ký tự ở left xuất hiện nhiều lần hơn trong chuỗi [t] thì có thể loại bỏ
      while(a[input.codeUnitAt(l)] > b[input.codeUnitAt(l)]) {
        a[input.codeUnitAt(l)]--;
        l++;

        var node = nodes[leftPointer.row][leftPointer.col];

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
          resultLength: 0
        );
      }


      final newAns = r - l + 1;
      if(ok && newAns < ans) {

        // cập nhật ans
        ans = newAns;

        start = leftPointer;
        end = rightPointer;

        // duyệt từ (0,0) => (end.row, end.col) - "end" phải giảm 1 đơn vị, nghĩa là sử dụng giá trị của "rightPointer" trước khi cập nhật
        // result (cũ) => discard
        // tạo result (mới)
        for(var row in nodes) {
          for(var node in row) {
            // do `rightPointer` cập nhật trước khi `end` được cập nhật 
            // tuy nhiên việc cập nhật rightPointer là để con trỏ chạy lên (cập nhật animation)
            // con việc xét phạm vi của chuỗi con đạt yêu cầu chỉ xét ở `rightPointer` trước khi cập nhật
            // 
            // "extra" = 0 => khi "r" đã đạt giới hạn, không thể tăng lên nữa (r+1 == inputLenght) => việc tăng "rightPointer" lên cũng là vô nghĩa, khi vòng lặp "while" không đủ điều kiện để chạy tiếp => không cần giảm "end"
            // "extra" = 1 => ngược lại, nếu chưa xét hết các ký tự trong chuỗi "S" => việc tăng "rightPointer" lên và "xét luôn biến đã tăng" => dẫn đến việc cập nhật "node" chưa được "r" trỏ tới
            // [comment "extra" để xem animation là sẽ hiểu]
            final int extra = r + 1 == inputLength ? 0 : 1;

            // -- check phạm vi khi node.row = end.row --
            if(node.row > end.row) break;

            // nếu extra = 1 => không cần xét trường hợp này 
            if(extra != 0) {
              // end = (row: 1, col: 0) => chỉ xét end = (row: 0, col: 9) - ví dụ số cột tối đa = 9 
              if(node.row == end.row && end.col == 0) break; 
            }

            // end = (row: 1, col: 2) => chỉ xét end = (row: 1, col: 2 - extra)
            if(node.row == end.row && node.col > end.col - extra) break;    

            // -- Kết thúc check phạm vi khi node.row = end.row --

            final inRange = _isInRange(row: node.row, col: node.col, start: start, end: end);

            // ---- nằm trong phạm vi từ start -> end => state = result ----
            if(inRange) {
              if(node.state == TwoPointerNodeState.result) continue;
              node = node.copyWith(state: TwoPointerNodeState.result);
              nodes[node.row][node.col] = node;

              yield (
                node: node, 
                rightPointer: rightPointer, 
                leftPointer: leftPointer, 
                resultLength: 0
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
                  resultLength: 0
                );
              }
          }
        }
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






/// -------------------------------------------
/// ------------------------------------------
/// Code gốc, nhưng animation sai
/// ------------------------------------------
/// ------------------------------------------
/// 
// import 'package:algorithm_with_flutter_ui/features/common/state/language_code/language_code_state_type.dart';
// import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/minimum_window_substring/minimun_window_substring_description.dart';
// import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/two_pointer.dart';
// import 'package:algorithm_with_flutter_ui/features/two_pointer/models/two_pointer_model.dart';
// import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_state_type.dart';

// class MinimumWindowSubstring extends TwoPointer {
//   final _description = MinimunWindowSubstringDescription();

//   @override
//   String get information => '';

//   @override
//   TwoPointerStartPosition get left => TwoPointerStartPosition.start;

//   @override
//   TwoPointerStartPosition get right => TwoPointerStartPosition.start;

//   @override
//   String get name => 'Minimum Window Substring';

//   @override
//   String get problem => _description.markdown;

//   @override
//   String code(LanguageCode language) {
//     switch (language) {
//       case LanguageCode.cpp: 
//         return _description.cppCode;
//       case LanguageCode.dart:
//         return _description.dartCode;
//     }
//   }

//   @override
//   Iterable<({Pointer leftPointer, TwoPointerNode node, int resultLength, Pointer rightPointer})> solve({required List<List<TwoPointerNode>> nodes, required Pointer leftPointer, required Pointer rightPointer, required String input}) sync* {
//     // chuỗi t mặc định
//     final t = 'abc';

//     int maxRows = nodes.length;

//     int r = 0;
//     int l = 0;
//     int inputLength = input.length;

//     // chiều dài của kết quả
//     int ans = 9999;

//     // lưu lại vị trí bắt đầu và kết thúc của chuỗi đạt yêu cầu range = [start, end]
//     Pointer start = rightPointer;
//     Pointer end = rightPointer;

//     // dùng để đếm chuỗi input
//     final a = List.filled(256, 0);

//     // dùng để đếm chuỗi t
//     final b = List.filled(256, 0);

//     // đếm số lần xuất hiện của mỗi ký tự có trong t
//     for(int i = 0; i < t.length; i++) {
//       b[t.codeUnitAt(i)]++;
//     }

//     while(r < inputLength) {
//       // khoảng từ left -> right đã đủ điều kiện để xét cập nhật hay chưa
//       bool ok = true;

//       a[input.codeUnitAt(r)]++;


//       /// kiểm tra khoảng từ left -> right có ký tự nào trong [input] có số lần xuất hiện
//       /// vượt quá số lần xuất hiện của ký tự đó trong [t] hay không 
//       for (var code = 'a'.codeUnitAt(0); code <= 'z'.codeUnitAt(0); code++) {
//         if(a[code] < b[code]) {
//           ok = false;
//           break;
//         }
//       }

//       // chuỗi từ left -> right đạt yêu cầu
//       // nếu ký tự ở left xuất hiện nhiều lần hơn trong chuỗi [t] thì có thể loại bỏ
//       while(a[input.codeUnitAt(l)] > b[input.codeUnitAt(l)]) {
//         a[input.codeUnitAt(l)]--;
//         l++;

//         var node = nodes[leftPointer.row][leftPointer.col];

//         // cập nhật vị trí của leftPointer
//         leftPointer = updatePointer(
//           pointer: leftPointer, 
//           maxRows: maxRows, 
//           nodes: nodes
//         );

//         yield (
//           node: node, 
//           rightPointer: rightPointer, 
//           leftPointer: leftPointer, 
//           resultLength: 0
//         );
//       }


//       final newAns = r - l + 1;
//       if(ok && newAns < ans) {

//         // cập nhật ans
//         ans = newAns;

//         start = leftPointer;
//         end = rightPointer;

//         // duyệt từ (0,0) => (end.row, end.col)
//         // result (cũ) => discard
//         // tạo result (mới)
//         for(var row in nodes) {
//           for(var node in row) {
//             // -- check phạm vi khi node.row = end.row
//             if(node.row > end.row) break;
//             if(node.row == end.row && node.col > end.col) break;            

//             final inRange = _isInRange(row: node.row, col: node.col, start: start, end: end);

//             // ---- nằm trong phạm vi từ start -> end => state = result ----
//             if(inRange) {
//               if(node.state == TwoPointerNodeState.result) continue;
//               node = node.copyWith(state: TwoPointerNodeState.result);
//               nodes[node.row][node.col] = node;

//               yield (
//                 node: node, 
//                 rightPointer: rightPointer, 
//                 leftPointer: leftPointer, 
//                 resultLength: 0
//               );
//             } else 
//               // ---- Node không nằm trong phạm vi start -> end nhưng nó có state = result => loại bỏ node => state = discard ----
//               if(node.state == TwoPointerNodeState.result) {
//                 node = node.copyWith(state: TwoPointerNodeState.discarded);
//                 nodes[node.row][node.col] = node;

//                 yield (
//                   node: node, 
//                   rightPointer: rightPointer, 
//                   leftPointer: leftPointer, 
//                   resultLength: 0
//                 );
//               }
//           }
//         }
//       } else {
//         // node hiện tại
//         final node = nodes[rightPointer.row][rightPointer.col];      

//         nodes[rightPointer.row][rightPointer.col] = node.copyWith(state: TwoPointerNodeState.processing);
        
//         yield (node: nodes[rightPointer.row][rightPointer.col], rightPointer: rightPointer, leftPointer: leftPointer, resultLength: 0);
//       }

//       // cập nhật vị trí của rightPointer
//       rightPointer = updatePointer(
//         pointer: rightPointer, 
//         maxRows: maxRows, 
//         nodes: nodes
//       );

//       r++;
//     }

//   }

//   /// hàm cập nhật pointer
//   /// 
//   /// xử lý các trường hợp: pointer.col++, pointer.row++
//   Pointer updatePointer({
//     required Pointer pointer, required int maxRows, required List<List<TwoPointerNode>> nodes
//   }) {
//     final maxCols = nodes[pointer.row].length;
//     final row = pointer.row;
//     final col = pointer.col;
//     if(col < maxCols - 1) {
//       return (row: row, col: col + 1);
//     } else if(col == maxCols - 1 && row < maxRows - 1) {
//       return (row: row + 1, col: 0);
//     }

//     return pointer;
//   }

//   /// Kiếm tra `row` & `col` có nằm trong range = [`start`, `end`] hay không
//   bool _isInRange({
//     required int row,
//     required int col,
//     required Pointer start,
//     required Pointer end,
//   }) {
//     final minRow = start.row <= end.row ? start.row : end.row;
//     final maxRow = start.row >= end.row ? start.row : end.row;

//     if(row > maxRow || row < minRow) return false;

//     if(row == minRow) {
//       return col >= start.col;
//     }

//     if(row == maxRow) {
//       return col <= end.col;
//     }

//     return true;
//   }

// }