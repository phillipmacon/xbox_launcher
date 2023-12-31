import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/profile_avatar_button.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';

class ProfileSelectorItem extends StatelessWidget implements FocableElement {
  final ProfileModel profileModel;
  final void Function() onSelect;

  @override
  Object? elementValue;
  @override
  ElementFocusNode? focusNode;

  ProfileSelectorItem(
      {Key? key,
      required this.profileModel,
      required this.onSelect,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FocusTheme(
          data: FocusThemeData(
              borderRadius: BorderRadius.circular(200),
              glowFactor: 10,
              renderOutside: true),
          child: ProfileAvatarButton(
            accentColor: profileModel.themePreferences.accentColor,
            profileImagePath: profileModel.profileImagePath,
            onPressed: onSelect,
            focusNode: focusNode,
          ),
        ),
        Text(
          profileModel.name,
          style: AppTextStyle.PROFILE_NAME_SELECTION_ITEM,
        )
      ],
    );
  }
}
