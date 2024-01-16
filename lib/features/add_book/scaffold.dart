import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'bloc/form_bloc.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddBookFormCubit(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.25,
        maxChildSize: 1.0,
        expand: false,
        snap: true,
        snapSizes: const [0.6],
        builder: (BuildContext context, ScrollController controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: BlocBuilder<AddBookFormCubit, AddBookFormState>(
                builder: (BuildContext context, AddBookFormState state) {
                  return CustomScrollView(
                    controller: controller,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Text(
                          AppLocalizations.of(context)!.title_add_book,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
                      SliverToBoxAdapter(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.book_name,
                            labelStyle: const TextStyle(fontSize: 16),
                            contentPadding: const EdgeInsets.all(24.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: IconButton(
                                onPressed: () => _showHelpDialog(context),
                                icon: const Icon(Icons.help_outline_rounded),
                              ),
                            ),
                          ),
                          onChanged: (String value) {
                            BlocProvider.of<AddBookFormCubit>(context).nameVerify(value);
                          },
                          validator: (_) => _nameStateCodeToMessage(context, state.nameStateCode),
                        ),
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 20.0)),
                      SliverToBoxAdapter(
                        child: FormField(builder: (FormFieldState state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.book_cover +
                                  AppLocalizations.of(context)!.input_optional,
                              labelStyle: const TextStyle(fontSize: 16),
                              contentPadding: const EdgeInsets.all(24.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: TextButton.icon(
                              onPressed: () {
                                BlocProvider.of<AddBookFormCubit>(context).pickCoverImage();
                              },
                              icon: const Icon(Icons.image_rounded),
                              label: Text(AppLocalizations.of(context)!.select_image),
                            ),
                          );
                        }),
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 16.0)),
                      SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              backgroundColor: Theme.of(context).colorScheme.primary,
                            ),
                            icon: const Icon(Icons.send_rounded),
                            label: Text(
                              AppLocalizations.of(context)!.submit,
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                debugPrint('Verification passed.');
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<T?> _showHelpDialog<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.book_name_rule_title),
          content: Text('${AppLocalizations.of(context)!.book_name_rule_content}_ -.,&()@#\$%^+=[{]};\'~`<>?| 和空白'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.close),
            ),
          ],
        );
      },
    );
  }

  String? _nameStateCodeToMessage(BuildContext context, AddBookNameStateCode code) {
    switch (code) {
      case AddBookNameStateCode.blank:
        return AppLocalizations.of(context)!.input_field_blank;
      case AddBookNameStateCode.invalid:
        return AppLocalizations.of(context)!.input_field_invalid;
      case AddBookNameStateCode.exists:
        return AppLocalizations.of(context)!.book_exists;
      case AddBookNameStateCode.valid:
        return null;
    }
  }
}
