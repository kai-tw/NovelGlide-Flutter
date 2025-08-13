import 'package:file_picker/file_picker.dart';

import '../pick_file_local_data_source.dart';

class PickFileLocalDataSourceImpl implements PickFileLocalDataSource {
  @override
  Future<void> clearTemporaryFiles() {
    return FilePicker.platform.clearTemporaryFiles();
  }

  @override
  Future<Set<String>> pickFiles({
    required List<String> allowedExtensions,
  }) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      allowMultiple: true,
    );

    final Set<String> retSet = <String>{};
    final List<PlatformFile> fileList = result?.files ?? <PlatformFile>[];

    for (PlatformFile file in fileList) {
      if (file.path != null) {
        retSet.add(file.path!);
      }
    }

    return retSet;
  }
}
