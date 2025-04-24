import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data_model/reader_settings_data.dart';
import '../../data_model/book_data.dart';
import '../../enum/window_class.dart';
import '../../generated/i18n/app_localizations.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_loading.dart';
import 'cubit/reader_cubit.dart';
import 'nav/navigation_bar.dart';
import 'nav/navigation_rail.dart';
import 'search/search_scaffold.dart';

part 'widgets/app_bar.dart';
part 'widgets/breadcrumb.dart';
part 'widgets/loading_widget.dart';
part 'widgets/overlap_widget.dart';
part 'widgets/pagination.dart';
part 'widgets/scaffold.dart';
part 'widgets/scaffold_body.dart';

class ReaderWidget extends StatelessWidget {
  const ReaderWidget({
    super.key,
    required this.bookPath,
    this.bookData,
    this.destinationType = ReaderDestinationType.none,
    this.destination,
  });

  final String bookPath;
  final BookData? bookData;
  final ReaderDestinationType destinationType;
  final String? destination;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReaderCubit>(
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
