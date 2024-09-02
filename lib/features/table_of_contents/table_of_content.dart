import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/book_data.dart';
import '../../data/window_class.dart';
import 'bloc/toc_bloc.dart';
import 'view/toc_scaffold_compact_view.dart';
import 'view/toc_scaffold_medium_view.dart';

class TableOfContents extends StatelessWidget {
  const TableOfContents(this.bookData, {super.key});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    final WindowClass windowClass = WindowClass.getClassByWidth(MediaQuery.of(context).size.width);
    Widget scaffold;

    switch (windowClass) {
      case WindowClass.compact:
        scaffold = TocScaffoldCompactView(bookData: bookData);
        break;

      default:
        scaffold = TocScaffoldMediumView(bookData: bookData);
    }

    return BlocProvider(
      create: (_) => TocCubit(bookData)..refresh(),
      child: scaffold,
    );
  }
}
