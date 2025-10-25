import 'package:algorithm_with_flutter_ui/features/common/state/language_code/language_code_provider.dart';
import 'package:algorithm_with_flutter_ui/features/common/state/language_code/language_code_state_type.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageCodeSelector extends ConsumerStatefulWidget{
  const LanguageCodeSelector({super.key});

  @override
  ConsumerState<LanguageCodeSelector> createState() => _LanguageCodeSelectorState();
}

class _LanguageCodeSelectorState extends ConsumerState<LanguageCodeSelector> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // size của selector
  late final Animation<double> _animation;

  // quay mũi tên của selector
  late final Animation<double> _iconAnimation;

  bool _isSelectorOpen = false;

  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _iconAnimation = Tween<double>(begin: 0, end: 0.5).animate(_animation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Hàm để bật/tắt selector
  void _toggleSelector() {
    setState(() {
      _isSelectorOpen = !_isSelectorOpen;
      if (_isSelectorOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  // Hàm để chọn một ngôn ngữ
  void _onLanguageSelected(LanguageCode language) {
    final setLanguageCode = ref.read(languageCodeProvider.notifier).setLanguageCode;
    setLanguageCode(language);
    // Sau khi chọn, tự động đóng selector
    _toggleSelector();
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = ref.watch(languageCodeProvider).language;

    return Column(
      // Canh lề các phần tử con sang bên trái
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- BUTTON CHÍNH ĐỂ MỞ/ĐÓNG SELECTOR ---
        GestureDetector(
          onTap: _toggleSelector,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.blackBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Giúp Row co lại vừa với nội dung
              children: [
                Text(
                  languageCode.name,
                  style: const TextStyle(color: AppColors.secondaryText, fontSize: 16),
                ),
                const SizedBox(width: 8),
                RotationTransition(
                  turns: _iconAnimation,
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.secondaryText,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),

        // --- DANH SÁCH NGÔN NGỮ (SELECTOR) ---
        // Sử dụng các Widget Transition để tạo hiệu ứng animation
        FadeTransition(
          opacity: _animation,
          child: SizeTransition(
            sizeFactor: _animation,
            // Axis alignment để hiệu ứng trượt xuống từ trên
            axisAlignment: -1.0, 
            child: Container(
              width: 150, // Giới hạn chiều rộng của selector
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.blackBlue),
              ),
              // Dùng clipRRect để các widget con bên trong không bị tràn ra ngoài khi bo góc
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  // Dùng map để tạo danh sách các widget chọn ngôn ngữ
                  children: LanguageCode.values.map((language) {
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _onLanguageSelected(language),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          // Đổi màu nền cho item đang được chọn
                          color: languageCode == language ? AppColors.blackBlue : Colors.transparent,
                          child: Text(
                            language.name,
                            style: const TextStyle(color: AppColors.secondaryText, fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
