import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/i18n/app_localizations.dart';
import '../cubit/book_add_cubit.dart';
import '../cubit/book_add_item_state.dart';
import '../cubit/book_add_state.dart';
import 'book_add_file_tile.dart';

class BookAddFileList extends StatelessWidget {
  const BookAddFileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: BlocBuilder<BookAddCubit, BookAddState>(
        buildWhen: (BookAddState previous, BookAddState current) =>
            previous.itemState != current.itemState,
        builder: _stateBuilder,
      ),
    );
  }

  Widget _stateBuilder(BuildContext context, BookAddState state) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (state.itemState.isEmpty) {
      return Center(
        child: Text(appLocalizations.addBookEmpty),
      );
    } else {
      return ListView.builder(
        itemCount: state.itemState.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(context, index, state);
        },
      );
    }
  }

  Widget _buildListItem(BuildContext context, int index, BookAddState state) {
    final BookAddCubit cubit = BlocProvider.of<BookAddCubit>(context);
    final BookAddItemState itemState = state.itemState.elementAt(index);
    return BookAddFileTile(
      filePath: itemState.absolutePath,
      isDuplicated: itemState.existsInLibrary,
      isMimeValid: itemState.isTypeValid,
      baseName: itemState.baseName,
      lengthString: itemState.lengthString,
      isValid: itemState.isValid,
      onDeletePressed: () => cubit.removeFile(itemState),
    );
  }
}
