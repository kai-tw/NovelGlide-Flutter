import 'dart:async';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../../core/log_system/log_system.dart';
import '../../../main.dart';
import '../../mime_resolver/domain/repositories/mime_repository.dart';
import '../../services/exception_service/exception_service.dart';
import '../../utils/parsers.dart';

part 'google_auth_client.dart';
part 'google_auth_interface.dart';
part 'google_drive_interface.dart';

class GoogleApiInterfaces {
  GoogleApiInterfaces._();

  static final GoogleAuthInterface auth = GoogleAuthInterface();
  static final GoogleDriveInterface drive = GoogleDriveInterface();
}
