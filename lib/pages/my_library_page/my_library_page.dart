import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/my_apps_section.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/my_games_section.dart';
import 'package:xbox_launcher/shared/widgets/models/navigation_item.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xbox_launcher/shared/widgets/navigation_bar.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class MyLibraryPage extends XboxPageStateful {
  MyLibraryPage({Key? key})
      : super(keyAction: {
          ControllerKeyboardPair(
                  LogicalKeyboardKey.escape, ControllerButton.BACK):
              ((context) => Navigator.pop(context))
        }, key: key);

  @override
  State<StatefulWidget> vitualCreateState() => _MyGamesPageState();
}

class _MyGamesPageState extends XboxPageState<MyLibraryPage> {
  late int selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = 0;
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return NavigationBar(
        icon: FluentIcons.library,
        paneItems: [NavigationItem("Games"), NavigationItem("Apps")],
        bodyItems: const [MyGamesSection(), MyAppsSection()]);
  }
}