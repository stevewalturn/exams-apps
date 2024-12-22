import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/services/tamagotchi_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _tamagotchiService = locator<TamagotchiService>();

  bool get hasTamagotchi => _tamagotchiService.hasTamagotchi;
  String? get tamagotchiName => _tamagotchiService.currentTamagotchi?.name;

  Future<void> createNewTamagotchi() async {
    final dialogResponse = await _dialogService.showDialog(
      title: 'Create Your Tamagotchi',
      description: 'Would you like to create a new virtual pet?',
      buttonTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse?.confirmed ?? false) {
      await _navigationService.navigateToTamagotchiView();
    }
  }

  Future<void> goToTamagotchi() async {
    await _navigationService.navigateToTamagotchiView();
  }
}
