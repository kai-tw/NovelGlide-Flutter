import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/components/emoticon_collection.dart';
import 'package:novelglide/ui/pages/main/bloc/library_book_list.dart';
import 'package:path/path.dart';

class LibraryWidget extends StatelessWidget {
  const LibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
            create: (_) => LibraryBookListCubit(),
            child: BlocBuilder<LibraryBookListCubit, LibraryBookListState>(
              buildWhen: (_, currentState) {return currentState.isLoaded;},
              builder: (context, state) {
                if (!state.isLoaded) {
                  BlocProvider.of<LibraryBookListCubit>(context).refresh();
                  return Center(
                      child: Text('${EmoticonCollection.getRandomShock()}\n${AppLocalizations.of(context)!.loading}',
                          textAlign: TextAlign.center));
                }
                if (state.bookList.isEmpty) {
                  return Center(
                      child: Text('${EmoticonCollection.getRandomShock()}\n${AppLocalizations.of(context)!.no_book}',
                          textAlign: TextAlign.center));
                }
                return ListView(children: state.bookList.map((item) => Text(basename(item.path))).toList());
              },
            )));
  }
}
