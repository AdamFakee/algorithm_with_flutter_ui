// import 'package:flutter/material.dart';

// class MenuBoard extends StatefulWidget {
//   final String title;
//   final Widget child;

//   const MenuBoard({super.key, required this.title, required this.child});

//   @override
//   State<MenuBoard> createState() => _MenuBoardState();
// }

// class _MenuBoardState extends State<MenuBoard> {
//   bool isOpenMenu = false;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       spacing: isOpenMenu ? 10 : 0,
//       children: [
//         // title
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(widget.title, style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//             ),),
//             GestureDetector(
//               onTap: () => setState(() {
//                 isOpenMenu = !isOpenMenu;
//               }),
//               child: AnimatedRotation(
//                 turns: isOpenMenu ? 0.5 : 1,
//                 duration: Duration(milliseconds: 500),
//                 child: Icon(Icons.arrow_drop_down_rounded, size: 30,)
//               ),
//             )
//           ],
//         ),

//         // information
//         AnimatedSize(
//           duration: const Duration(milliseconds: 500),
//           reverseDuration: const Duration(seconds: 1),
//           child: isOpenMenu ? widget.child : const SizedBox()
//         )
        
//       ],
//     );
//   }
// }

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

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);

    animation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: isOpenMenu ? 10 : 0,
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
              onTap: () => setState(() {
                isOpenMenu = !isOpenMenu;
              }),
              child: AnimatedRotation(
                turns: isOpenMenu ? 0.5 : 1,
                duration: duration,
                child: Icon(Icons.arrow_drop_down_rounded, size: 30,)
              ),
            )
          ],
        ),

        // information
        AnimatedSize(
          alignment: Alignment.topCenter,
          duration: duration,
          reverseDuration: duration,
          child: isOpenMenu ? widget.child : _closeMenu(widget.child)
        )
        
      ],
    );
  }

  Widget _closeMenu(Widget child) {
    controller..reset()..forward();

    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: -1,
      sizeFactor: animation,
      child: child,
    );
  }
}