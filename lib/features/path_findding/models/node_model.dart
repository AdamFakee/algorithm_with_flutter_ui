// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:flutter/material.dart';

// trọng số mặc định của node
const _defaultWeight = 1;

enum NodeState {
  none(Colors.white, _defaultWeight),
  start(AppColors.green, _defaultWeight),
  finish(Colors.red, _defaultWeight),
  wall(Colors.black, _defaultWeight),
  increasedWeight(Colors.pink, _defaultWeight + 5); // mô tả node có weight lớn hơn các node khác 5 đơn vị.

  const NodeState(this.color, this.weight);

  final int weight;
  final Color color;
}

class Node {
  final int row;
  final int col;
  NodeState state;
  bool isVisitted;
  bool isShowDistance;
  int distance;
  Node? previousNode;
  int weight; // trọng số của node

  Node({
    required this.row,
    required this.col,
    this.state = NodeState.none,
    this.isVisitted = false,
    this.distance = 0,
    this.previousNode,
    this.isShowDistance = false,
    this.weight = _defaultWeight
  });

  Node copyWith({
    int? row,
    int? col,
    bool? isVisitted,
    int? distance,
    NodeState? state,
    Node? previousNode,
    bool? isShowDistance,
    int? weight
  }) {
    return Node(
      row: row ?? this.row,
      col: col ?? this.col,
      isVisitted: isVisitted ?? this.isVisitted,
      distance: distance ?? this.distance,
      state: state ?? this.state,
      previousNode: previousNode ?? this.previousNode,
      isShowDistance: isShowDistance ?? this.isShowDistance,
      weight: weight ?? this.weight
    );
  }
}
