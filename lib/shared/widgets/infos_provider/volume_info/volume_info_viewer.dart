import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:sys_info_getter/sys_info_getter.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/utils/disk_size_formatter.dart';

class VolumeInfoViwer extends StatelessWidget {
  final DiskInfo diskInfo;

  const VolumeInfoViwer(this.diskInfo, {super.key});

  String get formatedBytes =>
      DiskSizeFormatter.formatBytes(diskInfo.sizeRemaining, 1);
  double get percentageRemaining {
    final freeSpace = diskInfo.size - diskInfo.sizeRemaining;
    return (freeSpace / diskInfo.size) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final percentageRemainingCache = percentageRemaining;

    return SizedBox(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Volume: ${diskInfo.driveLetter}\n$formatedBytes free",
                    style: AppTextStyle.VOLUME_INFOS,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: ProgressRing(
                      value: percentageRemainingCache,
                      activeColor:
                          Provider.of<ProfileProvider>(context, listen: false)
                              .accentColor,
                      backwards: true,
                      strokeWidth: 3,
                    ),
                  ),
                  Center(
                      child: Text(
                    percentageRemainingCache.toStringAsFixed(1) + "%",
                    style: AppTextStyle.VOLUME_PERCENTAGE,
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
