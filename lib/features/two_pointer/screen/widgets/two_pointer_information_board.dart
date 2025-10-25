import 'package:algorithm_with_flutter_ui/components/menus/menu_board.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/models/two_pointer_model.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:flutter/material.dart';

class TwoPointerInformationBoard extends StatelessWidget {
  const TwoPointerInformationBoard({super.key});

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
                    color: TwoPointerNodeState.none.color
                  ),
                ),
                title: 'Default Node'
              ),
              _note(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5
                    ),
                    color: TwoPointerNodeState.processing.color
                  ),
                ),
                title: 'Processing Node'
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
                    color: TwoPointerNodeState.discarded.color
                  ),
                ),
                title: 'Discard Node'
              ),
              _note(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5
                    ),
                    color: TwoPointerNodeState.result.color
                  ),
                ),
                title: 'Result Node'
              ),
            ],
          ),
          Row(
            children: [
              _note(
                child: Icon(Icons.arrow_upward, color: AppColors.left, size: 20,),
                title: 'Left Arrow'
              ),
              _note(
                child: Icon(Icons.arrow_downward, color: AppColors.right, size: 20,),
                title: 'Right Arrow'
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