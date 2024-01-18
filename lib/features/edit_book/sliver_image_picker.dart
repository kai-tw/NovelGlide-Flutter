import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../shared/book_process.dart';
import 'bloc/form_bloc.dart';

class EditBookSliverImagePicker extends StatelessWidget {
  const EditBookSliverImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    BookObject data = BlocProvider.of<EditBookFormCubit>(context).data;
    return SliverToBoxAdapter(
      child: FormField(builder: (FormFieldState state) {
        List<Widget> buttonList = [
          TextButton.icon(
            onPressed: () {
              BlocProvider.of<EditBookFormCubit>(context).pickCoverImage();
            },
            icon: const Icon(Icons.image_rounded),
            label: Text(AppLocalizations.of(context)!.select_image),
          )
        ];

        if (data.coverFile != null && data.coverFile!.existsSync()) {
          buttonList.add(TextButton.icon(
            onPressed: () {
              BlocProvider.of<EditBookFormCubit>(context).removeCoverImage();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            icon: const Icon(Icons.delete_outline_outlined),
            label: Text(AppLocalizations.of(context)!.remove_image),
          ));
        }

        return BlocBuilder<EditBookFormCubit, EditBookFormState>(
          builder: (BuildContext context, EditBookFormState state) {
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
                    child: state.formValue.getCover(),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 16.0)),
                  Expanded(
                    child: Column(children: buttonList),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}