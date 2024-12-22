import 'package:flutter/material.dart';
import 'package:my_app/ui/common/app_colors.dart';

class TamagotchiAvatar extends StatelessWidget {
  final bool isHappy;
  final bool isTired;
  final bool isHungry;

  const TamagotchiAvatar({
    Key? key,
    required this.isHappy,
    required this.isTired,
    required this.isHungry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: kcPrimaryColor,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: kcPrimaryColor.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            _getEmoji(),
            style: const TextStyle(fontSize: 100),
          ),
        ),
      ),
    );
  }

  String _getEmoji() {
    if (isHungry) return '😋'; // Hungry
    if (isTired) return '😴'; // Tired
    if (isHappy) return '😊'; // Happy
    return '😐'; // Neutral
  }
}
