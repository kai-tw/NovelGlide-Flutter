import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/book_data.dart';
import '../../data_model/bookmark_data.dart';
import '../../data_model/chapter_data.dart';
import '../../enum/loading_state_code.dart';
import '../../enum/window_class.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../repository/bookmark_repository.dart';
import '../../utils/route_utils.dart';
import '../collection_add_book/collection_add_book_scaffold.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_book_cover_image.dart';
import '../common_components/common_list_empty.dart';
import '../common_components/common_loading.dart';
import '../reader/cubit/reader_cubit.dart';
import '../reader/reader.dart';

part 'bloc/cubit.dart';
part 'view/compact_view.dart';
part 'view/medium_view.dart';
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
    final windowWidth = MediaQuery.of(context).size.width;
    final windowClass = WindowClass.fromWidth(windowWidth);
    Widget body;

    switch (windowClass) {
      case WindowClass.compact:
        body = _CompactView(bookData: bookData);
        break;

      default:
        body = _MediumView(bookData: bookData);
    }

    return BlocProvider(
      create: (_) => _Cubit(bookData)..init(),
      child: Scaffold(
        appBar: _AppBar(bookData: bookData),
        body: body,
        floatingActionButton: const _FabSection(),
      ),
    );
  }
}
