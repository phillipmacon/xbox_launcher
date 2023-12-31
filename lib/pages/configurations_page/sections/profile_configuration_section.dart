import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/widgets/buttons/button_grid.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_text_button.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';

class ProfileConfigurationSection extends NavigationSectionStateless {
  const ProfileConfigurationSection({super.key, required super.currentScope})
      : super("Profile");

  Future _removeProfileFlow(ProfileModel toRemove, BuildContext context) {
    return SystemDialog(
        textTitle: "Do you want to remove ${toRemove.name}",
        textContent:
            "You will lost all the profile info (Configurations, customizations, historic and more...).\n"
            "This action can't be undo.",
        actions: [
          TextButton(
            title: "Continue",
            onPressed: () async {
              bool result =
                  await Provider.of<ProfileProvider>(context, listen: false)
                      .removeProfile(toRemove);

              if (!result) {
                await SystemDialog(
                  textTitle: "A error occurs",
                  textContent: "You can't delete a profile that is being used.",
                  actions: [
                    TextButton(
                      title: "OK",
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ).show(context);
              }

              Navigator.pop(context);
            },
          ),
          TextButton(
            title: "Cancel",
            onPressed: () => Navigator.pop(context),
          )
        ]).show(context);
  }

  @override
  List<Widget>? titleActions(BuildContext context) => null;

  @override
  List<Widget> columnItems(BuildContext context) => [
        Expanded(
          flex: 15,
          child: ButtonGrid(
            buttons: [
              ButtonGridGroup(
                buttons: [
                  IconTextButton(
                    title: "Add profiles",
                    icon: FluentIcons.add_friend,
                    width: null,
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.addProfileRoute),
                  ),
                  IconTextButton(
                    title: "Manage profile",
                    icon: FluentIcons.account_management,
                    width: null,
                    onPressed: () => Navigator.pushNamed(
                        context, AppRoutes.manageProfileRoute),
                  ),
                ],
              ),
              ButtonGridGroup(
                buttons: [
                  IconTextButton(
                    title: "Remove profiles",
                    icon: FluentIcons.user_remove,
                    width: null,
                    onPressed: () => Navigator.pushNamed(
                        context, AppRoutes.selectProfileRoute,
                        arguments: [
                          "Select to delete.",
                          (context, selectedProfile) async {
                            await _removeProfileFlow(selectedProfile, context);
                            Navigator.pop(context);
                          }
                        ]),
                  ),
                  IconTextButton(
                    title: "Change profile",
                    icon: FluentIcons.follow_user,
                    width: null,
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.selectProfileRoute,
                      arguments: [
                        null,
                        (BuildContext context, ProfileModel selectedProfile) {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .setCurrentById(selectedProfile.id);
                          Navigator.pop(context);
                        }
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ];
}
