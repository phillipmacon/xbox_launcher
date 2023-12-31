import 'package:xbox_launcher/models/apps_historic.dart';
import 'package:xbox_launcher/models/background_profile_preferences.dart';
import 'package:xbox_launcher/models/profile_apps_groups.dart';
import 'package:xbox_launcher/models/profile_preview_elements_preferences.dart';
import 'package:xbox_launcher/models/theme_data_profile.dart';
import 'package:xbox_launcher/models/video_preferences.dart';
import 'package:xbox_launcher/shared/app_consts.dart';
import 'package:xbox_launcher/shared/enums/xcloud_supported_servers.dart';

class ProfileModel {
  late int id;
  late String name;
  late String preferedServer;
  String? xcloudGamesJsonPath;
  String? profileImagePath;

  late ProfilePreviewElementsPreferences previewElementsPreferences;
  late AppsHistoric appsHistoric;
  late ProfileAppsGroups appsGroups;
  late BackgroundProfilePreferences backgroundPreferences;
  late ThemeProfilePreferences themePreferences;
  late VideoPreferences videoPreferences;

  ProfileModel();
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    ProfileModel profileModel = ProfileModel();
    profileModel.id = json["id"];
    profileModel.name = json["name"];
    profileModel.preferedServer = json["preferedServer"];
    profileModel.xcloudGamesJsonPath = json["xcloudGamesJsonPath"];
    profileModel.profileImagePath = json["profileImagePath"];
    profileModel.previewElementsPreferences =
        ProfilePreviewElementsPreferences.fromJson(
            json["previewElementsPreferences"]);
    profileModel.appsHistoric = AppsHistoric.fromJson(json["appsHistoric"]);
    profileModel.appsGroups = ProfileAppsGroups.fromJson(json["appsGroups"]);
    profileModel.backgroundPreferences =
        BackgroundProfilePreferences.fromJson(json["backgroundPreferences"]);
    profileModel.themePreferences =
        ThemeProfilePreferences.fromJson(json["themePreferences"]);
    profileModel.videoPreferences =
        VideoPreferences.fromJson(json["videoPreferences"]);

    return profileModel;
  }
  factory ProfileModel.createDefault() {
    ProfileModel defaultProfile = ProfileModel();
    defaultProfile.id = 0;
    defaultProfile.name = AppConsts.DEFAULT_USERNAME;
    defaultProfile.preferedServer =
        XCloudSupportedServers.values[0].countryCode;

    defaultProfile.previewElementsPreferences =
        ProfilePreviewElementsPreferences();
    defaultProfile.appsHistoric = AppsHistoric();
    defaultProfile.appsGroups =
        ProfileAppsGroups(groups: List.empty(growable: true));
    defaultProfile.backgroundPreferences =
        BackgroundProfilePreferences(0, null);
    defaultProfile.themePreferences = ThemeProfilePreferences(0);
    defaultProfile.videoPreferences = VideoPreferences(true);

    return defaultProfile;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "preferedServer": preferedServer,
        "xcloudGamesJsonPath": xcloudGamesJsonPath,
        "profileImagePath": profileImagePath,
        "previewElementsPreferences": previewElementsPreferences.toJson(),
        "appsHistoric": appsHistoric.toJson(),
        "appsGroups": appsGroups.toJson(),
        "backgroundPreferences": backgroundPreferences.toJson(),
        "themePreferences": themePreferences.toJson(),
        "videoPreferences": videoPreferences.toJson()
      };
}
