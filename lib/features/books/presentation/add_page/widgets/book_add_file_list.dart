import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../../../domain/entities/book_pick_file_data.dart';
import '../cubit/book_add_cubit.dart';
import '../cubit/book_add_state.dart';
import 'book_add_file_tile.dart';

class BookAddFileList extends StatelessWidget {
  const BookAddFileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: BlocBuilder<BookAddCubit, BookAddState>(
        buildWhen: (BookAddState previous, BookAddState current) =>
            previous.fileSet != current.fileSet,
        builder: _stateBuilder,
      ),
    );
  }

  Widget _stateBuilder(BuildContext context, BookAddState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (state.fileSet.isEmpty) {
      return Center(
        child: Text(appLocalizations.addBookEmpty),
      );
    } else {
      return ListView.builder(
        itemCount: state.fileSet.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(context, index, state);
        },
      );
    }
  }

  Widget _buildListItem(BuildContext context, int index, BookAddState state) {
    final BookAddCubit cubit = BlocProvider.of<BookAddCubit>(context);
    final BookPickFileData itemState = state.fileSet.elementAt(index);
    return BookAddFileTile(
      data: itemState,
      onDeletePressed: () => cubit.removeFile(itemState),
    );
  }
}
