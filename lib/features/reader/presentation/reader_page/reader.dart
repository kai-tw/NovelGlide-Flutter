import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../generated/i18n/app_localizations.dart';
import '../../../../enum/window_size.dart';
import '../../../../features/shared_components/common_loading.dart';
import '../../../../main.dart';
import '../../../ads_service/domain/entities/ad_unit_id.dart';
import '../../../ads_service/presentation/advertisement.dart';
import '../../../books/domain/entities/book.dart';
import '../../../tts_service/tts_service.dart';
import '../../domain/entities/reader_destination_type.dart';
import '../../domain/entities/reader_navigation_state_code.dart';
import '../../domain/entities/reader_page_num_type.dart';
import '../search_page/search_scaffold.dart';
import '../settings_bottom_sheet/reader_bottom_sheet.dart';
import 'cubit/reader_cubit.dart';

part 'widgets/nav/default/reader_nav_bookmark_button.dart';
part 'widgets/nav/default/reader_nav_next_button.dart';
part 'widgets/nav/default/reader_nav_previous_button.dart';
part 'widgets/nav/default/reader_nav_settings_button.dart';
part 'widgets/nav/default/reader_nav_tts_button.dart';
part 'widgets/nav/navigation_bar.dart';
part 'widgets/nav/navigation_rail.dart';
part 'widgets/nav/tts/reader_tts_close_button.dart';
part 'widgets/nav/tts/reader_tts_play_pause_button.dart';
part 'widgets/nav/tts/reader_tts_settings_button.dart';
part 'widgets/nav/tts/reader_tts_stop_button.dart';
part 'widgets/reader_app_bar.dart';
part 'widgets/reader_breadcrumb.dart';
part 'widgets/reader_loading_widget.dart';
part 'widgets/reader_overlap_widget.dart';
part 'widgets/reader_pagination.dart';
part 'widgets/reader_scaffold.dart';
part 'widgets/reader_scaffold_body.dart';

class ReaderWidget extends StatelessWidget {
  const ReaderWidget({
    super.key,
    required this.bookIdentifier,
    this.bookData,
    this.destinationType = ReaderDestinationType.none,
    this.destination,
  });

  final String bookIdentifier;
  final Book? bookData;
  final ReaderDestinationType destinationType;
  final String? destination;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReaderCubit>(
      create: (_) => sl<ReaderCubit>()
        ..initAsync(
          bookData: bookData,
          bookIdentifier: bookIdentifier,
          currentTheme: Theme.of(context),
          destinationType: destinationType,
          destination: destination,
        ),
      child: const ReaderScaffold(),
    );
  }
}
