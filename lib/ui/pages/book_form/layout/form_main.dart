import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/book_form/bloc/form_bloc.dart';
import 'package:novelglide/ui/pages/book_form/layout/form_components/input_book_name.dart';
import 'package:novelglide/ui/pages/book_form/layout/form_components/submit_buttons.dart';

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
          String newNameLabelText = AppLocalizations.of(context)!.book_name;
          BookFormType formType = BlocProvider.of<BookFormCubit>(context).formType;

          switch (formType) {
            case BookFormType.edit:
              newNameLabelText = AppLocalizations.of(context)!.new_book_name;

              if (oldName != null) {
                BlocProvider.of<BookFormCubit>(context).data.oldName = oldName!;
              }

              /// Old name read-only text field
              sliverList.add(SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
                sliver: SliverToBoxAdapter(
                  child: BookFormInputBookName(
                    labelText: AppLocalizations.of(context)!.original_book_name,
                    initialValue: oldName,
                    isShowHelp: false,
                    readOnly: true,
                    onChanged: (value) => BlocProvider.of<BookFormCubit>(context).oldNameVerify(state, value),
                  ),
                ),
              ));
              sliverList.add(const SliverToBoxAdapter(child: Icon(Icons.arrow_downward_rounded)));
              break;
            case BookFormType.multiEdit:
              newNameLabelText = AppLocalizations.of(context)!.replace_with;

              if (selectedBooks != null) {
                BlocProvider.of<BookFormCubit>(context).data.selectedBooks = selectedBooks!;
              }

              // Multi-Edit pattern input field
              sliverList.add(SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
                sliver: SliverToBoxAdapter(
                  child: BookFormInputBookName(
                    labelText: AppLocalizations.of(context)!.replace_pattern,
                    onChanged: (value) => BlocProvider.of<BookFormCubit>(context).oldNameVerify(state, value),
                    validator: (_) => nameStateToString(context, state.oldNameState),
                  ),
                ),
              ));
              sliverList.add(const SliverToBoxAdapter(child: Icon(Icons.arrow_downward_rounded)));
              break;
            default:
          }

          /// New book name input field
          sliverList.add(SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
            sliver: SliverToBoxAdapter(
              child: BookFormInputBookName(
                labelText: newNameLabelText,
                validator: (_) => nameStateToString(context, state.newNameState),
                onChanged: (value) => BlocProvider.of<BookFormCubit>(context).newNameVerify(state, value),
              ),
            ),
          ));

          /// Preview box
          if (formType == BookFormType.multiEdit) {
            final String namePreview = state.namePreview ?? BlocProvider.of<BookFormCubit>(context).getNamePreview();

            sliverList.add(SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.outline),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.preview),
                      Text(namePreview),
                    ],
                  ),
                ),
              ),
            ));
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
      case null:
        return localization!.book_name_blank;
      case BookFormNameState.invalid:
        return localization!.book_name_invalid;
      case BookFormNameState.exists:
        return localization!.book_exists;
      case BookFormNameState.same:
        return localization!.book_name_same;
      case BookFormNameState.nothing:
        return null;
    }
  }
}
