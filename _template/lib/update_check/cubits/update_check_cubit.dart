import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_upgrade_version/flutter_upgrade_version.dart';
import 'package:url_launcher/url_launcher.dart';
import '../update_check.dart';

class UpdateCheckCubit extends Cubit<UpdateCheckState> {
  UpdateCheckCubit() : super(const UpdateCheckState.init());

  Future<void> check() async {
    emit(const UpdateCheckState.loading());
    final packageInfo = await PackageManager.getPackageInfo();

    if (Platform.isAndroid) {
      InAppUpdateManager manager = InAppUpdateManager();
      AppUpdateInfo? appUpdateInfo = await manager.checkForUpdate();
      if (appUpdateInfo == null || appUpdateInfo.updateAvailability == UpdateAvailability.updateNotAvailable) {
        return emit(UpdateCheckState.lastest("${packageInfo.version}+${packageInfo.buildNumber}"));
      }
      emit(UpdateCheckState.old("${packageInfo.version}+${packageInfo.buildNumber}", appUpdateInfo.availableVersionCode.toString()));
    } else if (Platform.isIOS) {
      VersionInfo? versionInfo = await UpgradeVersion.getiOSStoreVersion(packageInfo: packageInfo);
      if (versionInfo.canUpdate) {
        emit(UpdateCheckState.old("${versionInfo.localVersion}+${packageInfo.buildNumber}", versionInfo.storeVersion));
        await launchUrl(Uri.parse(versionInfo.appStoreLink));
      } else {
        emit(UpdateCheckState.lastest("${packageInfo.version}+${packageInfo.buildNumber}"));
      }
    }
  }

  Future<void> update() async {
    if (Platform.isAndroid) {
      InAppUpdateManager manager = InAppUpdateManager();
      String? message = await manager.startAnUpdate(type: AppUpdateType.flexible);
      log(message ?? "");
    } else if (Platform.isIOS) {
      final packageInfo = await PackageManager.getPackageInfo();
      VersionInfo? versionInfo = await UpgradeVersion.getiOSStoreVersion(packageInfo: packageInfo);
      await launchUrl(Uri.parse(versionInfo.appStoreLink));
    }
  }
}
