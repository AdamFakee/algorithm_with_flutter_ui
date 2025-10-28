import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:flutter/material.dart';

class MenuBoard extends StatefulWidget {
  final String title;
  final Widget child;

  /// click vào icon.question_mark để hiển thị UI cho mục đích mô tả kỹ hơn
  final VoidCallback? onPress;

  const MenuBoard({super.key, required this.title, required this.child, this.onPress});

  @override
  State<MenuBoard> createState() => _MenuBoardState();
}

class _MenuBoardState extends State<MenuBoard> with SingleTickerProviderStateMixin {
  final duration = Duration(milliseconds: 400);
  bool isOpenMenu = false;
  late final AnimationController controller;
  late final Animation<double> animation;

  void _openMenu() {
    setState(() {
      isOpenMenu = !isOpenMenu;
      if(isOpenMenu) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);

    // mặc định: menu đóng khi vào lần đầu tiên
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        // title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(widget.title, style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),),
                IconButton(
                  onPressed: widget.onPress,
                  icon: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(
                        color: AppColors.black,
                        width: 1.2
                      )
                    ),
                    child: Icon(Icons.question_mark, size: 10, color: AppColors.black,),
                  ), 
                )
              ],
            ),
            GestureDetector(
              onTap: () => _openMenu(),
              child: AnimatedRotation(
                turns: isOpenMenu ? 0.5 : 1,
                duration: duration,
                child: Icon(Icons.arrow_drop_down_rounded, size: 30,)
              ),
            )
          ],
        ),

        // information
        AnimatedBuilder(
          animation: controller, 
          builder:(context, child) {
            return SizeTransition(
              sizeFactor: animation,
              axisAlignment: -1,
              child: child,
            );
          },
          child: widget.child,
        )
        
      ],
    );
  }
}