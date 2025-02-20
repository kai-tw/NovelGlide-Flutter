import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data_model/reader_settings_data.dart';
import '../../../enum/common_button_state_code.dart';
import '../../data_model/book_data.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/window_class.dart';
import '../ads/advertisement.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_loading.dart';
import 'bloc/reader_cubit.dart';
import 'bloc/reader_destination_type.dart';
import 'bloc/reader_state.dart';
import 'search/search_scaffold.dart';
import 'settings/reader_bottom_sheet.dart';

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
  final ReaderDestinationType destinationType;
  final String? destination;

  const ReaderWidget({
    super.key,
    required this.bookPath,
    this.bookData,
    this.destinationType = ReaderDestinationType.none,
    this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReaderCubit(
        bookData: bookData,
        bookPath: bookPath,
        currentTheme: Theme.of(context),
      )..initAsync(
          destinationType: destinationType,
          destination: destination,
        ),
      child: const _Scaffold(),
    );
  }
}
