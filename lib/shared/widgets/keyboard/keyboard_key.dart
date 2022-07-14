import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

class KeyboardKey extends StatelessWidget {
  String text;
  void Function() onKeyPress;

  KeyboardKey({Key? key, required this.text, required this.onKeyPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      child: Align(alignment: Alignment.center, child: Text(text)),
      onPressed: onKeyPress,
      style: ButtonStyle(
          shape: ButtonState.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          backgroundColor: ButtonState.all(AppColors.ELEMENT_DARK_BG)),
    );
  }
}
