import 'package:algorithm_with_flutter_ui/features/common/state/language_code/language_code_state_type.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/models/two_pointer_model.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_state_type.dart';

/// Xác định vị trí của con trỏ khi khởi tạo thuật toán
enum TwoPointerStartPosition {
  start, // con trỏ nằm ở vị trí đầu tiên  
  end // con trỏ nằm ở vị trí cuối cùng
}

abstract class TwoPointer {
  String get name;
  String get information;

  /// đề bài
  String get problem;

  /// đoạn code xử lý đề bài
  String code(LanguageCode language);

  /// vị trí khởi tạo của `con trỏ bên phải` trong thuật toán
  TwoPointerStartPosition get right;

  /// vị trí khởi tạo của `con trỏ bên trái` trong thuật toán
  TwoPointerStartPosition get left;
  
  Iterable<({
    TwoPointerNode node, 
    Pointer rightPointer, 
    Pointer leftPointer, 
    int resultLength})
  > solve({
    required List<List<TwoPointerNode>> nodes, 
    required Pointer leftPointer, 
    required Pointer rightPointer,
    required String input
  });
}