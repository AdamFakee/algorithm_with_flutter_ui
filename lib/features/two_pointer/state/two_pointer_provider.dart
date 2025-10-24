import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_state.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_state_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final twoPointerProvider =
    NotifierProvider<TwoPointerState, TwoPointerStateType>(() {
  return TwoPointerState();
});
