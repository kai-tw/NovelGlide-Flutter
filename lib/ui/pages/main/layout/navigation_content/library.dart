import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:novelglide/ui/components/centered_text.dart';
import 'package:novelglide/ui/components/emoticon_collection.dart';
import 'package:novelglide/ui/pages/main/bloc/library_book_list.dart';
import 'package:novelglide/ui/pages/main/layout/navigation_content/library_item.dart';

class MainPageLibraryWidget extends StatelessWidget {
  const MainPageLibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<LibraryBookListCubit, LibraryBookListState>(
          buildWhen: (_, currentState) {
            return currentState.isLoaded;
          },
          builder: (context, state) {
            if (!state.isLoaded) {
              BlocProvider.of<LibraryBookListCubit>(context).refresh();
              return CenteredText('${EmoticonCollection.getRandomShock()}\n${AppLocalizations.of(context)!.loading}');
            }
            if (state.bookList.isEmpty) {
              return CenteredText('${EmoticonCollection.getRandomShock()}\n${AppLocalizations.of(context)!.no_book}');
            }
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      return MainPageLibraryItem(state, state.bookList[i]);
                    },
                    childCount: state.bookList.length,
                  ),
                ),
              ],
            );
          },
        ));
  }
}
