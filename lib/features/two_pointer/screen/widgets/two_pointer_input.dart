import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_provider.dart';
import 'package:algorithm_with_flutter_ui/utils/device/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TwoPointerInput extends ConsumerStatefulWidget {

  const TwoPointerInput({super.key});

  @override
  ConsumerState<TwoPointerInput> createState() => _TwoPointerInputState();
}

class _TwoPointerInputState extends ConsumerState<TwoPointerInput> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    final currentInput = ref.read(twoPointerProvider).input;
    controller = TextEditingController(text: currentInput);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final setInput = ref.read(twoPointerProvider.notifier).setInput;

    final bool disableButton = controller.text.trim().isEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Input for algorithms",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Nhập chuỗi (ví dụ: ABCD...)",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              disabledBackgroundColor: Colors.grey.shade400,
              disabledForegroundColor: Colors.white70,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            onPressed: disableButton ? null : () {
              setInput(controller.text.trim());
              Device.closeKeyBoard();
            },
            child: const Text(
              'Xác nhận',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}