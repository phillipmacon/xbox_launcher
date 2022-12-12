import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/buttons/button_grid.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/xbox_page.dart';

abstract class ConfigurationMenu extends XboxPage {
  final String routeName;
  final String menuTitle;

  ConfigurationMenu(this.routeName, this.menuTitle, {Key? key})
      : super(key: key);

  List<ButtonGridGroup> buttonsBuilder(BuildContext context);

  @override
  Widget virtualBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 50, 250, 50),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Flexible(
          flex: 0,
          child: Row(
            children: [
              Flexible(
                flex: 0,
                child: Text(
                  routeName,
                  style: AppTextStyle.CONFIGURATION_PAGES_ROUTE_TITLE,
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 60,
                child: Text(
                  menuTitle,
                  style: AppTextStyle.CONFIGURATION_PAGES_TITLE,
                ),
              )
            ],
          ),
        ),
        const Spacer(),
        Flexible(
            flex: 10,
            child: ButtonGrid(
              buttons: buttonsBuilder(context),
            ))
      ]),
    );
  }
}
