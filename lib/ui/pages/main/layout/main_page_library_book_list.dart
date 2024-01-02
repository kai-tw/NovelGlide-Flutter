import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/components/emoticon_collection.dart';
import 'package:novelglide/ui/pages/main/bloc/librar_book_list.dart';
import 'package:path/path.dart';

class MainPageLibraryBookList extends StatelessWidget {
  const MainPageLibraryBookList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LibraryBookListCubit, LibraryBookListState>(
      builder: (context, state) {
        if (state.bookList.isNotEmpty) {
          List<Widget> list = [];
          for (Directory item in state.bookList) {
            list.add(Text(basename(item.path)));
          }
          return ListView(children: list);
        } else {
          return Center(
              child: Text('${EmoticonCollection.getRandomShock()}\n${AppLocalizations.of(context)!.no_book}',
                  textAlign: TextAlign.center));
        }
      },
    );
  }

}