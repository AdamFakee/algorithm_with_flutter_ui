import 'package:algorithm_with_flutter_ui/path_findding/algorithms/path_findding.dart';
import 'package:algorithm_with_flutter_ui/path_findding/models/node_model.dart';

class PathFinddingStateType {
  List<List<Node>> nodes;
  PathFindding? selectedAlgorithmOpt;
  bool isShowDistance;

  PathFinddingStateType({
    required this.nodes,
    this.selectedAlgorithmOpt,
    this.isShowDistance = false,
  });

  PathFinddingStateType copyWith({
    List<List<Node>>? nodes,
    PathFindding? selectedAlgorithmOpt,
    bool? isShowDistance
  }) {
    return PathFinddingStateType(
      nodes: nodes ?? this.nodes,
      selectedAlgorithmOpt: selectedAlgorithmOpt ?? this.selectedAlgorithmOpt,
      isShowDistance: isShowDistance ?? this.isShowDistance
    );
  }
}
