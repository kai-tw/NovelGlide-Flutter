import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/book_object.dart';
import 'bloc/form_bloc.dart';

class AddBookSliverImagePicker extends StatelessWidget {
  const AddBookSliverImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final BookObject data = BlocProvider.of<AddBookFormCubit>(context).data;
    return BlocBuilder<AddBookFormCubit, AddBookFormState>(
      builder: (BuildContext context, AddBookFormState state) {
        return SliverToBoxAdapter(
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
        );
      }
    );
  }

}