import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/collection_data.dart';
import '../cubit/collection_add_book_cubit.dart';

class CollectionAddBookListItem extends StatelessWidget {
  const CollectionAddBookListItem({
    super.key,
    required this.data,
    this.isSelected,
  });

  final CollectionData data;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    final CollectionAddBookCubit cubit =
        BlocProvider.of<CollectionAddBookCubit>(context);

    return CheckboxListTile(
      contentPadding: const EdgeInsets.fromLTRB(16, 0.0, 8.0, 0.0),
      title: Text(data.name),
      secondary: const Icon(Icons.folder),
      tristate: true,
      value: isSelected,
      onChanged: (bool? value) {
        if (value == true) {
          cubit.select(data);
        } else {
          cubit.deselect(data);
        }
      },
    );
  }
}
