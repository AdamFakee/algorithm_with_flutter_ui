import 'package:algorithm_with_flutter_ui/features/common/state/speed_animation/speed_animation_state.dart';
import 'package:algorithm_with_flutter_ui/features/common/state/speed_animation/speed_animation_state_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final speedAnimationProvider =
    NotifierProvider<SpeedAnimationState, SpeedAnimationStateType>(() {
  return SpeedAnimationState();
});

