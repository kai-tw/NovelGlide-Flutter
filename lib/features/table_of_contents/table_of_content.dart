import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/book_data.dart';
import 'bloc/toc_bloc.dart';
import 'toc_scaffold.dart';

class TableOfContents extends StatelessWidget {
  const TableOfContents(this.bookObject, {super.key});

  final BookData bookObject;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TocCubit(bookObject)..refresh(),
      child: const TocScaffold(),
    );
  }
}
