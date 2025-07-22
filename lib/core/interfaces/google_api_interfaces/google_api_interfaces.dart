import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../exceptions.dart';
import '../../services/log_service.dart';
import '../../services/mime_resolver.dart';
import '../../utils/parsers.dart';

part 'google_auth_client.dart';
part 'google_auth_interface.dart';
part 'google_drive_interface.dart';

class GoogleApiInterfaces {
  GoogleApiInterfaces._();

  static final GoogleAuthInterface auth = GoogleAuthInterface();
  static final GoogleDriveInterface drive = GoogleDriveInterface();
}
