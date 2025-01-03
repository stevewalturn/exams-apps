import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/ui/views/tamagotchi/tamagotchi_viewmodel.dart';
import 'package:my_app/ui/views/tamagotchi/widgets/tamagotchi_avatar.dart';
import 'package:my_app/ui/views/tamagotchi/widgets/tamagotchi_stats.dart';
import 'package:my_app/ui/views/tamagotchi/widgets/tamagotchi_actions.dart';
import 'package:my_app/ui/common/ui_helpers.dart';

class TamagotchiView extends StackedView<TamagotchiViewModel> {
  const TamagotchiView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TamagotchiViewModel viewModel,
    Widget? child,
  ) {
    return WillPopScope(
      onWillPop: () async {
        viewModel.cancelPeriodicUpdate();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            viewModel.tamagotchiName ?? 'My Tamagotchi',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: viewModel.isBusy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: viewModel.hasTamagotchi
                    ? Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TamagotchiAvatar(
                              isHappy: viewModel.isHappy,
                              isTired: viewModel.isTired,
                              isHungry: viewModel.isHungry,
                            ),
                          ),
                          const TamagotchiStats(),
                          verticalSpaceMedium,
                          const TamagotchiActions(),
                          verticalSpaceLarge,
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'You don\'t have a Tamagotchi yet!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            verticalSpaceMedium,
                            ElevatedButton(
                              onPressed: viewModel.createNewTamagotchi,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                              ),
                              child: const Text('Create New Tamagotchi'),
                            ),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }

  @override
  TamagotchiViewModel viewModelBuilder(BuildContext context) =>
      TamagotchiViewModel();

  @override
  void onViewModelReady(TamagotchiViewModel viewModel) {
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }
}
