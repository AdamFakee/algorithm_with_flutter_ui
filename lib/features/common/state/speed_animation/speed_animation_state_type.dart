// ignore_for_file: public_member_api_docs, sort_constructors_first
enum SpeedAnimation {
  half(0.5, '0.5x'),
  one(1.0, '1x'),
  oneHalf(1.5, '1.5x'),
  two(2.0, '2x'),
  twoHalf(2.5, '2.5x'),
  three(3.0, '3x');

  final double value;
  final String title;

  const SpeedAnimation(this.value, this.title);
}

class SpeedAnimationStateType {
  final SpeedAnimation speed;

  SpeedAnimationStateType({
    required this.speed,
  });

  SpeedAnimationStateType copyWith({
    SpeedAnimation? speed,
  }) {
    return SpeedAnimationStateType(
      speed: speed ?? this.speed,
    );
  }
}
