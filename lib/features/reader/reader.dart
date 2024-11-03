import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data_model/bookmark_data.dart';
import '../../../data_model/reader_settings_data.dart';
import '../../../enum/common_button_state_code.dart';
import '../../../repository/bookmark_repository.dart';
import '../../../utils/book_utils.dart';
import '../../../utils/css_utils.dart';
import '../../../utils/epub_utils.dart';
import '../../../utils/file_path.dart';
import '../../data_model/book_data.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/window_class.dart';
import '../../utils/route_utils.dart';
import '../ads/advertisement.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_loading.dart';

part 'bloc/cubit.dart';
part 'bloc/gesture_handler.dart';
part 'bloc/lifecycle_handler.dart';
part 'bloc/search_cubit.dart';
part 'bloc/server_handler.dart';
part 'bloc/state.dart';
part 'bloc/web_view_handler.dart';
part 'nav/add_button.dart';
part 'nav/jump_button.dart';
part 'nav/navigation.dart';
part 'nav/next_button.dart';
part 'nav/previous_button.dart';
part 'nav/settings_button.dart';
part 'search/search_button.dart';
part 'search/search_field.dart';
part 'search/search_range_selector.dart';
part 'search/search_result_list.dart';
part 'search/search_scaffold.dart';
part 'search/search_submit_button.dart';
part 'settings/bottom_sheet.dart';
part 'settings/settings_card.dart';
part 'settings/settings_reset_button.dart';
part 'settings/slider/settings_font_size_slider.dart';
part 'settings/slider/settings_line_height_slider.dart';
part 'settings/slider/settings_slider.dart';
part 'settings/switcher/settings_auto_save_switch.dart';
part 'settings/switcher/settings_gesture_switcher.dart';
part 'widgets/app_bar.dart';
part 'widgets/gesture_detector.dart';
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
      create: (_) => _ReaderCubit(
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
