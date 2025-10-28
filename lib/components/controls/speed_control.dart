import 'package:algorithm_with_flutter_ui/features/common/state/speed_animation/speed_animation_provider.dart';
import 'package:algorithm_with_flutter_ui/features/common/state/speed_animation/speed_animation_state_type.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpeedControl extends ConsumerWidget {
  const SpeedControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSpeed = ref.watch(speedAnimationProvider).speed;
    final setSpeed = ref.read(speedAnimationProvider.notifier).setSpeed;

    return Column(
      children: [
        // --- speed control
        Row(
          children: [
            for (int i = 0; i < SpeedAnimation.values.length; i++) ...[
              GestureDetector(
                onTap: () => setSpeed(SpeedAnimation.values[i]),
                child: circleDot(
                  SpeedAnimation.values[i] == currentSpeed,
                ),
              ),
              if (i < SpeedAnimation.values.length - 1)
                Expanded(child: middleLine()),
            ],
          ],
        ),

        const SizedBox(height: 6),

        // --- speed title
        Row(
          children: [
            for (int i = 0; i < SpeedAnimation.values.length; i++) ...[
              Expanded(
                child: GestureDetector(
                  onTap: () => setSpeed(SpeedAnimation.values[i]),
                  child: Text(
                    SpeedAnimation.values[i].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: SpeedAnimation.values[i] == currentSpeed
                          ? FontWeight.bold
                          : FontWeight.w400,
                      color: SpeedAnimation.values[i] == currentSpeed
                          ? AppColors.primary
                          : Colors.grey[600],
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
              if (i < SpeedAnimation.values.length - 1)
                Expanded(child: const SizedBox()),
            ],
          ],
        ),
      ],
    );
  }

  Widget circleDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      width: isActive ? 14 : 10,
      height: isActive ? 14 : 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.primary : AppColors.white,
        border: Border.all(
          color: isActive
              ? AppColors.primary
              : AppColors.primary.withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
    );
  }

  Widget middleLine() {
    return Container(
      height: 2,
      color: AppColors.primary.withOpacity(0.3),
      margin: const EdgeInsets.symmetric(horizontal: 2),
    );
  }
}
