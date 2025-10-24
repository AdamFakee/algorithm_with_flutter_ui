import 'package:algorithm_with_flutter_ui/components/icons/icon_outline_button.dart';
import 'package:algorithm_with_flutter_ui/components/selects/select_options.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/algorithms/two_pointer.dart';
import 'package:algorithm_with_flutter_ui/features/two_pointer/state/two_pointer_provider.dart';
import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TwoPointerControlBoard extends ConsumerWidget {
  const TwoPointerControlBoard({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final selectedAlgorithm = ref.watch(twoPointerProvider).selectedAlgorithm;

    final algorithms = ref.read(twoPointerProvider.notifier).algorithms;

    final startAlgorithm = ref.read(twoPointerProvider.notifier).startAlgorithm;

    final reset = ref.read(twoPointerProvider.notifier).reset;

    return Column(
      spacing: 10,
      children: [
        SelectOptions(
          title: selectedAlgorithm?.name ?? 'Choose algorithm',
          child: _optionsBox(algorithms, ref, context),
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: startAlgorithm, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(15)
                  )
                ),
                child: Text("Run", style: TextStyle(
                  color: AppColors.white,
                ),)
              ),
            ),

            // reset nodes 
            IconOutlineButton(
              icon: Icons.refresh,
              onPressed: reset,
            ),
          ],
        )
      ],
    );
  }

  Widget _optionsBox(List<TwoPointer> algorithms, WidgetRef ref, BuildContext ctx) {
    final selectedAlgorithm = ref.read(twoPointerProvider.notifier).selectAlgorithm;

    return Column(
      spacing: 20,
      children: [
        Text(
          "Choose an algorithm",
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: algorithms.map((algo) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    selectedAlgorithm(algo);
                    Navigator.pop(ctx);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      algo.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        )
      ],
    );
  }
}