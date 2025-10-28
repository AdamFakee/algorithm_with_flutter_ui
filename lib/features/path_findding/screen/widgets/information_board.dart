import 'package:algorithm_with_flutter_ui/components/modal_bottom_sheets/model_bottom_sheet_barrier.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/models/node_model.dart';
import 'package:algorithm_with_flutter_ui/components/menus/menu_board.dart';
import 'package:flutter/material.dart';

class InformationBoard extends StatefulWidget {
  const InformationBoard({super.key});

  @override
  State<InformationBoard> createState() => _InformationBoardState();
}

class _InformationBoardState extends State<InformationBoard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModelBottomSheetBarrier().show(
          context: context, 
          child: buildNotesBottomSheetContent(),
          snapSizes: [0.6, 0.8, 1],
          initialChildSize: 0.6,
          backgroundColor: Colors.white,
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MenuBoard(
      title: "Information", 
      onPress: () {
        ModelBottomSheetBarrier().show(
          context: context, 
          child: buildNotesBottomSheetContent(),
          snapSizes: [0.6, 0.8, 1],
          initialChildSize: 0.6,
          backgroundColor: Colors.white,
        );
      },
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              _note(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5
                    ),
                    color: NodeState.none.color
                  ),
                ),
                title: 'Empty Node'
              ),
              _note(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5
                    ),
                    color: AppColors.primary
                  ),
                ),
                title: 'Visitted Node'
              ),
            ],
          ),
          Row(
            children: [
              _note(
                child: Icon(Icons.flag, color: NodeState.start.color, size: 20,),
                title: 'Start Node'
              ),
              _note(
                child: Icon(Icons.location_on, color: NodeState.finish.color, size: 20,),
                title: 'Finish Node'
              ),
            ],
          ),
          Row(
            children: [
              _note(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5
                    ),
                    color: NodeState.wall.color
                  ),
                ),
                title: 'Wall Node'
              ),
              _note(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5
                    ),
                    color: NodeState.increasedWeight.color
                  ),
                ),
                title: 'Expensive Node'
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _note({
    required Widget child,
    required String title
  }) {
    return Expanded(
      child: Row(
        spacing: 20,
        children: [
          child,
          Text(title)
        ],
      ),
    );
  }

  /// [ChatGpt] : bottomSheetWidget dùng để mô tả chi tiết cách dùng.
  Widget buildNotesBottomSheetContent() {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SingleChildScrollView( // Dùng SingleChildScrollView để nội dung dài có thể cuộn
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Chú Thích Các Loại Node',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Danh sách các chú thích
            _NoteItem(
              iconWidget: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5),
                  color: NodeState.wall.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              title: 'Wall Node (Nút Tường)',
              description: 'Node bị chặn, thuật toán không thể di chuyển qua. Tạo bằng cách nhấn hoặc kéo chuột trên màn hình.',
            ),
            _NoteItem(
              iconWidget: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5),
                  color: NodeState.increasedWeight.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              title: 'Expensive Node (Nút Trọng Số Cao)',
              description: 'Node có trọng số lớn hơn (mặc định +5). Thuật toán sẽ "ngại" đi qua đây. Tạo bằng cách nhấn giữ (long press).',
            ),
            _NoteItem(
              iconWidget: Icon(Icons.flag, color: NodeState.start.color, size: 25),
              title: 'Start Node (Nút Bắt Đầu)',
              description: 'Điểm xuất phát của thuật toán. Có thể thay đổi vị trí bằng cách kéo và thả.',
            ),
            _NoteItem(
              iconWidget: Icon(Icons.location_on, color: NodeState.finish.color, size: 25),
              title: 'Finish Node (Nút Đích)',
              description: 'Điểm kết thúc mà thuật toán cần tìm đến. Có thể thay đổi vị trí bằng cách kéo và thả.',
            ),
            _NoteItem(
              iconWidget: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.grey.shade400),
                  color: NodeState.none.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              title: 'Empty Node (Nút Trống)',
              description: 'Node mặc định với trọng số bằng 1, là đường đi bình thường.',
            ),
            _NoteItem(
              iconWidget: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5),
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              title: 'Visited Node (Nút Đã Duyệt)',
              description: 'Node đã được thuật toán ghé thăm trong quá trình tìm đường đi.',
            ),
          ],
        ),
      ),
    );
  }
}


/// [ChatGpt]
///
/// Widget để hiển thị một dòng chú thích.
class _NoteItem extends StatelessWidget {
  const _NoteItem({
    required this.iconWidget,
    required this.title,
    required this.description,
  });

  final Widget iconWidget;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Khoảng cách giữa các dòng chú thích
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần biểu tượng (icon hoặc container màu)
          iconWidget,
          const SizedBox(width: 16),
          // Phần văn bản (tiêu đề và mô tả)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    height: 1.4, // Giãn dòng cho dễ đọc
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}