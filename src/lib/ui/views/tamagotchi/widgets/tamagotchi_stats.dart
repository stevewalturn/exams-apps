import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/ui/views/tamagotchi/tamagotchi_viewmodel.dart';

class TamagotchiStats extends ViewModelWidget<TamagotchiViewModel> {
  const TamagotchiStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TamagotchiViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildStatBar('Happiness', viewModel.happiness, Colors.pink),
          const SizedBox(height: 8),
          _buildStatBar('Energy', viewModel.energy, Colors.yellow),
          const SizedBox(height: 8),
          _buildStatBar('Hunger', viewModel.hunger, Colors.green),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, int value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: $value%',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value / 100,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 10,
        ),
      ],
    );
  }
}
