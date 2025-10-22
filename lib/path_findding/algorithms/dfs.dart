import 'package:algorithm_with_flutter_ui/utils/consts/direction.dart';
import 'package:algorithm_with_flutter_ui/path_findding/algorithms/path_findding.dart';
import 'package:algorithm_with_flutter_ui/path_findding/models/node_model.dart';

/// tham chiếu như trong c++
class _Ref {
  final List<List<Node>> nodes;
  _Ref({required this.nodes});
}

class DFS extends PathFindding {
  @override
  String get name => 'Depth First Search';

  @override
  String get information =>
      'DFS (Depth-First Search) là thuật toán duyệt đồ thị theo chiều sâu, '
      'bắt đầu từ một node gốc và đi càng sâu càng tốt trước khi quay lui.';

  @override
  Iterable<Node> findPath({
    required List<List<Node>> nodes,
    required Node start,
    required Node finish,
  }) sync* {
    final ref = _Ref(nodes: nodes);
    final maxRows = nodes.length;
    final maxCols = nodes[0].length;

    yield* _dfs(
      ref: ref,
      start: start,
      maxRows: maxRows,
      maxCols: maxCols,
      finish: finish
    );
  }

  Iterable<Node> _dfs({
    required _Ref ref,
    required Node start,
    required Node finish,
    required int maxRows,
    required int maxCols,
  }) sync* {

    final nodes = ref.nodes;
    Node current = nodes[start.row][start.col];
    final finishNode = nodes[finish.row][finish.col];

    if(finishNode.isVisitted) {
      return;
    }

    // Đánh dấu là đã thăm
    current = current.copyWith(isVisitted: true);
    nodes[start.row][start.col] = current;

    if (current.state == NodeState.finish) {
      yield current;
      return;
    }

    yield current;

    for (var (rowDir, colDir) in Direction.topRightBottomLeft) {
      final newRow = current.row + rowDir;
      final newCol = current.col + colDir;

      if (newRow < 0 || newRow >= maxRows || newCol < 0 || newCol >= maxCols) continue;

      Node newNode = nodes[newRow][newCol];

      if (newNode.isVisitted) continue;
      if (newNode.state == NodeState.wall || newNode.state == NodeState.start) continue;

      // cập nhật khoảng cách và lưu tới node cha (parent node)
      newNode = newNode.copyWith(previousNode: current, distance: current.distance + 1);
      nodes[newRow][newCol] = newNode;

      if (newNode.state == NodeState.finish) {
        // đánh dấu là đã duyệt qua và dừng luôn
        newNode = newNode.copyWith(
          isVisitted:  true, 
        );
        nodes[newRow][newCol] = newNode;

        yield newNode;
        return;
      }

      yield* _dfs(ref: ref, start: newNode, maxRows: maxRows, maxCols: maxCols, finish: finish);
    }
  }
}
