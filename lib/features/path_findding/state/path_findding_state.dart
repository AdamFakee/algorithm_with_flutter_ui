import 'package:algorithm_with_flutter_ui/features/common/state/speed_animation/speed_animation_provider.dart';
import 'package:algorithm_with_flutter_ui/features/common/state/speed_animation/speed_animation_state_type.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/algorithms/bfs.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/algorithms/dfs.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/algorithms/dijkstra.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/algorithms/path_findding.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/models/node_model.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/state/path_findding_state_type.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/durations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PathFinddingState extends Notifier<PathFinddingStateType>{
  @override
  PathFinddingStateType build() {
    final nodes = _genInitNodes();
    return PathFinddingStateType(nodes: nodes);
  }

  final totalRow = 18;
  final totalCol = 18;

  int startRow = 6;
  int startCol = 6;

  int finishRow = 10;
  int finishCol = 10;

  bool isMovingStartNode = false;
  bool isMovingFinishNode = false;
  
  // onDragStart bắt đầu đi từ state = wall hay không. 
  // Nghĩa là:
  // Nếu bắt đầu từ "none" => "false" => hành động đó là "add wall". 
  // Còn nếu bắt đầu từ "wall" => "true" => hành động đó là "remove wall".
  bool isMovingWallNode = false;

  Node? finishNode;

  /// có đang chạy thuật toán hay không
  bool isDoingAlgorithm = false;

  // algorithms
  List<PathFindding> algorithmOpts = [
    BFS(), DFS(), Dijkstra()
  ];

  bool _isStartNode(int row, int col) => row == startRow && col == startCol;
  bool _isFinishNode(int row, int col) => row == finishRow && col == finishCol;

  // tạo nodes mặc định
  List<List<Node>> _genInitNodes() {
    return List.generate(totalRow, (row) {
      return List.generate(totalCol, (col) {
          late final NodeState state;
          if(_isStartNode(row, col)) {
            state = NodeState.start;
          } else if(_isFinishNode(row, col)) {
            state = NodeState.finish;
          } else {
            state = NodeState.none;
          }

          return Node(col: col, row: row, state: state);
        }
      );
      }
    );
  }

  void onDragStart(int row, int col) {
    // đang chạy thuật toán => k cho làm gì cả
    if(isDoingAlgorithm) return;

    final node = state.nodes[row][col];

    if(node.isVisitted) return;

    isMovingStartNode = node.state == NodeState.start;
    isMovingFinishNode = node.state == NodeState.finish;
    isMovingWallNode = node.state == NodeState.wall;

    if(isMovingStartNode || isMovingFinishNode || isMovingWallNode) return;

    if(node.state == NodeState.none) {
      _updateNodeState(row, col, NodeState.wall);
      return;
    }
  }

  void onDragUpdate(int row, int col) {
    // đang chạy thuật toán => k cho làm gì cả
    if(isDoingAlgorithm) return;

    final node = state.nodes[row][col];

    if(node.isVisitted) return;

    if(isMovingStartNode) {
      _onStartNodeMoved(row, col);
      return;
    }

    if(isMovingFinishNode) {
      _onFinishNodeMoved(row, col);
      return;
    }

    if(isMovingWallNode) {
      _onRemoveWall(row, col);
      return;
    }

    if(node.state == NodeState.none) {
      _updateNodeState(row, col, NodeState.wall);
      return;
    }
  }

  void onDragEnd(int row, int col) {
    // đang chạy thuật toán => k cho làm gì cả
    if(isDoingAlgorithm) return;

    final node = state.nodes[row][col];

    if(node.isVisitted) return;

    if(isMovingStartNode) {
      _onStartNodeMoved(row, col);
      isMovingStartNode = false;
      return;
    }

    if(isMovingFinishNode) {
      _onFinishNodeMoved(row, col);
      isMovingFinishNode = false;
      return;
    }

    if(isMovingWallNode) {
      _onRemoveWall(row, col);
      isMovingWallNode = false;
      return;
    }

    if(node.state == NodeState.none) {
      _updateNodeState(row, col, NodeState.wall);
      return;
    }
  }

  void _onStartNodeMoved(int row, int col) {
    final node = state.nodes[row][col];

    if(node.state == NodeState.wall || node.state == NodeState.finish) return;

    // reset old node
    _updateNodeState(startRow, startCol, NodeState.none);

    // set new node
    _updateNodeState(row, col, NodeState.start);

    // update new row & col
    startRow = row;
    startCol = col;
  }

  void _onFinishNodeMoved(int row, int col) {
    final node = state.nodes[row][col];

    if(node.state == NodeState.wall || node.state == NodeState.start) return;

    // update old node
    _updateNodeState(finishRow, finishCol, NodeState.none);

    // set new node
    _updateNodeState(row, col, NodeState.finish);

    // update new row & col
    finishRow = row;
    finishCol = col;
  }

  void _onRemoveWall(int row, int col) {
    final node = state.nodes[row][col];

    if(node.state == NodeState.wall) {
      _updateNodeState(row, col, NodeState.none);
      return;
    }
  }

  void _updateNodeState(int row, int col, NodeState nodeState, [bool isVisitted = false]) {
    final newNodes = state.nodes;
    final node = newNodes[row][col];
    // print(isVisitted);

    newNodes[row][col] = node.copyWith(state: nodeState, isVisitted: isVisitted);

    state = state.copyWith(nodes: newNodes);
  }

  void _updateNode(Node node) {
    final newNodes = state.nodes;

    newNodes[node.row][node.col] = node;

    state = state.copyWith(nodes: newNodes);
  }

  void selectAlgorithmOpt(PathFindding algorithm) {
    // đang chạy thuật toán => k cho làm gì cả
    if(isDoingAlgorithm) return;

    state = state.copyWith(selectedAlgorithmOpt: algorithm);
  }

  void startAlgorithm() async {
    if(state.selectedAlgorithmOpt == null) return;

    // đang chạy thuật toán => k cho làm gì cả
    if(isDoingAlgorithm) return;

    // đánh dấu đang chạy thuật toán
    isDoingAlgorithm = true;

    final visittedNodes = state.selectedAlgorithmOpt!.findPath(
      nodes: state.nodes, 
      start: state.nodes[startRow][startCol], 
      finish: state.nodes[finishRow][finishCol]
    );    
    
    // tốc độ chạy
    final SpeedAnimation speed = ref.read(speedAnimationProvider).speed;

    for(Node node in visittedNodes) {
      if(node.state == NodeState.finish) {
        finishNode = node;
      }

      _updateNode(node);
      await Future.delayed(Duration(milliseconds: (AppDurations.milisecondsSlower / speed.value).toInt()));
    }

    // hiện thị đường đi từ start -> finish
    if(finishNode != null) {
      _getPathStartToFinish(finishNode!);
    }

    // đánh dấu đã chạy xong thuật toán
    isDoingAlgorithm = false;
  }

  void _getPathStartToFinish(Node node) async {
    if(node.previousNode != null) {
      _updateNode(node.copyWith(isShowDistance: true));

      await Future.delayed(Duration(milliseconds: 30));
      _getPathStartToFinish(node.previousNode!);
    }
  }

  void resetVisittedNode() {
    // đang chạy thuật toán => k cho làm gì cả
    if(isDoingAlgorithm) return;

    for (var row in state.nodes) {
      for(var node in row) {
        if(node.isVisitted) {
          _updateNode(
            node.copyWith(
              isShowDistance: false,
              distance: 0,
              previousNode: null,
              isVisitted: false
            )
          );
        }
      }
    }
  }

  /// reset nodes to `defautl`
  void reset() {
    // đang chạy thuật toán => k cho làm gì cả
    if(isDoingAlgorithm) return;

    state = state.copyWith(
      nodes: _genInitNodes()
    );
  }
  
  void _setShowDistance(Node node) {
    if(node.previousNode == null) return;

    _updateNode(node.copyWith(isShowDistance: state.isShowDistance));

    _setShowDistance(node.previousNode!);
  }

  /// hiển thị chi phí di chuyển từ `start` -> `current node`
  void toggleShowDistance () {
    // đang chạy thuật toán => k cho làm gì cả
    if(isDoingAlgorithm) return;

    if(finishNode == null) return;

    state = state.copyWith(isShowDistance: !state.isShowDistance);

    _setShowDistance(finishNode!);
  }

  /// thay đổi `trọng số` - `weight` cho `node`
  void onLongPressToNode(int row, int col) {
    // đang chạy thuật toán => k cho làm gì cả
    if(isDoingAlgorithm) return;
    
    final node = state.nodes[row][col];

    // check visitted
    if(node.isVisitted) return;

    // check start & finish
    if(node.state == NodeState.finish || node.state == NodeState.start) return;

    final isIncreaState = node.state == NodeState.increasedWeight;

    _updateNode(node.copyWith(
      state: isIncreaState ? NodeState.none : NodeState.increasedWeight,
      weight: isIncreaState ? NodeState.none.weight : NodeState.increasedWeight.weight
    ));
  }
}
