import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

import '../pick_book_data_source.dart';

class PickBookDataSourceImpl extends PickBookDataSource {
  @override
  Future<Set<String>> pickFiles({
    required List<String> allowedExtensions,
    required Set<String> selectedFileName,
  }) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      allowMultiple: true,
    );

    final Set<String> retSet = Set<String>.from(selectedFileName);
    final List<PlatformFile> fileList = result?.files ?? <PlatformFile>[];

    for (PlatformFile file in fileList) {
      if (file.path != null) {
        if (selectedFileName
            .any((String fileName) => fileName == basename(file.path!))) {
          // If the file is already in the list, ignore it!
        } else {
          retSet.add(file.path!);
        }
      }
    }

    return retSet;
  }

  @override
  Future<void> clearTemporaryFiles() {
    return FilePicker.platform.clearTemporaryFiles();
  }
}
