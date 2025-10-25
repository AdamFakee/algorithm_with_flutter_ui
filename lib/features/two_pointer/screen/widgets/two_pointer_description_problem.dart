import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_provider.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/sizes.dart';
import 'package:algorithm_with_flutter_ui/utils/extentions/context_extensions.dart';
import 'package:algorithm_with_flutter_ui/utils/popups/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/vs2015.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TwoPointerDescriptionProblem extends ConsumerWidget {
  const TwoPointerDescriptionProblem({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final algorithm = ref.watch(twoPointerProvider).selectedAlgorithm;

    if(algorithm == null) return const SizedBox.shrink();

    return Column(
      spacing: 20,
      children: [
        Text(
          'Đề Bài: ${algorithm.name}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24
          ),
        ),

        // -- mô tả đề bài
        SizedBox(
          width: double.infinity,
          child: MarkdownBody(
            data: algorithm.problem,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              h1: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              h2: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              h3: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              p: const TextStyle(fontSize: 14, height: 1.4, color: Colors.black),
              codeblockPadding:EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              codeblockDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 221, 221),
                borderRadius: BorderRadius.circular(5)
              ),
              code: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),

              // markdown == '---'
              horizontalRuleDecoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1.2,
                  ),
                ),
              ),
            ),

            // width full
            fitContent: false
          ),
        ),

        // -- thuật toán xử lý
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: context.width - Sizes.padding * 2
                  ),
                  child: HighlightView(
                    algorithm.dartCode,
                    language: 'dart',
                    theme: vs2015Theme,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: algorithm.dartCode)
                  );
        
                  if(context.mounted) {
                    Snackbar.show(context, type: SnackbarEnum.success, message: 'Copy to your clipboard');
                  }
                }, 
                icon: Icon(Icons.copy, color: Colors.grey)
              ),
            ),
          ],
        ),
      ],
    );
  }
}