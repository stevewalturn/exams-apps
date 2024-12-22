import 'package:flutter/material.dart';

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
            color: Colors.black,
            width: 2,
          ),
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
    if (isHungry) return '🤤';
    if (isTired) return '😴';
    if (isHappy) return '😊';
    return '😐';
  }
}
