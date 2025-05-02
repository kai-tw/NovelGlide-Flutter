import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../../../core/utils/file_utils.dart';
import '../../../../core/utils/mime_resolver.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../data/repository/book_repository.dart';
import 'cubit/book_add_cubit.dart';

part 'widgets/book_add_action_bar.dart';
part 'widgets/book_add_file_list.dart';
part 'widgets/book_add_file_tile.dart';
part 'widgets/book_add_helper_text.dart';

class BookAddPage extends StatelessWidget {
  const BookAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider<BookAddCubit>(
      create: (_) => BookAddCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(appLocalizations.addBookTitle),
        ),
        body: const BookAddFileList(),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child: const SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BookAddHelperText(),
                BookAddActionBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
