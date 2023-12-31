import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/external_file_picker.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/alert_bar/alert_bar_overlay.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_button.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page.dart';
import 'package:xbox_launcher/shared/widgets/buttons/profile_avatar_button.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class AddProfilePage extends XboxPage {
  const AddProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends XboxPageState<AddProfilePage> {
  String? _profileImagePath;
  late final TextEditingController profileNameController;

  @override
  void initState() {
    super.initState();
    profileNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    profileNameController.dispose();
  }

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => [
        ShortcutOption("Back",
            controllerKeyboardPair: ControllerKeyboardPair(
                const SingleActivator(LogicalKeyboardKey.escape),
                ControllerButton.B_BUTTON),
            action: () => Navigator.pop(context))
      ];

  bool _isProfileNameValid() => profileNameController.text.isNotEmpty;
  Future changeToNewProfileDialog(
      BuildContext context, ProfileModel newProfile) async {
    await SystemDialog(
        textTitle: "Change to new profile?",
        textContent:
            "Do you want to change to the profile ${profileNameController.text} now?",
        actions: [
          TextButton(
            title: "Yes",
            onPressed: () async {
              await Provider.of<ProfileProvider>(context, listen: false)
                  .setCurrentById(newProfile.id);

              Navigator.pop(context);
            },
          ),
          TextButton(title: "No", onPressed: () => Navigator.pop(context))
        ]).show(context);
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Flexible(
                child: Text(
              "Add profile",
              style: AppTextStyle.ADD_UPDATE_PROFILE_PAGE_TITLE,
            )),
            Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 15,
                      child: ProfileAvatarButton(
                          accentColor: AppColors.GREEN,
                          onPressed: () async {
                            String? tempImagePath =
                                await ExternalFilePicker.getImagePath();
                            setState(() => _profileImagePath = tempImagePath);
                          },
                          radiusSize: 100,
                          profileImagePath: _profileImagePath)),
                  const Spacer(),
                  Expanded(
                    flex: 15,
                    child: InfoLabel(
                      label: "Profile name:",
                      child: KeyboardButton(
                        placeholder: "Profile name",
                        controller: profileNameController,
                        maxLenght: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                      title: "Confirm",
                      onPressed: () async {
                        if (!_isProfileNameValid()) {
                          AlertBarOverlay("Can't be empty.",
                                  "The Profile name can't be empty.",
                                  severity: InfoBarSeverity.error)
                              .show(context);
                          return;
                        }

                        final ProfileProvider profileProvider =
                            Provider.of<ProfileProvider>(context,
                                listen: false);

                        ProfileModel newProfile =
                            profileProvider.generateNewDumyProfile();
                        newProfile.name = profileNameController.text;
                        newProfile.profileImagePath = _profileImagePath;

                        profileProvider.addNewProfile(newProfile);

                        await changeToNewProfileDialog(context, newProfile);
                        Navigator.pop(context);
                      }),
                  TextButton(
                    title: "Cancel",
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            )
          ]),
    );
  }
}
