import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/external_file_picker.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/shortcut_activator.dart';
import 'package:xbox_launcher/pages/page_models_base/configuration_menu.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/menu_dialog_overlay.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';
import 'package:xbox_launcher/shared/widgets/tiles/button_tile.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_grid.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class PersonalizationConfigurationPage extends ConfigurationMenu {
  PersonalizationConfigurationPage({Key? key})
      : super("General", "Personalization", key: key);

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => [
        ShortcutOption("",
            controllerKeyboardPair: ControllerKeyboardPair(
                const SingleActivator(LogicalKeyboardKey.escape),
                ControllerButton.B_BUTTON),
            action: (context) => Navigator.pop(context))
      ];

  void setCustomImage(BuildContext context) async {
    var profileProvider = context.read<ProfileProvider>();

    String? imagePath = await ExternalFilePicker.getImagePath();
    if (imagePath == null) return;

    profileProvider.imageBackgroundPath = imagePath;
    profileProvider.preferenceByImage = true;
  }

  void setMainColor(BuildContext context) {
    MenuDialogOverlay("Colors",
        content: TileGrid.build(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
          itemCount: AppColors.COLORS_LIST.length - 1,
          itemBuilder: (context, index) {
            return ButtonTile(
              "",
              tileSize: TileSize.MEDIUM,
              color: AppColors.COLORS_LIST[index],
              onPressed: (context) {
                Provider.of<ProfileProvider>(context, listen: false)
                    .preferedColorIndex = index;
                Navigator.pop(context);
              },
            );
          },
          scrollDirection: Axis.horizontal,
        )).show(context);
  }

  void setBackgroundColor(BuildContext context) {
    MenuDialogOverlay("Background color",
        content: TileGrid.build(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
          itemCount: AppColors.COLORS_LIST.length - 1,
          itemBuilder: (context, index) {
            return ButtonTile(
              "",
              tileSize: TileSize.MEDIUM,
              color: AppColors.COLORS_LIST[index],
              onPressed: (context) {
                var state = context.read<ProfileProvider>();
                state.backgroundColorIndex = index;
                state.preferenceByImage = false;

                Navigator.pop(context);
              },
            );
          },
          scrollDirection: Axis.horizontal,
        )).show(context);
  }

  @override
  Map<String, List<SystemButton>> buttonsBuilder(BuildContext context) => {
        "Colors": [
          TextButton(title: "Colors", onPressed: () => setMainColor(context)),
        ],
        "My Background": [
          TextButton(
              title: "Solid color",
              onPressed: () => setBackgroundColor(context)),
          TextButton(
              title: "Custom image", onPressed: () => setCustomImage(context)),
          TextButton(
              title: "Reset background",
              onPressed: () =>
                  Provider.of<ProfileProvider>(context, listen: false)
                      .resetBackground())
        ]
      };
}
