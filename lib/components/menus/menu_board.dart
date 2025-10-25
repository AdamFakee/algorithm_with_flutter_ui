import 'package:flutter/material.dart';

class MenuBoard extends StatefulWidget {
  final String title;
  final Widget child;

  const MenuBoard({super.key, required this.title, required this.child});

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
            Text(widget.title, style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),),
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