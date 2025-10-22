import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:flutter/material.dart';

class IconOutlineButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const IconOutlineButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: AppColors.primary,
          width: 1.4
        )
      ),
      onPressed: onPressed, 
      icon: Icon(icon, color: AppColors.primary,)
    );
  }
}