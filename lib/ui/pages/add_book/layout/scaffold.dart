import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/pages/add_book/bloc/form_bloc.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? bookName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _bodyWidget());
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(AppLocalizations.of(context)!.add_book_title)));
  }

  Widget _bodyWidget() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: BlocProvider(
                    create: (_) => AddBookFormCubit(),
                    child: Column(
                      children: [
                        _bookNameInput(),
                        const SizedBox(height: 24),
                        _submitButton()
                      ],
                    )))));
  }

  Widget _bookNameInput() {
    return BlocBuilder<AddBookFormCubit, AddBookFormState>(
        builder: (context, state) {
      return TextFormField(
          onSaved: (String? value) {
            bookName = value;
          },
          onChanged: (value) => BlocProvider.of<AddBookFormCubit>(context)
              .bookNameVerify(state, value),
          validator: (_) {
            switch (state.bookNameErrorCode) {
              case AddBookFormBookNameErrorCode.nothing:
                return null;
              case AddBookFormBookNameErrorCode.blank:
                return AppLocalizations.of(context)!.add_book_book_name_blank;
              case AddBookFormBookNameErrorCode.invalid:
                return AppLocalizations.of(context)!.add_book_book_name_invalid;
              case AddBookFormBookNameErrorCode.exists:
                return AppLocalizations.of(context)!.add_book_book_exists;
            }
          },
          decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.add_book_book_name,
              labelStyle: const TextStyle(fontSize: 16),
              contentPadding: const EdgeInsets.all(24.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))));
    });
  }

  Widget _submitButton() {
    return SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
            onPressed: _submitButtonPressed,
            style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary),
            child: Text(AppLocalizations.of(context)!.form_submit,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary))));
  }

  void _submitButtonPressed() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }
}
