import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/models/tile_title_bar_info.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_title_bar.dart';
import 'package:xbox_launcher/shared/widgets/utils/commands/models/command_invoker.dart';
import 'package:xbox_launcher/shared/widgets/utils/commands/open_app_command.dart';
import 'package:xbox_launcher/shared/widgets/tiles/button_tile.dart';

class SystemAppButtonTile extends ButtonTile {
  final SystemAppModel appModel;

  SystemAppButtonTile(this.appModel,
      {Key? key,
      required BuildContext context, //Context to navigate
      required TileSize tileSize,
      ElementFocusNode? focusNode})
      : super(
            interactive: true,
            key: key,
            tileTitleBarInfo: TileTitleBarInfo(appModel.name),
            tileSize: tileSize,
            elementValue: appModel,
            focusNode: focusNode,
            icon: appModel.icon,
            onPressed: (_) {
              CommandInvoker command =
                  CommandInvoker(OpenAppCommand(appModel, context: context));
              command.execute();
            });
}
