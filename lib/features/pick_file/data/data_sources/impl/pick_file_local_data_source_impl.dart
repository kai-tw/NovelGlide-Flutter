import 'package:file_picker/file_picker.dart';

import '../pick_file_local_data_source.dart';

class PickFileLocalDataSourceImpl implements PickFileLocalDataSource {
  final Set<String> _selectedFileNameSet = <String>{};

  @override
  Future<void> clearTemporaryFiles() {
    return FilePicker.platform.clearTemporaryFiles();
  }

  @override
  Future<Set<String>> pickFiles({
    required List<String> allowedExtensions,
    bool isAllowedDuplicated = false,
  }) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      allowMultiple: true,
    );

    final Set<String> retSet = <String>{};
    final List<PlatformFile> fileList = result?.files ?? <PlatformFile>[];

    // TODO(kai): editing.
    for (PlatformFile file in fileList) {
      if (file.path != null) {
        if (_selectedFileNameSet
            .any((String fileName) => fileName == file.name)) {
          // If the file is already in the list, ignore it!
        } else {
          retSet.add(file.path!);
        }
      }
    }

    return retSet;
  }
}
