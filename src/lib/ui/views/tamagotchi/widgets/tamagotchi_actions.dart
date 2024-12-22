import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/ui/views/tamagotchi/tamagotchi_viewmodel.dart';
import 'package:my_app/ui/common/app_colors.dart';

class TamagotchiActions extends ViewModelWidget<TamagotchiViewModel> {
  const TamagotchiActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TamagotchiViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            onPressed: viewModel.feed,
            icon: Icons.restaurant,
            label: 'Feed',
            enabled: viewModel.hasTamagotchi,
          ),
          _buildActionButton(
            onPressed: viewModel.play,
            icon: Icons.sports_esports,
            label: 'Play',
            enabled: viewModel.hasTamagotchi,
          ),
          _buildActionButton(
            onPressed: viewModel.sleep,
            icon: Icons.bed,
            label: 'Sleep',
            enabled: viewModel.hasTamagotchi,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required bool enabled,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: enabled ? kcPrimaryColor : Colors.grey,
          ),
          child: Icon(icon, size: 32, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: enabled ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}
