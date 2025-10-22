import 'package:flutter/material.dart';

class SelectOptions extends StatelessWidget {
  final String title;
  final Widget child;

  const SelectOptions({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () => showModal(context),
      readOnly: true,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1.2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.8),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.white, // nền của textfield
      ),
    );
  }

  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
            ),
            child: child
          ),
        );
      },
    );
  }

}