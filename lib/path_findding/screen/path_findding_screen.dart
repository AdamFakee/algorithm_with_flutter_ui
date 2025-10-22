import 'package:algorithm_with_flutter_ui/utils/consts/sizes.dart';
import 'package:algorithm_with_flutter_ui/path_findding/screen/widgets/control_board.dart';
import 'package:algorithm_with_flutter_ui/path_findding/screen/widgets/information_board.dart';
import 'package:algorithm_with_flutter_ui/path_findding/screen/widgets/node_board.dart';
import 'package:flutter/material.dart';

class PathFinddingScreen extends StatelessWidget {
  const PathFinddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Path Findding",
          style: TextStyle(
            fontWeight: FontWeight.w500, 
            fontSize: 30
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.padding
        ),
        child: Column(
          spacing: 20,
          children: [
            NodeBoard(),
            InformationBoard(),
            ControlBoard()
          ],
        )
      ),
    );
  }
}
