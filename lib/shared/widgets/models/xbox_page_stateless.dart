import 'package:flutter/cupertino.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class VoidActionIntent extends Intent {}

abstract class XboxPageStateless extends StatelessWidget {
  late Map<ShortcutActivator, void Function()> _keyboardBinding;
  Map<ControllerKeyboardPair, void Function(BuildContext context)>? keyAction;

  XboxPageStateless({Key? key, this.keyAction}) : super(key: key);

  void _mapKeyboardShortcuts(BuildContext context) {
    if (keyAction == null) return;

    Map<ShortcutActivator, void Function()> binding =
        <ShortcutActivator, void Function()>{};

    keyAction!.forEach((key, value) {
      binding[SingleActivator(key.keyboardkey)] = () => value(context);
    });

    _keyboardBinding = binding;
  }

  Widget virtualBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    _mapKeyboardShortcuts(context);

    return keyAction != null
        ? CallbackShortcuts(
            bindings: _keyboardBinding, child: virtualBuild(context))
        : virtualBuild(context);
  }
}