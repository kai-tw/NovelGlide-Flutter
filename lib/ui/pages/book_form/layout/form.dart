import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/book_form/bloc/form_bloc.dart';
import 'package:novelglide/ui/pages/book_form/layout/form_components/input_book_name.dart';
import 'package:novelglide/ui/pages/book_form/layout/form_components/submit_buttons.dart';

class BookFormWidget extends StatelessWidget {
  BookFormWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const double paddingHorizontal = 40.0;
    return Form(
      key: _formKey,
      child: BlocProvider(
        create: (_) => BookFormCubit(),
        child: const CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
              sliver: SliverToBoxAdapter(
                child: BookFormInputBookName(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
              sliver: SliverToBoxAdapter(
                child: BookFormSubmitButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
