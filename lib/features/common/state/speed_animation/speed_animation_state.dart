import 'package:algorithm_with_flutter_ui/features/common/state/speed_animation/speed_animation_state_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpeedAnimationState extends Notifier<SpeedAnimationStateType> {
  @override
  SpeedAnimationStateType build() {
    return SpeedAnimationStateType(speed: SpeedAnimation.one);
  }

  void setSpeed(SpeedAnimation speed) {
    if(state.speed.name == speed.name) return;

    state = state.copyWith(speed: speed);
  }

}