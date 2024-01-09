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
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
                  sliver: SliverToBoxAdapter(
                    child: BookFormInputBookName(
                      labelText: AppLocalizations.of(context)!.book_name,
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
                  sliver: SliverToBoxAdapter(
                    child: BookFormSubmitButton(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
