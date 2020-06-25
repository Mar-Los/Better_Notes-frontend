import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum FileObjectType { folder, file }

enum FileType { text, dictionary, list }

const Map<FileType, IconData> FILE_ICONS = {
  FileType.text: Icons.description,
  FileType.dictionary: Icons.vpn_key,
  FileType.list: Icons.format_list_bulleted
};

FileType getFileTypeFromString(String string) {
  return FileType.values.firstWhere((e) => describeEnum(e) == string);
}
