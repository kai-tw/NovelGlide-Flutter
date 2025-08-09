import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/window_size.dart';
import '../../../../main.dart';
import '../../domain/entities/book.dart';
import 'cubit/toc_cubit.dart';
import 'views/toc_compact_view.dart';
import 'views/toc_medium_view.dart';
import 'widgets/toc_app_bar.dart';
import 'widgets/toc_fab_section.dart';

class TableOfContents extends StatelessWidget {
  const TableOfContents(this.bookData, {super.key});

  final Book bookData;

  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.sizeOf(context).width;
    final WindowSize windowClass = WindowSize.fromWidth(windowWidth);
    Widget body;

    switch (windowClass) {
      case WindowSize.compact:
        body = TocCompactView(bookData: bookData);
        break;

      default:
        body = TocMediumView(bookData: bookData);
    }

    return BlocProvider<TocCubit>(
      create: (_) => sl<TocCubit>()..startLoading(bookData.identifier),
      child: Scaffold(
        appBar: TocAppBar(bookData: bookData),
        body: body,
        floatingActionButton: TocFabSection(bookData: bookData),
      ),
    );
  }
}
