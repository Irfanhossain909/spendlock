import 'dart:typed_data';

import 'package:installed_apps/app_info.dart';

class InstalledAppModel {
  const InstalledAppModel({
    required this.packageName,
    required this.name,
    required this.categoryLabel,
    this.iconBytes,
  });

  final String packageName;
  final String name;
  final String categoryLabel;
  final Uint8List? iconBytes;

  factory InstalledAppModel.fromAppInfo(AppInfo info) {
    return InstalledAppModel(
      packageName: info.packageName,
      name: info.name,
      categoryLabel: info.category.name,
      iconBytes: info.icon,
    );
  }
}
