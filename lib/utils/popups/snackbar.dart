import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/sizes.dart';
import 'package:flutter/material.dart';

enum SnackbarEnum { success, warning, error }

/// class display [SnackbarEnum] popup
/// 
/// [type] determine type of popup 
/// 
/// [second] : time display popup
class Snackbar {
  static show(BuildContext context, {
    required SnackbarEnum type,
    required String message,
    int seconds = 3
  }) {
    final IconData icon;
    final IconData trailing;
    final Color bgColor;

    // set value for type's variables
    switch (type) {
      case SnackbarEnum.success:
        icon = Icons.check_circle;
        bgColor = AppColors.success;
        trailing = Icons.close;
        break;
      case SnackbarEnum.warning:
        icon = Icons.warning;
        bgColor = AppColors.warning;
        trailing = Icons.close;
        break;
      case SnackbarEnum.error:
        icon = Icons.error;
        bgColor = AppColors.error;
        trailing = Icons.close;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ListTile(
          leading: Icon(icon, color: AppColors.white,),
          title: Text(message.length > 250 ? message.substring(0, 250) : message, style: TextStyle(
            color: AppColors.white
          ),),
          trailing: Icon(trailing, color: AppColors.white,),
        ),
        backgroundColor: bgColor,
        margin: EdgeInsets.all(Sizes.md),
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.xs,
          vertical: Sizes.xs * 1.3
        ),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.md)
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: seconds),
      )
    );
  }
}