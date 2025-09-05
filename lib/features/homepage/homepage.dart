import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enum/window_size.dart';
import '../../features/shared_components/common_delete_drag_target.dart';
import '../../features/shared_components/shared_list/shared_list.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../main.dart';
import '../advertisement/domain/entities/ad_unit_id.dart';
import '../advertisement/presentation/advertisement.dart';
import '../bookmark/domain/entities/bookmark_data.dart';
import '../bookmark/presentation/bookmark_list/bookmark_list_app_bar.dart';
import '../bookmark/presentation/bookmark_list/bookmark_list_scaffold_body.dart';
import '../bookmark/presentation/bookmark_list/cubit/bookmark_list_cubit.dart';
import '../books/domain/entities/book.dart';
import '../books/presentation/add_page/book_add_page.dart';
import '../books/presentation/book_list/book_list_app_bar.dart';
import '../books/presentation/book_list/book_list_scroll_view.dart';
import '../books/presentation/book_list/cubit/bookshelf_cubit.dart';
import '../collection/domain/entities/collection_data.dart';
import '../collection/presentation/add_dialog/collection_add_dialog.dart';
import '../collection/presentation/collection_list/collection_list_app_bar.dart';
import '../collection/presentation/collection_list/collection_list_scaffold_body.dart';
import '../collection/presentation/collection_list/cubit/collection_list_cubit.dart';
import '../settings_page/presentation/settings_app_bar.dart';
import '../settings_page/presentation/settings_page.dart';
import 'cubit/homepage_cubit.dart';

part 'homepage_app_bar.dart';
part 'view/homepage_compact_view.dart';
part 'view/homepage_medium_view.dart';
part 'widgets/app_bar.dart';
part 'widgets/delete_drag_target.dart';
part 'widgets/floating_action_button.dart';
part 'widgets/floating_action_widget.dart';
part 'widgets/navigation_bar.dart';
part 'widgets/navigation_rail.dart';
part 'widgets/scaffold_body.dart';

/// The homepage of the app
class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final WindowSize windowClass = WindowSize.of(context);

    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<HomepageCubit>(create: (_) => HomepageCubit()),
        BlocProvider<BookListCubit>(create: (_) => sl<BookListCubit>()),
        BlocProvider<CollectionListCubit>(
            create: (_) => sl<CollectionListCubit>()),
        BlocProvider<BookmarkListCubit>(create: (_) => sl<BookmarkListCubit>()),
      ],
      child: switch (windowClass) {
        WindowSize.compact => const HomepageCompactView(),
        _ => const HomepageMediumView(),
      },
    );
  }
}
