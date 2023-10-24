import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:new_version_plus/new_version_plus.dart';

import '../widgets/update_widget.dart';

class UpdateService {
  const UpdateService();

  Future<void> updateAndroidApp() async {
    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.startFlexibleUpdate();
        await InAppUpdate.completeFlexibleUpdate();
      }
    } catch (e) {
      (BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
    }
  }

  Future<void> updateIOSApp(BuildContext context) async {
    try {
      final newVersionPlus = await NewVersionPlus(
          iOSId: 'team.pygmalion.projectJune',
          androidId: 'team.pygmalion.project_june_client');
      final status = await newVersionPlus.getVersionStatus();
      if (status != null && status!.canUpdate == true) {
        await showModalBottomSheet(
            context: context,
            builder: (BuildContext context) =>
                UpdateWidget(releaseNotes: status.releaseNotes));
      }
    } catch (e) {
      (BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
    }
  }
}
