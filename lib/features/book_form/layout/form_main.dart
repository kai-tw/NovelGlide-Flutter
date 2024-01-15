import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/form_bloc.dart';
import 'form_components/input_book_name.dart';
import 'form_components/submit_buttons.dart';

class BookFormWidget extends StatelessWidget {
  const BookFormWidget({super.key, this.oldName, this.selectedBooks});

  final String? oldName;
  final Set<String>? selectedBooks;

  @override
  Widget build(BuildContext context) {
    const double paddingHorizontal = 40.0;
    return Form(
      child: BlocBuilder<BookFormCubit, BookFormState>(
        builder: (context, state) {
          List<Widget> sliverList = [];
          BookFormType formType = BlocProvider.of<BookFormCubit>(context).formType;

          switch (formType) {
            case BookFormType.add:
              sliverList += _addForm(context);
              break;
            case BookFormType.edit:
              sliverList += _editForm(context);
              break;
            case BookFormType.multiEdit:
              sliverList += _multiEditForm(context);
              break;
          }

          /// Submit button
          sliverList.add(const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
            sliver: SliverToBoxAdapter(
              child: BookFormSubmitButton(),
            ),
          ));

          return CustomScrollView(slivers: sliverList);
        },
      ),
    );
  }

  String? nameStateToString(BuildContext context, BookFormNameState? state) {
    final localization = AppLocalizations.of(context);
    switch (state) {
      case BookFormNameState.blank:
        return localization!.input_field_blank;
      case BookFormNameState.invalid:
        return localization!.input_field_invalid;
      case BookFormNameState.exists:
        return localization!.book_exists;
      case BookFormNameState.same:
        return localization!.book_name_same;
      default:
        return null;
    }
  }

  /// Add form.
  List<Widget> _addForm(BuildContext context) {
    List<Widget> sliverList = [];
    AppLocalizations? localization = AppLocalizations.of(context);
    BookFormCubit cubit = BlocProvider.of<BookFormCubit>(context);
    BookFormState state = cubit.state;

    // New name input field.
    sliverList.add(SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
      sliver: SliverToBoxAdapter(
        child: BookFormInputBookName(
          labelText: localization!.book_name,
          validator: (_) => nameStateToString(context, state.newNameState),
          onChanged: (value) => cubit.newNameVerify(state, value),
        ),
      ),
    ));

    return sliverList;
  }

  /// Edit form.
  List<Widget> _editForm(BuildContext context) {
    List<Widget> sliverList = [];
    AppLocalizations? localization = AppLocalizations.of(context);
    BookFormCubit cubit = BlocProvider.of<BookFormCubit>(context);
    BookFormState state = cubit.state;

    // Send the old name to the cubit.
    cubit.data.oldName = oldName!;

    // Old name text box.
    sliverList.add(SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
      sliver: SliverToBoxAdapter(
        child: BookFormInputBookName(
          labelText: localization!.original_book_name,
          initialValue: oldName,
          readOnly: true,
          isShowHelp: false,
        ),
      ),
    ));

    // Arrow downward icon.
    sliverList.add(const SliverToBoxAdapter(child: Icon(Icons.arrow_downward_rounded)));

    // New name text field.
    sliverList.add(SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
      sliver: SliverToBoxAdapter(
        child: BookFormInputBookName(
          labelText: localization.book_name,
          validator: (_) => nameStateToString(context, state.newNameState),
          onChanged: (value) => cubit.newNameVerify(state, value),
        ),
      ),
    ));

    return sliverList;
  }

  /// Multi-Edit form.
  List<Widget> _multiEditForm(BuildContext context) {
    List<Widget> sliverList = [];
    AppLocalizations? localization = AppLocalizations.of(context);
    BookFormCubit cubit = BlocProvider.of<BookFormCubit>(context);
    BookFormState state = cubit.state;

    // Send the selectedBooks to cubit.
    cubit.data.selectedBooks = selectedBooks!;

    /// Multi-Edit pattern input field
    sliverList.add(SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
      sliver: SliverToBoxAdapter(
        child: BookFormInputBookName(
          labelText: localization!.replace_pattern,
          onChanged: (value) => cubit.patternVerify(state, value),
          validator: (_) => nameStateToString(context, state.patternState),
        ),
      ),
    ));

    /// Arrow downward icon.
    sliverList.add(const SliverToBoxAdapter(child: Icon(Icons.arrow_downward_rounded)));

    /// New name text field.
    sliverList.add(SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
      sliver: SliverToBoxAdapter(
        child: BookFormInputBookName(
          labelText: localization.replace_with,
          validator: (_) => nameStateToString(context, state.newNameState),
          onChanged: (value) => cubit.newNameVerify(state, value),
        ),
      ),
    ));

    /// Preview box
    sliverList.add(SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(localization.preview),
              Text(state.namePreview ?? cubit.getNamePreview()),
            ],
          ),
        ),
      ),
    ));

    return sliverList;
  }
}
