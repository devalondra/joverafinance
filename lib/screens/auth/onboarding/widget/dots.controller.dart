import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/screens/auth/onboarding/controller/onboarding_controller.dart';

class DotsController extends ConsumerWidget {
  const DotsController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(onBoardingControllerProvider.notifier);
    ref.watch(onBoardingControllerProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onBoardingList.length,
        (index) => AnimatedContainer(
          margin: const EdgeInsets.all(5),
          duration: const Duration(milliseconds: 300),
          width:
              controller.currentPage == index
                  ? fullWidth * 0.065
                  : fullWidth * 0.018,
          height: fullWidth * 0.018,
          decoration: BoxDecoration(
            color:
                controller.currentPage == index
                    ? AppColors.primary
                    : AppColors.darkGrey,
            borderRadius: BorderRadius.circular(fullWidth * 0.09),
          ),
        ),
      ),
    );
  }
}
