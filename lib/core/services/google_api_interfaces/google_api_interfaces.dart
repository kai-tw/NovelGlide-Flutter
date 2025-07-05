import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../exceptions.dart';
import '../../utils/int_utils.dart';
import '../log_service.dart';
import '../mime_resolver.dart';

part 'google_auth_client.dart';
part 'google_auth_interface.dart';
part 'google_drive_interface.dart';

class GoogleApiInterfaces {
  GoogleApiInterfaces._();

  static final GoogleAuthInterface auth = GoogleAuthInterface._();
  static final GoogleDriveInterface drive = GoogleDriveInterface._();

  static Future<void> ensureInitialized() async {
    await Future.wait(<Future<void>>[
      auth.ensureInitialized(),
    ]);
  }
}
