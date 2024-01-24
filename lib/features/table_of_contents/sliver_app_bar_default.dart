import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../edit_book/scaffold.dart';
import 'bloc/toc_bloc.dart';

class TOCSliverAppBar extends StatelessWidget {
  const TOCSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    TOCCubit cubit = BlocProvider.of<TOCCubit>(context);
    return SliverAppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add_rounded),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              scrollControlDisabledMaxHeightRatio: 1.0,
              showDragHandle: true,
              builder: (BuildContext context) {
                return EditBookPage(cubit.bookObject);
              },
            ).then((isSuccess) {
              if (isSuccess != null && isSuccess) {
                cubit.refresh();
              }
            });
          },
          icon: const Icon(Icons.edit_rounded),
        ),
      ],
    );
  }

}