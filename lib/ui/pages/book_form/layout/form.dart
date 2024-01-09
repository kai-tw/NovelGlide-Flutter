import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/book_form/bloc/form_bloc.dart';
import 'package:novelglide/ui/pages/book_form/layout/form_components/input_book_name.dart';
import 'package:novelglide/ui/pages/book_form/layout/form_components/submit_buttons.dart';

class BookFormWidget extends StatelessWidget {
  const BookFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const double paddingHorizontal = 40.0;
    return BlocProvider(
      create: (_) => BookFormCubit(),
      child: Form(
        child: BlocBuilder<BookFormCubit, BookFormState>(
          builder: (context, state) {
            List<Widget> sliverList = [];

            switch (state.formType) {
              case BookFormType.edit:
                sliverList.add(const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
                  sliver: SliverToBoxAdapter(
                    child: Text('old name'),
                  ),
                ));
                break;
              case BookFormType.multiEdit:
              // Multi-Edit pattern input field
                sliverList.add(SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
                  sliver: SliverToBoxAdapter(
                    child: BookFormInputBookName(
                      labelText: AppLocalizations.of(context)!.book_name,
                    ),
                  ),
                ));
                break;
              default:
            }

            // New book name input field
            sliverList.add(SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
              sliver: SliverToBoxAdapter(
                child: BookFormInputBookName(
                  labelText: AppLocalizations.of(context)!.book_name,
                  validator: (_) => nameStateToString(context, state.newNameState),
                  onChanged: (value) => BlocProvider.of<BookFormCubit>(context).nameVerify(state, value),
                  onSave: (value) => BlocProvider.of<BookFormCubit>(context).data.save(newBookName: value),
                ),
              ),
            ));

            // Submit button
            sliverList.add(const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
              sliver: SliverToBoxAdapter(
                child: BookFormSubmitButton(),
              ),
            ));

            return CustomScrollView(slivers: sliverList);
          },
        ),
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
      case BookFormNameState.nothing:
        return null;
    }
  }
}
