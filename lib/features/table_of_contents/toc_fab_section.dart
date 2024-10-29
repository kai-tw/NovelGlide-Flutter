import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../enum/window_class.dart';
import '../../utils/route_utils.dart';
import '../reader/reader.dart';
import 'bloc/toc_bloc.dart';

class TocFabSection extends StatelessWidget {
  const TocFabSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TocCubit cubit = BlocProvider.of<TocCubit>(context);
    final WindowClass windowClass =
        WindowClass.fromWidth(MediaQuery.of(context).size.width);
    double maxWidth =
        MediaQuery.of(context).size.width - kFloatingActionButtonMargin;

    if (windowClass != WindowClass.compact) {
      maxWidth *= 0.618;
    }

    return Container(
      padding: const EdgeInsets.only(left: kFloatingActionButtonMargin),
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: BlocBuilder<TocCubit, TocState>(
        builder: (BuildContext context, TocState state) {
          List<Widget> children = [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(RouteUtils.pushRoute(
                      ReaderWidget(
                        bookPath: cubit.bookData.filePath,
                        bookData: cubit.bookData,
                      ),
                    ))
                    .then((_) => cubit.refresh());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                fixedSize: const Size.fromHeight(56.0),
                elevation: 5.0,
              ),
              icon: const Icon(Icons.menu_book_rounded),
              label: Text(AppLocalizations.of(context)!.tocStartReading),
            )
          ];

          if (state.bookmarkData != null) {
            children.add(Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(RouteUtils.pushRoute(
                        ReaderWidget(
                          bookPath: cubit.bookData.filePath,
                          bookData: cubit.bookData,
                          isGotoBookmark: true,
                        ),
                      ))
                      .then((_) => cubit.refresh());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  fixedSize: const Size.fromHeight(56.0),
                  elevation: 5.0,
                ),
                icon: const Icon(Icons.bookmark_rounded),
                label: Text(AppLocalizations.of(context)!.tocContinueReading),
              ),
            ));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
