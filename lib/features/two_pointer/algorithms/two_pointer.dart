import 'package:algorithm_with_flutter_ui/features/two_pointer/models/two_pointer_model.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_state_type.dart';


abstract class TwoPointer {
  String get name;
  String get information;

  /// vị trí khởi tạo của `con trỏ bên phải` trong thuật toán
  int get right;

  /// vị trí khởi tạo của `con trỏ bên trái` trong thuật toán
  int get left;
  
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