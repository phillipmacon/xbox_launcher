// ignore_for_file: constant_identifier_names

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImages {
  static const String BUTTONS_ASSETS_PATH = "assets/buttons/";
  static const String SVGS_ASSETS_PATH = "assets/svgs/";

  //Buttons
  static const A_BUTTON_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}a_button.png");
  static const B_BUTTON_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}b_button.png");
  static const X_BUTTON_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}x_button.png");
  static const Y_BUTTON_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}y_button.png");

  //Sholders
  static const LEFT_SHOLDER_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}lb_button.png");
  static const RIGHT_SHOLDER_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}rb_button.png");

  //Thumbs
  static const LEFT_THUMB_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}l_thumb.png");
  static const RIGHT_THUMB_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}r_thumb.png");

  //Triggers
  static const LEFT_TRIGGER_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}lt_trigger.png");
  static const RIGHT_TRIGGER_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}rt_trigger.png");

  //Central buttons
  static const START_BUTTON_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}menu_button.png");
  static const BACK_BUTTON_IMAGE =
      AssetImage("${BUTTONS_ASSETS_PATH}back_button.png");

  //Tiles badge
  static const GAMEPASS_BADGE = "${SVGS_ASSETS_PATH}game_pass_badge.svg";
  static const CONTROLLER_SUPPORT_BADGE =
      "${SVGS_ASSETS_PATH}controller_support.svg";
  static const TOUCH_SUPPORT = "${SVGS_ASSETS_PATH}touch_support.svg";
}
