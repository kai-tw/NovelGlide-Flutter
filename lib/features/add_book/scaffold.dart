import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../shared/book_process.dart';
import 'bloc/form_bloc.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AddBookFormCubit()),
      ],
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
                  final BookObject data = BlocProvider.of<AddBookFormCubit>(context).data;
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
                                onPressed: () => showDialog(context: context, builder: _helpDialog),
                                icon: const Icon(Icons.help_outline_rounded),
                              ),
                            ),
                          ),
                          initialValue: data.name,
                          onChanged: (String value) {
                            BlocProvider.of<AddBookFormCubit>(context).nameVerify(value);
                          },
                          validator: (_) => _nameStateCodeToMessage(context, state.nameStateCode),
                        ),
                      ),
                      const SliverPadding(padding: EdgeInsets.only(bottom: 20.0)),
                      SliverToBoxAdapter(
                        child: FormField(builder: (FormFieldState state) {
                          List<Widget> buttonList = [
                            TextButton.icon(
                              onPressed: () {
                                BlocProvider.of<AddBookFormCubit>(context).pickCoverImage();
                              },
                              icon: const Icon(Icons.image_rounded),
                              label: Text(AppLocalizations.of(context)!.select_image),
                            )
                          ];

                          if (data.coverFile != null) {
                            buttonList.add(TextButton.icon(
                              onPressed: () {
                                BlocProvider.of<AddBookFormCubit>(context).removeCoverImage();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Theme.of(context).colorScheme.error,
                              ),
                              icon: const Icon(Icons.delete_outline_outlined),
                              label: Text(AppLocalizations.of(context)!.remove_image),
                            ));
                          }

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
                            child: Row(
                              children: [
                                Container(
                                  width: 100 / 1.5,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surfaceVariant,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: data.getCover(),
                                ),
                                const Padding(padding: EdgeInsets.only(right: 16.0)),
                                Expanded(
                                  child: Column(children: buttonList),
                                ),
                              ],
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
                                showDialog(context: context, barrierDismissible: false, builder: _processingDialog);
                                BlocProvider.of<AddBookFormCubit>(context).submit().then((bool isSuccess) {
                                  Navigator.of(context).pop();
                                  showDialog(context: context, builder: isSuccess ? _successDialog : _failedDialog)
                                      .then((_) => Navigator.of(context).pop());
                                });
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

  AlertDialog _helpDialog(BuildContext context) {
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
  }

  AlertDialog _processingDialog(BuildContext context) {
    return AlertDialog(
      icon: LoadingAnimationWidget.beat(
        color: Theme.of(context).colorScheme.secondary,
        size: 40.0,
      ),
      content: Text(
        AppLocalizations.of(context)!.processing,
        textAlign: TextAlign.center,
      ),
    );
  }

  AlertDialog _successDialog(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.check_rounded, size: 40.0),
      iconColor: Theme.of(context).colorScheme.secondary,
      content: Text(
        AppLocalizations.of(context)!.add_successful,
        textAlign: TextAlign.center,
      ),
    );
  }

  AlertDialog _failedDialog(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.error_outline_rounded, size: 40.0),
      iconColor: Theme.of(context).colorScheme.error,
      content: Text(
        AppLocalizations.of(context)!.add_failed,
        textAlign: TextAlign.center,
      ),
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
