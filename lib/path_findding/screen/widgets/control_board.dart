import 'package:algorithm_with_flutter_ui/utils/consts/colors.dart';
import 'package:algorithm_with_flutter_ui/path_findding/algorithms/path_findding.dart';
import 'package:algorithm_with_flutter_ui/path_findding/state/path_findding_provider.dart';
import 'package:algorithm_with_flutter_ui/components/icons/icon_outline_button.dart';
import 'package:algorithm_with_flutter_ui/components/selects/select_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlBoard extends ConsumerWidget {
  const ControlBoard({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final selectedAlgorithm = ref.watch(pathFinddingProvider).selectedAlgorithmOpt;

    final algorithms = ref.read(pathFinddingProvider.notifier).algorithmOpts;

    final startAlgorithm = ref.read(pathFinddingProvider.notifier).startAlgorithm;

    final resetVisittedNode = ref.read(pathFinddingProvider.notifier).resetVisittedNode;

    final reset = ref.read(pathFinddingProvider.notifier).reset;

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

            // reset visitted nodes 
            IconOutlineButton(
              icon: Icons.refresh,
              onPressed: resetVisittedNode,
            ),

            // clear node board
            IconOutlineButton(
              icon: Icons.delete_outline,
              onPressed: reset,
            ),

            // toggle display distance
            Consumer(
              builder: (context, ref, child) {
                final toggleShowDistance = ref.watch(pathFinddingProvider.notifier).toggleShowDistance;

                final isShowDistance = ref.watch(pathFinddingProvider).isShowDistance;

                return IconOutlineButton(
                  icon: isShowDistance ? Icons.visibility_off : Icons.visibility,
                  onPressed: toggleShowDistance,
                );
              },
            )
          ],
        )
      ],
    );
  }

  // Widget _optionsBox(List<PathFindding> algorithms, WidgetRef ref, BuildContext ctx) {
  //   final selectAlgorithmOpt = ref.read(pathFinddingProvider.notifier).selectAlgorithmOpt;

  //   return Column(
  //     children: [
  //       Text("Choose an algorithm"),
  //       ...algorithms.map((algo) {
  //         return ListTile(
  //           title: Text(
  //             algo.name,
  //             style: const TextStyle(
  //               fontWeight: FontWeight.w600,
  //               fontSize: 15,
  //               color: Colors.black87,
  //             ),
  //           ),
  //           onTap: () {
  //             selectAlgorithmOpt(algo);
  //             Navigator.pop(ctx);
  //           },
  //         );
  //       })
  //     ],
  //   );
  // }

  Widget _optionsBox(List<PathFindding> algorithms, WidgetRef ref, BuildContext ctx) {
    final selectAlgorithmOpt = ref.read(pathFinddingProvider.notifier).selectAlgorithmOpt;

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
                    selectAlgorithmOpt(algo);
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