import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/commands/models/command_invoker.dart';
import 'package:xbox_launcher/shared/widgets/commands/open_app_command.dart';
import 'package:xbox_launcher/shared/widgets/tiles/button_tile.dart';

class GameButtonTile extends ButtonTile {
  final GameModel gameModel;

  GameButtonTile(this.gameModel, {Key? key, required TileSize tileSize})
      : super(
          gameModel.name,
          key: key,
          interactive: true,
          appBadgeInfo: gameModel.extraGameProperties.toBadgeInfo(),
          tileSize: tileSize,
          image: NetworkImage(gameModel.tileGameImageUrl),
          onPressed: (context) {
            CommandInvoker command =
                CommandInvoker(OpenAppCommand(gameModel, context: context));
            command.execute();
          },
        );
}