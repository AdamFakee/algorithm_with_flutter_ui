import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:algorithm_with_flutter_ui/path_findding/models/node_model.dart';
import 'package:algorithm_with_flutter_ui/components/menus/menu_board.dart';
import 'package:flutter/material.dart';

class InformationBoard extends StatelessWidget {
  const InformationBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuBoard(
      title: "Information", 
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              _note(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5
                    ),
                    color: NodeState.none.color
                  ),
                ),
                title: 'Empty Node'
              ),
              _note(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5
                    ),
                    color: AppColors.primary
                  ),
                ),
                title: 'Visitted Node'
              ),
            ],
          ),
          Row(
            children: [
              _note(
                child: Icon(Icons.flag, color: NodeState.start.color, size: 20,),
                title: 'Start Node'
              ),
              _note(
                child: Icon(Icons.location_on, color: NodeState.finish.color, size: 20,),
                title: 'Finish Node'
              ),
            ],
          ),
          Row(
            children: [
              _note(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5
                    ),
                    color: NodeState.wall.color
                  ),
                ),
                title: 'Wall Node'
              ),
              _note(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5
                    ),
                    color: NodeState.increasedWeight.color
                  ),
                ),
                title: 'Expensive Node'
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _note({
    required Widget child,
    required String title
  }) {
    return Expanded(
      child: Row(
        spacing: 20,
        children: [
          child,
          Text(title)
        ],
      ),
    );
  }
}