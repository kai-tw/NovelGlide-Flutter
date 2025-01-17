import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data_model/bookmark_data.dart';
import '../../../data_model/reader_settings_data.dart';
import '../../../enum/common_button_state_code.dart';
import '../../../repository/bookmark_repository.dart';
import '../../../utils/css_utils.dart';
import '../../data_model/book_data.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/window_class.dart';
import '../../repository/book_repository.dart';
import '../../repository/cache_repository.dart';
import '../../utils/int_utils.dart';
import '../ads/advertisement.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_loading.dart';
import 'search/search_scaffold.dart';
import 'settings/reader_bottom_sheet.dart';

part 'bloc/cubit.dart';
part 'bloc/gesture_handler.dart';
part 'bloc/lifecycle_handler.dart';
part 'bloc/server_handler.dart';
part 'bloc/state.dart';
part 'bloc/web_view_handler.dart';
part 'nav/add_button.dart';
part 'nav/jump_button.dart';
part 'nav/navigation.dart';
part 'nav/next_button.dart';
part 'nav/previous_button.dart';
part 'nav/settings_button.dart';
part 'widgets/app_bar.dart';
part 'widgets/breadcrumb.dart';
part 'widgets/overlap_widget.dart';
part 'widgets/pagination.dart';
part 'widgets/scaffold.dart';
part 'widgets/scaffold_body.dart';

class ReaderWidget extends StatelessWidget {
  final String bookPath;
  final BookData? bookData;
  final String? gotoDestination;
  final bool isGotoBookmark;

  const ReaderWidget({
    super.key,
    this.isGotoBookmark = false,
    this.gotoDestination,
    this.bookData,
    required this.bookPath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReaderCubit(
        bookData: bookData,
        bookPath: bookPath,
        currentTheme: Theme.of(context),
        destination: gotoDestination,
        isGotoBookmark: isGotoBookmark,
      ),
      child: const _Scaffold(),
    );
  }
}
