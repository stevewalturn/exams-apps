import 'package:stacked/stacked.dart';
import 'package:my_app/models/tamagotchi.dart';

class TamagotchiService {
  Tamagotchi? _currentTamagotchi;

  Tamagotchi? get currentTamagotchi => _currentTamagotchi;

  bool get hasTamagotchi => _currentTamagotchi != null;

  void createTamagotchi(String name) {
    if (name.isEmpty) {
      throw Exception('Name cannot be empty');
    }
    _currentTamagotchi = Tamagotchi.create(name);
    notifyListeners();
  }

  void feed() {
    if (!hasTamagotchi) {
      throw Exception('No Tamagotchi exists');
    }
    _currentTamagotchi = _currentTamagotchi!.copyWith(
      hunger: 100,
      lastFed: DateTime.now(),
    );
    notifyListeners();
  }

  void play() {
    if (!hasTamagotchi) {
      throw Exception('No Tamagotchi exists');
    }
    _currentTamagotchi = _currentTamagotchi!.copyWith(
      happiness: 100,
      energy: (_currentTamagotchi!.energy - 20).clamp(0, 100),
      lastPlayed: DateTime.now(),
    );
    notifyListeners();
  }

  void sleep() {
    if (!hasTamagotchi) {
      throw Exception('No Tamagotchi exists');
    }
    _currentTamagotchi = _currentTamagotchi!.copyWith(
      energy: 100,
      lastSlept: DateTime.now(),
    );
    notifyListeners();
  }

  void updateStats() {
    if (!hasTamagotchi) return;

    final now = DateTime.now();
    final timeSinceLastFed = now.difference(_currentTamagotchi!.lastFed);
    final timeSinceLastPlayed = now.difference(_currentTamagotchi!.lastPlayed);
    final timeSinceLastSlept = now.difference(_currentTamagotchi!.lastSlept);

    _currentTamagotchi = _currentTamagotchi!.copyWith(
      hunger:
          (_currentTamagotchi!.hunger - timeSinceLastFed.inHours).clamp(0, 100),
      happiness: (_currentTamagotchi!.happiness - timeSinceLastPlayed.inHours)
          .clamp(0, 100),
      energy: (_currentTamagotchi!.energy - timeSinceLastSlept.inHours)
          .clamp(0, 100),
    );
    notifyListeners();
  }
}
