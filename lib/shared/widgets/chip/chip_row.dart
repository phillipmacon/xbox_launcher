import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_base.dart';
import 'package:collection/collection.dart';
import 'package:xbox_launcher/shared/widgets/utils/observers/observer.dart';

class ChipsRow extends StatefulWidget {
  final List<ChipBase> chips;
  final void Function(bool, Object?) onCheckChange;

  const ChipsRow(this.chips, {super.key, required this.onCheckChange});

  @override
  State<ChipsRow> createState() => _ChipsRowState();
}

class _ChipsRowState extends State<ChipsRow> implements Observer {
  late List<ChipBase> chips;

  @override
  void initState() {
    super.initState();
    chips = List.from(widget.chips);
    for (var chip in chips) {
      chip.observer = this;
      chip.onCheck = widget.onCheckChange;
    }
  }

  @override
  void react(Object sender, Object? payload) {
    ChipBase? currentSelected =
        chips.firstWhereOrNull((chip) => chip != sender && chip.isSelected);
    currentSelected?.rebuildChip(() {
      currentSelected.isSelected = false;
    });
    widget.onCheckChange((sender as ChipBase).isSelected, payload);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: chips,
    );
  }
}
