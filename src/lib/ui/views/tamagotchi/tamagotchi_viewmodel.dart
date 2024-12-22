import 'dart:async';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/services/tamagotchi_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TamagotchiViewModel extends BaseViewModel {
  final _tamagotchiService = locator<TamagotchiService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  Timer? _updateTimer;

  bool get hasTamagotchi => _tamagotchiService.hasTamagotchi;
  String? get tamagotchiName => _tamagotchiService.currentTamagotchi?.name;

  int get happiness => _tamagotchiService.currentTamagotchi?.happiness ?? 0;
  int get hunger => _tamagotchiService.currentTamagotchi?.hunger ?? 0;
  int get energy => _tamagotchiService.currentTamagotchi?.energy ?? 0;

  bool get isHappy => !(_tamagotchiService.currentTamagotchi?.isSad ?? true);
  bool get isHungry => _tamagotchiService.currentTamagotchi?.isHungry ?? false;
  bool get isTired => _tamagotchiService.currentTamagotchi?.isTired ?? false;

  @override
  void dispose() {
    cancelPeriodicUpdate();
    super.dispose();
  }

  void initialize() {
    setBusy(true);
    try {
      if (!hasTamagotchi) {
        createNewTamagotchi();
      }
      startPeriodicUpdate();
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to initialize Tamagotchi: ${e.toString()}',
      );
    } finally {
      setBusy(false);
    }
  }

  void startPeriodicUpdate() {
    cancelPeriodicUpdate();
    _updateTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) {
        if (hasTamagotchi) {
          try {
            _tamagotchiService.updateStats();
            notifyListeners();
          } catch (e) {
            _dialogService.showDialog(
              title: 'Update Error',
              description: 'Failed to update Tamagotchi stats: ${e.toString()}',
            );
          }
        }
      },
    );
  }

  void cancelPeriodicUpdate() {
    _updateTimer?.cancel();
    _updateTimer = null;
  }

  Future<void> createNewTamagotchi() async {
    try {
      final response = await _dialogService.showCustomDialog(
        variant: 'nameTamagotchi',
      );

      if (response?.confirmed ?? false) {
        notifyListeners();
        await _navigationService.replaceWithTamagotchiView();
      } else {
        await _navigationService.replaceWithHomeView();
      }
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to create new Tamagotchi: ${e.toString()}',
      );
      await _navigationService.replaceWithHomeView();
    }
  }

  void feed() {
    try {
      _tamagotchiService.feed();
      notifyListeners();
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: 'Unable to feed your Tamagotchi: ${e.toString()}',
      );
    }
  }

  void play() {
    try {
      _tamagotchiService.play();
      notifyListeners();
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: 'Unable to play with your Tamagotchi: ${e.toString()}',
      );
    }
  }

  void sleep() {
    try {
      _tamagotchiService.sleep();
      notifyListeners();
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: 'Unable to put your Tamagotchi to sleep: ${e.toString()}',
      );
    }
  }
}
