import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/models/node_model.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/state/path_findding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NodeWidget extends ConsumerStatefulWidget {
  const NodeWidget({super.key, required this.row, required this.col});

  final int row;
  final int col;

  @override
  ConsumerState<NodeWidget> createState() => _NodeWidgetState();
}

class _NodeWidgetState extends ConsumerState<NodeWidget> with SingleTickerProviderStateMixin {

  late final AnimationController controller;
  late final Animation<Color?> animation;

  @override
  void initState() {
    super.initState();
    
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animation = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(
          begin: AppColors.yellow,
          end: AppColors.green,
        ),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ColorTween(
          begin: AppColors.green,
          end: AppColors.primary,
        ),
        weight: 50,
      ),
    ]).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = ref.watch(pathFinddingProvider.select((state) => state.nodes[widget.row][widget.col]));

    final onLongPressToNode = ref.read(pathFinddingProvider.notifier).onLongPressToNode;
    
    return Expanded(
      child: GestureDetector(
        onLongPress: () => onLongPressToNode(node.row, node.col),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
            ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
              reverseDuration: Duration(milliseconds: 0),
              switchInCurve: Curves.elasticOut,
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: buildIndicator(node)
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(Node node) {
    if(node.state == NodeState.wall) {
      return Container(
        color: node.state.color,
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
      );
    }


    if(node.state == NodeState.start || node.state == NodeState.finish) {
      return SizedBox(
        child: Icon(
          node.state == NodeState.start ? Icons.flag : Icons.location_on, 
          color: node.state.color, 
          size: 16,
        ),
      );
    }

    if(node.isVisitted == true || node.state == NodeState.increasedWeight) {
      controller..reset()..forward();

      return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            color: node.state == NodeState.increasedWeight ? node.state.color : node.isShowDistance ? AppColors.yellow : animation.value,
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            child: node.isShowDistance ? Text(
              node.distance.toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ) : null,
          );
        },
      );
    }
    
    return const SizedBox();
  }
}