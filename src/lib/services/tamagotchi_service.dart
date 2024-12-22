import 'package:stacked/stacked.dart';
import 'package:my_app/models/tamagotchi.dart';

class TamagotchiService extends BaseViewModel {
  Tamagotchi? _currentTamagotchi;
  bool _isBusy = false;

  Tamagotchi? get currentTamagotchi => _currentTamagotchi;
  bool get hasTamagotchi => _currentTamagotchi != null;
  bool get isBusy => _isBusy;

  void createTamagotchi(String name) {
    if (_isBusy) return;
    _isBusy = true;

    try {
      if (name.trim().isEmpty) {
        throw Exception('Name cannot be empty');
      }
      _currentTamagotchi = Tamagotchi.create(name.trim());
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to create Tamagotchi: ${e.toString()}');
    } finally {
      _isBusy = false;
    }
  }

  void feed() {
    if (_isBusy) return;
    _isBusy = true;

    try {
      if (!hasTamagotchi) {
        throw Exception('No Tamagotchi exists');
      }
      _currentTamagotchi = _currentTamagotchi!.copyWith(
        hunger: 100,
        lastFed: DateTime.now(),
      );
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to feed Tamagotchi: ${e.toString()}');
    } finally {
      _isBusy = false;
    }
  }

  void play() {
    if (_isBusy) return;
    _isBusy = true;

    try {
      if (!hasTamagotchi) {
        throw Exception('No Tamagotchi exists');
      }
      _currentTamagotchi = _currentTamagotchi!.copyWith(
        happiness: 100,
        energy: (_currentTamagotchi!.energy - 20).clamp(0, 100),
        lastPlayed: DateTime.now(),
      );
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to play with Tamagotchi: ${e.toString()}');
    } finally {
      _isBusy = false;
    }
  }

  void sleep() {
    if (_isBusy) return;
    _isBusy = true;

    try {
      if (!hasTamagotchi) {
        throw Exception('No Tamagotchi exists');
      }
      _currentTamagotchi = _currentTamagotchi!.copyWith(
        energy: 100,
        lastSlept: DateTime.now(),
      );
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to put Tamagotchi to sleep: ${e.toString()}');
    } finally {
      _isBusy = false;
    }
  }

  void updateStats() {
    if (!hasTamagotchi || _isBusy) return;
    _isBusy = true;

    try {
      final now = DateTime.now();
      final timeSinceLastFed = now.difference(_currentTamagotchi!.lastFed);
      final timeSinceLastPlayed =
          now.difference(_currentTamagotchi!.lastPlayed);
      final timeSinceLastSlept = now.difference(_currentTamagotchi!.lastSlept);

      _currentTamagotchi = _currentTamagotchi!.copyWith(
        hunger: (_currentTamagotchi!.hunger - timeSinceLastFed.inMinutes ~/ 2)
            .clamp(0, 100),
        happiness:
            (_currentTamagotchi!.happiness - timeSinceLastPlayed.inMinutes ~/ 3)
                .clamp(0, 100),
        energy: (_currentTamagotchi!.energy - timeSinceLastSlept.inMinutes ~/ 4)
            .clamp(0, 100),
      );
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to update Tamagotchi stats: ${e.toString()}');
    } finally {
      _isBusy = false;
    }
  }
}
