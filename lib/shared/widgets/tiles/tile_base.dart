import 'package:fluent_ui/fluent_ui.dart';

abstract class TileBase extends Widget {
  final double width;
  final double height;
  final Color? color;

  const TileBase(
      {Key? key, required this.width, required this.height, this.color})
      : super(key: key);
}
