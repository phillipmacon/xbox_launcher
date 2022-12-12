import 'package:flutter/material.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_item.dart';

abstract class ContextMenuBase {
  final String title;
  final List<ContextMenuItem>? contextItems;

  ContextMenuBase(this.title, {this.contextItems});

  Widget dialogContentBuilder(BuildContext context);
  Widget buildContextItemsList(BuildContext context) => Expanded(
        child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) => contextItems![index],
            itemCount: contextItems!.length,
            separatorBuilder: (_, __) => const SizedBox(
                  height: 8.0,
                )),
      );

  Future show(BuildContext context) async {
    final size = MediaQuery.of(context).size;

    await showDialog(
        context: context,
        builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              alignment: Alignment.center,
              child: Container(
                  width: size.width * 0.2,
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 1.0, right: 1.0),
                  decoration: BoxDecoration(
                      color: AppColors.ELEMENT_BG,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: dialogContentBuilder(context)),
            ));
  }
}
