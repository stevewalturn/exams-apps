import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/services/tamagotchi_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TamagotchiViewModel extends BaseViewModel {
  final _tamagotchiService = locator<TamagotchiService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  bool get hasTamagotchi => _tamagotchiService.hasTamagotchi;
  String? get tamagotchiName => _tamagotchiService.currentTamagotchi?.name;

  int get happiness => _tamagotchiService.currentTamagotchi?.happiness ?? 0;
  int get hunger => _tamagotchiService.currentTamagotchi?.hunger ?? 0;
  int get energy => _tamagotchiService.currentTamagotchi?.energy ?? 0;

  bool get isHappy => !(_tamagotchiService.currentTamagotchi?.isSad ?? true);
  bool get isHungry => _tamagotchiService.currentTamagotchi?.isHungry ?? false;
  bool get isTired => _tamagotchiService.currentTamagotchi?.isTired ?? false;

  void initialize() {
    if (!hasTamagotchi) {
      createNewTamagotchi();
    }
    startPeriodicUpdate();
  }

  void startPeriodicUpdate() {
    // Update stats every minute
    Future.doWhile(() async {
      await Future.delayed(const Duration(minutes: 1));
      if (hasTamagotchi) {
        _tamagotchiService.updateStats();
        notifyListeners();
        return true;
      }
      return false;
    });
  }

  Future<void> createNewTamagotchi() async {
    final response = await _dialogService.showCustomDialog(
      variant: 'nameTamagotchi',
    );

    if (response?.confirmed ?? false) {
      notifyListeners();
      await _navigationService.replaceWithTamagotchiView();
    } else {
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
        description: 'Unable to feed your Tamagotchi. Please try again.',
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
        description: 'Unable to play with your Tamagotchi. Please try again.',
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
        description:
            'Unable to put your Tamagotchi to sleep. Please try again.',
      );
    }
  }
}
