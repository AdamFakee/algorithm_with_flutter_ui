import 'package:algorithm_with_flutter_ui/features/path_findding/models/node_model.dart';

abstract class PathFindding {
  String get name;
  String get information;
  Iterable<Node> findPath({
    required List<List<Node>> nodes,
    required Node start,
    required Node finish
  });
}