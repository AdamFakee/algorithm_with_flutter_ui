import 'package:algorithm_with_flutter_ui/features/two_pointer/screen/widgets/two_pointer_control_board.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/screen/widgets/two_pointer_description_problem.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/screen/widgets/two_pointer_information_board.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/screen/widgets/two_pointer_input.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/screen/widgets/two_pointer_node_board.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/sizes.dart';
import 'package:algorithm_with_flutter_ui/utils/extentions/context_extensions.dart';
import 'package:flutter/material.dart';


class TwoPointerScreen extends StatelessWidget {
  const TwoPointerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Two Pointer",
          style: TextStyle(
            fontWeight: FontWeight.w500, 
            fontSize: 30
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.padding
        ),
        child: Column(
          spacing: 20,
          children: [
            TwoPointerNodeBoard(),
            TwoPointerInformationBoard(),
            TwoPointerControlBoard(),
            TwoPointerDescriptionProblem()
          ],
        )
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          // bàn phím hiển thị => đẩy child widget lên thay vì để nó bị che mất
          bottom: context.keyboardHeight
        ),
        child: TwoPointerInput(),
      ),
    );
  }
}

