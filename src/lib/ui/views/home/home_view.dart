import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_app/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Gap(50),
                Column(
                  children: [
                    const Text(
                      'Welcome to Tamagotchi',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Gap(25),
                    if (viewModel.hasTamagotchi) ...[
                      Text(
                        'Your pet ${viewModel.tamagotchiName} is waiting!',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Gap(16),
                      ElevatedButton(
                        onPressed: viewModel.goToTamagotchi,
                        child: const Text('Visit Your Pet'),
                      ),
                    ] else ...[
                      const Text(
                        'Create your virtual pet!',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Gap(16),
                      ElevatedButton(
                        onPressed: viewModel.createNewTamagotchi,
                        child: const Text('Get Started'),
                      ),
                    ],
                  ],
                ),
                const Gap(50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
