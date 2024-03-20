import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/book_object.dart';
import 'bloc/toc_bloc.dart';
import 'toc_scaffold.dart';

class TableOfContents extends StatelessWidget {
  const TableOfContents(this.bookObject, {super.key});

  final BookObject bookObject;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TOCCubit(bookObject),
      child: const TOCScaffold(),
    );
  }
}
