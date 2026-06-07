import 'dart:typed_data';

class SelectableAppItem {
  const SelectableAppItem({
    required this.id,
    required this.name,
    required this.category,
    this.icon,
    this.iconBytes,
  });

  final String id;
  final String name;
  final String category;
  final String? icon;
  final Uint8List? iconBytes;

  factory SelectableAppItem.fromInstalledApp({
    required String packageName,
    required String name,
    required String category,
    Uint8List? iconBytes,
  }) {
    return SelectableAppItem(
      id: packageName,
      name: name,
      category: category,
      iconBytes: iconBytes,
    );
  }
}
