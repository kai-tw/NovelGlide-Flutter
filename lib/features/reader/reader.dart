import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/book_data.dart';
import 'bloc/reader_cubit.dart';
import 'reader_scaffold.dart';

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
      create: (_) => ReaderCubit(
        bookData: bookData,
        bookPath: bookPath,
      )..initialize(dest: gotoDestination, isGotoBookmark: isGotoBookmark),
      child: const ReaderScaffold(),
    );
  }
}
