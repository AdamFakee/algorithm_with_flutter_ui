import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/longest_unique_substring/longest_unique_substring.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/smallest_windown/smallest_windown.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/two_pointer.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/models/two_pointer_model.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_state_type.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/durations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TwoPointerState extends Notifier<TwoPointerStateType> {
  @override
  TwoPointerStateType build() {
    final input = 'abcadedfghikjahkaaaaaaaaaqwertyuiopasdf';
    // final totalRows = (input.length / _maxCols).ceil();
    final nodes = _genNodeByInput(input, _maxCols);

    // _maxRows =  (input.length / _maxCols).ceil();

    return TwoPointerStateType(
      nodes: nodes,
      input: input,
      // totalCols: _maxCols,
      // totalRows: totalRows
    );
  }

  /// số cột lớn nhất có thể đạt được
  final _maxCols = 10;
  int _maxRows = 1;

  /// danh sách các thuật toán hỗ trợ
  final algorithms = [
    SmallestWindown(), LongestUniqueSubstring()
  ];

  
  /// tạo nodes bằng `input`
  /// 
  /// `cols` : ban đầu khởi tạo state sẽ chưa có `totalCols` => cần truyền vào. Còn những lần sử dụng sau sẽ lấy trong `state` nếu như không truyền vào
  List<List<TwoPointerNode>> _genNodeByInput(String input, [int? cols]) {
    _maxRows = (input.length / _maxCols).ceil();

    int index = 0;

    return List.generate(_maxRows, (row) {
      return List.generate(_maxCols, (col) {
        // Nếu đã hết input → không tạo node nữa
        // Trả về null
        if (index >= input.length) {
          return null;
        }

        final char = input[index];
        index++;
        return TwoPointerNode(
          row: row,
          col: col,
          value: char,
        );
      }).whereType<TwoPointerNode>().toList(); // lọc bỏ null
    });
  }


  /// Cập nhật input và tạo lại nodes
  void setInput(String input) {
    if(input == state.input || input.isEmpty) return;

    // tính toán lại totalRows
    _maxRows = (input.length / _maxCols).ceil();
    // state = state.copyWith(totalRows: totalRows);

    final nodes = _genNodeByInput(input);

    state = state.copyWith(
      input: input.trim(),
      nodes: nodes
    );
  }

  void _updateNode({
    required TwoPointerNode node,
    Pointer? leftPointer,
    Pointer? rightPointer
  }) {
    final newNodes = state.nodes;

    newNodes[node.row][node.col] = node;

    state = state.copyWith(
      nodes: newNodes,
      rightPointer: rightPointer ?? state.rightPointer,
      leftPointer: leftPointer ?? state.leftPointer
    );
  }

  /// chọn thuật toán được sử dụng
  void selectAlgorithm(TwoPointer selectedAlgorithm) {
    var rightPointer = state.rightPointer;
    var leftPointer = state.leftPointer;

    final maxColsInLastRow = state.nodes.last.length;

    // lấy vị trí theo mảng nên cần trừ 1
    if(selectedAlgorithm.left == TwoPointerStartPosition.start) {
      leftPointer = (row: 0, col: 0);
    } else {
      leftPointer = (row: _maxRows - 1, col: maxColsInLastRow - 1);
    }

    if(selectedAlgorithm.right == TwoPointerStartPosition.start) {
      rightPointer = (row: 0, col: 0);
    } else {
      rightPointer = (row: _maxRows - 1, col: maxColsInLastRow - 1);
    }

    state = state.copyWith(
      selectedAlgorithm: selectedAlgorithm,
      rightPointer: rightPointer,
      leftPointer: leftPointer
    );
  }

  void startAlgorithm() async {
    if(state.selectedAlgorithm == null) return;

    final result = state.selectedAlgorithm!.solve(
      nodes: state.nodes, 
      leftPointer: state.leftPointer, 
      rightPointer: state.rightPointer, 
      input: state.input
    );

    for(var e in result) {
      final right = e.rightPointer;
      final left = e.leftPointer;
      final node = e.node;

      _updateNode(
        node: node,
        leftPointer: left,
        rightPointer: right
      );

      await Future.delayed(Duration(milliseconds: AppDurations.miliseconds));
    }

    if(result.last.resultLength > 0) {
      _updateResultNodes(result.last.resultLength);
    }
  }


  /// Đánh dấu các node thuộc kết quả cuối cùng
  void _updateResultNodes(int resultLength) {
    final left = state.leftPointer;
    final totalResultRows = ((resultLength - (_maxCols - left.col)) / _maxCols).ceil();
    int row = left.row + 1;
    int count = 0;

    // xét dòng đầu tiên tính từ vị trí hiện tại của leftPointer
    for(var node in state.nodes[left.row]) {
      if(count == resultLength) return;

      if(node.col < left.col) continue;

      count++;

      _updateNode(node: node.copyWith(state: TwoPointerNodeState.result));
    }

    // xét các dòng còn lại: left.row + 1 => totalResultRows
    while (row <= totalResultRows) {
      for(var node in state.nodes[row]) {
        if(count == resultLength) return;
        count++;

        _updateNode(node: node.copyWith(state: TwoPointerNodeState.result));
      }

      row++;
    }
  }

  void reset() {
    final nodes = _genNodeByInput(state.input);
    
    state = state.copyWith(nodes: nodes, rightPointer: (col: 0, row: 0), leftPointer: (col: 0, row: 0));
  }

}