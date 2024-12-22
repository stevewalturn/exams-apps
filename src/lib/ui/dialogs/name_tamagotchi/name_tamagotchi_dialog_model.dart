import 'package:stacked/stacked.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/services/tamagotchi_service.dart';

class NameTamagotchiDialogModel extends BaseViewModel {
  final _tamagotchiService = locator<TamagotchiService>();
  String? _name;
  String? get name => _name;

  String? _modelError;
  String? get modelError => _modelError;

  void setName(String value) {
    _name = value;
    _modelError = null;
    notifyListeners();
  }

  bool createTamagotchi() {
    if (_name == null || _name!.isEmpty) {
      _modelError = 'Please enter a name for your Tamagotchi';
      notifyListeners();
      return false;
    }

    try {
      _tamagotchiService.createTamagotchi(_name!);
      return true;
    } catch (e) {
      _modelError = 'Failed to create Tamagotchi: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }
}
