import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/ui/views/tamagotchi/tamagotchi_viewmodel.dart';
import 'package:my_app/ui/common/app_colors.dart';

class TamagotchiStats extends ViewModelWidget<TamagotchiViewModel> {
  const TamagotchiStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TamagotchiViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildStatBar(
            'Happiness',
            viewModel.happiness,
            kcPrimaryColor,
            warning: viewModel.isHappy == false,
          ),
          const SizedBox(height: 8),
          _buildStatBar(
            'Energy',
            viewModel.energy,
            Colors.orange,
            warning: viewModel.isTired,
          ),
          const SizedBox(height: 8),
          _buildStatBar(
            'Hunger',
            viewModel.hunger,
            Colors.green,
            warning: viewModel.isHungry,
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(
    String label,
    int value,
    Color color, {
    bool warning = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$label: $value%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: warning ? Colors.red : Colors.black,
              ),
            ),
            if (warning)
              const Icon(
                Icons.warning,
                color: Colors.red,
                size: 18,
              ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              warning ? Colors.red : color,
            ),
            minHeight: 10,
          ),
        ),
      ],
    );
  }
}
