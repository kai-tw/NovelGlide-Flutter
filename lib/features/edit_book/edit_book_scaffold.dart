import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/book_data.dart';
import '../common_components/common_back_button.dart';
import 'bloc/edit_book_form_bloc.dart';
import 'edit_book_form.dart';

class EditBookScaffold extends StatelessWidget {
  const EditBookScaffold({super.key, required this.bookData});

  final BookData bookData;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(AppLocalizations.of(context)!.titleEditBook),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocProvider(
            create: (_) => EditBookFormCubit(bookData),
            child: const EditBookForm(),
          ),
        ),
      ),
    );
  }
}
