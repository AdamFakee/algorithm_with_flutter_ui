import 'package:algorithm_with_flutter_ui/utils/consts/direction.dart';
import 'package:algorithm_with_flutter_ui/path_findding/algorithms/path_findding.dart';
import 'package:algorithm_with_flutter_ui/path_findding/models/node_model.dart';
import 'package:collection/collection.dart';

class Dijkstra extends PathFindding{
  @override
  String get name => 'Dijkstra';

  @override
  String get information => 
      'Thuật toán Dijkstra là một thuật toán tìm đường đi ngắn nhất '
      'từ một điểm bắt đầu đến tất cả các điểm khác trong đồ thị có trọng số không âm.\n\n'
      'Nó sử dụng hàng đợi ưu tiên (Priority Queue) để luôn chọn đỉnh có '
      'khoảng cách tạm thời nhỏ nhất và cập nhật lại các khoảng cách của các đỉnh kề.\n\n'
      'Độ phức tạp trung bình: O((V + E) * log V)';

  @override
  Iterable<Node> findPath({required List<List<Node>> nodes, required Node start, required Node finish}) sync* {
    final maxRows = nodes.length;
    final maxCols = nodes[0].length;

    final q = PriorityQueue<(int, Node)>((a, b) {
      return a.$1.compareTo(b.$1);
    });

    // ma trận 2 chiều lưu khoảng cách từ start -> (row, col)
    final distances = _genDistanceMatrix(maxRows, maxCols);

    // điểm bắt đầu đi
    q.add((start.distance, start));
    nodes[start.row][start.col] = start.copyWith(isVisitted: true);
    distances[start.row][start.col] = 0;

    // xét các điểm khác
    while(q.isNotEmpty) {
      final e = q.removeFirst();
      final distance = e.$1;
      Node current = e.$2;

      if(distance > distances[current.row][current.col]) continue;

      current = current.copyWith(isVisitted: true);
      yield current;
      nodes[current.row][current.col] = current;

      if(nodes[finish.row][finish.col].isVisitted) return;


      for (var (rowDir, colDir) in Direction.topRightBottomLeft) {
        final newRow = current.row + rowDir;
        final newCol = current.col + colDir;

        if (newRow < 0 || newRow >= maxRows || newCol < 0 || newCol >= maxCols) continue;

        Node newNode = nodes[newRow][newCol];

        if (newNode.state == NodeState.wall || newNode.state == NodeState.start) continue;

        final weight = newNode.weight;

        if(distances[newRow][newCol] > weight + distances[current.row][current.col]) {
          final newDistance = weight + distances[current.row][current.col];
          distances[newRow][newCol] = newDistance;

          newNode = newNode.copyWith(
            previousNode: current,
            distance: newDistance
          );
          q.add((distances[newRow][newCol], newNode));

        }
      }
    }
  }

  List<List<int>> _genDistanceMatrix(int row, int col) {
    print(2^10);
    return List.generate(row, (_) {
      return List.generate(col, (_) {
        return 9999;
      });
    });
  }

}