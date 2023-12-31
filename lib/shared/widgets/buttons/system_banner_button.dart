import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_button.dart';

class SystemBannerButton extends SystemButton {
  final String text;
  final void Function() onClick;
  final IconData? icon;
  final ImageProvider? backgroundImage;

  SystemBannerButton(
    this.text, {
    super.key,
    required this.onClick,
    this.icon,
    this.backgroundImage,
    super.width = 240,
    super.height = 140,
  }) : super(
            content: Builder(builder: ((BuildContext context) {
              if (icon != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      size: 26,
                    ),
                    Text(
                      text,
                      style: AppTextStyle.SYSTEM_BUTTON_TEXT,
                    )
                  ],
                );
              } else if (backgroundImage != null) {
                return Stack(
                  children: [
                    Image(
                      image: backgroundImage,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(text),
                    )
                  ],
                );
              }

              return const SizedBox();
            })),
            onPressed: onClick);
}
