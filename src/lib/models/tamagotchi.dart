import 'package:equatable/equatable.dart';

class Tamagotchi extends Equatable {
  final String id;
  final String name;
  final int happiness;
  final int hunger;
  final int energy;
  final DateTime lastFed;
  final DateTime lastPlayed;
  final DateTime lastSlept;

  const Tamagotchi({
    required this.id,
    required this.name,
    required this.happiness,
    required this.hunger,
    required this.energy,
    required this.lastFed,
    required this.lastPlayed,
    required this.lastSlept,
  });

  Tamagotchi copyWith({
    String? id,
    String? name,
    int? happiness,
    int? hunger,
    int? energy,
    DateTime? lastFed,
    DateTime? lastPlayed,
    DateTime? lastSlept,
  }) {
    return Tamagotchi(
      id: id ?? this.id,
      name: name ?? this.name,
      happiness: happiness ?? this.happiness,
      hunger: hunger ?? this.hunger,
      energy: energy ?? this.energy,
      lastFed: lastFed ?? this.lastFed,
      lastPlayed: lastPlayed ?? this.lastPlayed,
      lastSlept: lastSlept ?? this.lastSlept,
    );
  }

  factory Tamagotchi.create(String name) {
    return Tamagotchi(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      happiness: 100,
      hunger: 100,
      energy: 100,
      lastFed: DateTime.now(),
      lastPlayed: DateTime.now(),
      lastSlept: DateTime.now(),
    );
  }

  bool get isHungry => hunger < 50;
  bool get isTired => energy < 50;
  bool get isSad => happiness < 50;
  bool get needsAttention => isHungry || isTired || isSad;

  @override
  List<Object?> get props => [
        id,
        name,
        happiness,
        hunger,
        energy,
        lastFed,
        lastPlayed,
        lastSlept,
      ];
}
