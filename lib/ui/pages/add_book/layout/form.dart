import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/add_book/bloc/form_bloc.dart';
import 'package:novelglide/ui/pages/add_book/layout/form_components/input_book_name.dart';
import 'package:novelglide/ui/pages/add_book/layout/form_components/submit_buttons.dart';

class AddBookFormWidget extends StatelessWidget {
  AddBookFormWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const double paddingHorizontal = 40.0;
    return Form(
      key: _formKey,
      child: BlocProvider(
        create: (_) => AddBookFormCubit(),
        child: const CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
              sliver: SliverToBoxAdapter(
                child: AddBookInputBookName(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: paddingHorizontal),
              sliver: SliverToBoxAdapter(
                child: AddBookSubmitButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
