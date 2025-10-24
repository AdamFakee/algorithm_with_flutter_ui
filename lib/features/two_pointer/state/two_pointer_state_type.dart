import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/two_pointer.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/models/two_pointer_model.dart';

typedef Pointer = ({int row, int col});

class TwoPointerStateType {
  List<List<TwoPointerNode>> nodes;
  String input; // chuỗi đầu vào cần xử lý

  // final int totalCols;

  /// số dòng mặc định, có thể thay đổi nếu `input.lenght > totalCols` 
  // int totalRows; 

  Pointer leftPointer;
  Pointer rightPointer;
  TwoPointer? selectedAlgorithm;

  TwoPointerStateType({
    required this.nodes,
    required this.input,
    // required this.totalCols,
    // this.totalRows = 1,
    this.leftPointer = (row: 0, col: 0),
    this.rightPointer = (row: 0, col: 0),
    this.selectedAlgorithm
  });

  TwoPointerStateType copyWith({
    List<List<TwoPointerNode>>? nodes,
    String? input,
    int? totalRows,
    // int? totalCols,
    Pointer? leftPointer,
    Pointer? rightPointer,
    TwoPointer? selectedAlgorithm
  }) {
    return TwoPointerStateType(
      nodes: nodes ?? this.nodes,
      input: input ?? this.input,
      // totalCols: totalCols ?? this.totalCols,
      // totalRows: totalRows ?? this.totalRows,
      leftPointer: leftPointer ?? this.leftPointer,
      rightPointer: rightPointer ?? this.rightPointer,
      selectedAlgorithm: selectedAlgorithm ?? this.selectedAlgorithm
    );
  }
}
