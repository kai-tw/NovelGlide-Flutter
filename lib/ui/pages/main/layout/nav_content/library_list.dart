import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:novelglide/ui/components/centered_text.dart';
import 'package:novelglide/ui/components/emoticon_collection.dart';
import 'package:novelglide/ui/pages/main/bloc/library_bloc.dart';
import 'package:novelglide/ui/pages/main/layout/nav_content/library_item.dart';

class MainPageLibraryWidget extends StatelessWidget {
  const MainPageLibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BlocBuilder<LibraryBookListCubit, LibraryBookListState>(
        builder: (context, state) {
          switch (state.code) {
            case LibraryBookListStateCode.unload:
              BlocProvider.of<LibraryBookListCubit>(context).refresh();
              return CenteredText('${EmoticonCollection.getRandomShock()}\n${AppLocalizations.of(context)!.loading}');

            case LibraryBookListStateCode.noBook:
              return CenteredText('${EmoticonCollection.getRandomShock()}\n${AppLocalizations.of(context)!.empty}');

            default:
              return SlidableAutoCloseBehavior(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          return MainPageLibraryItem(state.bookList[i]);
                        },
                        childCount: state.bookList.length,
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
