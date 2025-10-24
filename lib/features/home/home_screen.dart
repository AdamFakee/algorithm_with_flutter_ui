import 'package:algorithm_with_flutter_ui/components/modal_bottom_sheets/model_bottom_sheet_barrier.dart';
import 'package:algorithm_with_flutter_ui/utils/routers/app_router_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModelBottomSheetBarrier().show(
        context: context, 
        child: bottomSheetChild(),
        snapSizes: [0.6, 0.8, 1],
        initialChildSize: 0.6,
        backgroundColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 20
          ),
          child: Column(
            spacing: 10,
            children: [
              const Text(
                'Các thuật toán',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              card(
                title: 'PathFindding',
                onNavigation: () => context.push(AppRouterNames.pathFindding)
              ),
              card(
                title: 'TwoPointer',
                onNavigation: () => context.push(AppRouterNames.twoPointer)
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget card({
    required String title,
    required VoidCallback onNavigation
  }) {
    return GestureDetector(
      onTap: onNavigation,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueAccent.shade200
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black
          ),
        ),
      ),
    );
  }

  Widget bottomSheetChild () {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📚 Giới thiệu',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Ứng dụng giúp trực quan hóa các thuật toán thông qua hình ảnh và chuyển động. '
            'Mục tiêu là mang lại trải nghiệm học thuật toán sinh động, dễ hiểu và gần gũi ',
            style: TextStyle(
              fontSize: 15,
              height: 1.4,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '⚙️ Tính năng chính',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '• Hỗ trợ nhiều nhóm thuật toán khác nhau: tìm đường đi, sắp xếp, tìm kiếm, v.v.\n'
            '• Trực quan hóa quá trình hoạt động qua ma trận, đồ thị hoặc các animations.\n'
            '• Giao diện thân thiện, dễ thao tác và tùy chỉnh.\n'
            '• Giúp người học quan sát, so sánh và hiểu rõ cách thuật toán vận hành.',
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Bắt đầu khám phá'),
            ),
          ),
        ],
      ),
    );
  }

}