import 'package:flutter/material.dart';

/// helper hỗ trợ các tác vụ liên quan đến thiết bị
class Device {
  static closeKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}