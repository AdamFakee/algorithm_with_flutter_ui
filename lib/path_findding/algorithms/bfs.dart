import 'dart:collection';

import 'package:algorithm_with_flutter_ui/utils/consts/direction.dart';
import 'package:algorithm_with_flutter_ui/path_findding/algorithms/path_findding.dart';
import 'package:algorithm_with_flutter_ui/path_findding/models/node_model.dart';

class BFS extends PathFindding {
  @override
  String get name => "Breadth-First Search";

  @override
  String get information => 
      "BFS là thuật toán tìm kiếm theo chiều rộng. "
      "Nó duyệt qua các node theo từng lớp (level) từ điểm bắt đầu, "
      "tìm đường đi ngắn nhất trong đồ thị không có trọng số.";
      
  @override
  Iterable<Node> findPath ({
    required List<List<Node>> nodes,
    required Node start,
    required Node finish
  }) sync* {
    final maxRows = nodes.length;
    final maxCols = nodes[0].length;

    final q = Queue<Node>();
    q.add(start);

    while(q.isNotEmpty) {
      final current = q.removeFirst();

      current.isVisitted = true;
      yield current;

      if(current.state == NodeState.finish) return;

      for(final (rowDir, colDir) in Direction.topRightBottomLeft) {
        final newRow = current.row + rowDir;
        final newCol = current.col + colDir;

        if(newRow < 0 || newRow >= maxRows || newCol < 0 || newCol >= maxCols) continue;

        var newNode = nodes[newRow][newCol];

        if(current.state == NodeState.finish) {
          newNode.previousNode = current;
          yield newNode;
          return;
        }

        if(newNode.isVisitted) continue;
        if(newNode.state == NodeState.wall || newNode.state == NodeState.start) continue;

        newNode = newNode.copyWith(
          distance: current.distance + 1,
          previousNode: current,
          isVisitted: true
        );
        nodes[newRow][newCol] = newNode;

        q.add(newNode);
      }
    }
    print('end');
  }
}
