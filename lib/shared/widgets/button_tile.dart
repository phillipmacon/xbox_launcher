import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tile_base_stateful.dart';
import 'package:xbox_launcher/shared/widgets/tile_title_bar.dart';

class ButtonTile extends TileBaseStateful {
  String title;
  bool interactive;
  IconData? icon;
  ImageProvider? image;
  void Function(BuildContext)? onPressed;

  @override
  Color color;
  @override
  late double height;
  @override
  late double width;

  late TileSize _tileSize;
  TileSize get tileSize => _tileSize;
  late Widget _tileCover;

  ButtonTile(this.title, this.interactive,
      {Key? key,
      required TileSize tileSize,
      this.color = Colors.transparent,
      this.onPressed,
      this.icon,
      this.image})
      : super(key: key) {
    _tileSize = tileSize;
    switch (tileSize) {
      case TileSize.SMALL:
        width = 100;
        height = 100;
        break;
      case TileSize.MEDIUM:
        width = 150;
        height = 150;
        break;
      case TileSize.BIG:
        width = 300;
        height = 300;
        break;
      case TileSize.LENGHTY:
        width = 200;
        height = 100;
        break;
    }

    _generateCover();
  }

  void _generateCover() {
    if (image != null) {
      _tileCover = Image(
        image: image!,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    } else if (icon != null) {
      _tileCover = Align(
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: Colors.white,
          size: 35,
        ),
      );
    } else {
      color = color == Colors.transparent ? AppColors.GREEN : color;
      _tileCover = Container(color: color);
    }
  }

  @override
  State<StatefulWidget> vitualCreateState() => _ButtonTileState();
}

class _ButtonTileState extends TileBaseStatefulState<ButtonTile> {
  final focusNode = FocusNode();
  late bool getFocused;
  TileTitleBar? titleBar;

  @override
  void initState() {
    super.initState();
    if (widget.interactive) {
      focusNode.addListener(() {
        setState(() {
          titleBar = focusNode.hasFocus ? TileTitleBar(widget.title) : null;
        });
      });
    }
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return Button(
      focusNode: focusNode,
      style: ButtonStyle(
          backgroundColor: ButtonState.all(Colors.transparent),
          elevation: ButtonState.all(0),
          padding: ButtonState.all(EdgeInsets.zero)),
      onPressed: () => widget.onPressed!(context),
      child: Stack(
        children: [
          widget._tileCover,
          Align(
              alignment: Alignment.bottomLeft,
              child: titleBar ?? const SizedBox())
        ],
      ),
    );
  }
}
