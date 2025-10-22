import 'package:algorithm_with_flutter_ui/path_findding/state/path_findding_state.dart';
import 'package:algorithm_with_flutter_ui/path_findding/state/path_findding_state_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pathFinddingProvider =
    NotifierProvider<PathFinddingState, PathFinddingStateType>(() {
  return PathFinddingState();
});
