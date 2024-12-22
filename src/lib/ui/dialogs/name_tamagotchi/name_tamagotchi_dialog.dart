import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/ui/common/app_colors.dart';
import 'package:my_app/ui/common/ui_helpers.dart';
import 'package:my_app/ui/dialogs/name_tamagotchi/name_tamagotchi_dialog_model.dart';

class NameTamagotchiDialog extends StackedView<NameTamagotchiDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const NameTamagotchiDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NameTamagotchiDialogModel model,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Name Your Tamagotchi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            verticalSpaceMedium,
            TextField(
              onChanged: model.setName,
              decoration: const InputDecoration(
                hintText: 'Enter a name',
                border: OutlineInputBorder(),
              ),
            ),
            if (model.modelError != null) ...[
              verticalSpaceSmall,
              Text(
                model.modelError!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
            verticalSpaceMedium,
            GestureDetector(
              onTap: () {
                if (model.createTamagotchi()) {
                  completer(DialogResponse(confirmed: true));
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  NameTamagotchiDialogModel viewModelBuilder(BuildContext context) =>
      NameTamagotchiDialogModel();
}
