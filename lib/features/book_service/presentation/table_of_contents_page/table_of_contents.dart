import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared_components/common_loading.dart';
import '../../../../core/shared_components/shared_list/shared_list.dart';
import '../../../../core/utils/route_utils.dart';
import '../../../../enum/loading_state_code.dart';
import '../../../../enum/window_size.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../bookmark/data/bookmark_data.dart';
import '../../../bookmark/data/bookmark_repository.dart';
import '../../../collection/presentation/add_book_page/collection_add_book_scaffold.dart';
import '../../../reader/presentation/reader_page/cubit/reader_cubit.dart';
import '../../../reader/presentation/reader_page/reader.dart';
import '../../book_service.dart';

part 'cubit/cubit.dart';
part 'views/compact_view.dart';
part 'views/medium_view.dart';
part 'widgets/app_bar.dart';
part 'widgets/book_name.dart';
part 'widgets/cover_banner.dart';
part 'widgets/fab_section.dart';
part 'widgets/sliver_list.dart';

class TableOfContents extends StatelessWidget {
  const TableOfContents(this.bookData, {super.key});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.sizeOf(context).width;
    final WindowSize windowClass = WindowSize.fromWidth(windowWidth);
    Widget body;

    switch (windowClass) {
      case WindowSize.compact:
        body = _CompactView(bookData: bookData);
        break;

      default:
        body = _MediumView(bookData: bookData);
    }

    return BlocProvider<_Cubit>(
      create: (_) => _Cubit(bookData)..init(),
      child: Scaffold(
        appBar: _AppBar(bookData: bookData),
        body: body,
        floatingActionButton: const _FabSection(),
      ),
    );
  }
}
