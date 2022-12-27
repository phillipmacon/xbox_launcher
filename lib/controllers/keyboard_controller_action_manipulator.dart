import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/controller_action_provider.dart';
import 'package:xbox_launcher/providers/keyboard_action_provider.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class KeyboardControllerActionManipulator {
  static void mapKeyboardControllerActions(
      BuildContext context, List<ShortcutOption> shortcutsOptions,
      {bool notifyChanges = true}) {
    if (shortcutsOptions.isEmpty) return;

    var keyboardProvider =
        Provider.of<KeyboardActionProvider>(context, listen: false);
    var controllerProvider =
        Provider.of<ControllerActionProvider>(context, listen: false);

    Map<ShortcutActivator, void Function()> keyboarMapping = {};
    Map<ControllerButton, void Function()> controllerMapping = {};
    for (var action in shortcutsOptions
        .map((shortcutOption) => shortcutOption.rawShortcut)) {
      keyboarMapping[action.key.keyboardkey] = () => action.value();
      controllerMapping[action.key.controllerButton] = () => action.value();
    }

    keyboardProvider.setKeyboardBinding(keyboarMapping,
        notifyChanges: notifyChanges);
    controllerProvider.setControllerMapping(controllerMapping);
  }

  static void applyMementoInAll(BuildContext context) {
    Provider.of<KeyboardActionProvider>(context, listen: false).popLastBindig();
    Provider.of<ControllerActionProvider>(context, listen: false)
        .popLastKeyboardBindig();
  }
}
