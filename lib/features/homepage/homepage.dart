import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enum/window_size.dart';
import '../../features/shared_components/common_delete_drag_target.dart';
import '../../features/shared_components/shared_list/shared_list.dart';
import '../../generated/i18n/app_localizations.dart';
import '../../main.dart';
import '../ads_service/ad_service.dart';
import '../bookmark_service/bookmark_service.dart';
import '../books/book_service.dart';
import '../books/domain/entities/book.dart';
import '../books/presentation/add_page/book_add_page.dart';
import '../books/presentation/bookshelf/cubit/bookshelf_cubit.dart';
import '../collection/collection_service.dart';
import '../collection/domain/entities/collection_data.dart';
import '../collection/presentation/collection_list/cubit/collection_list_cubit.dart';
import '../settings_page/settings_service.dart';
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
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<HomepageCubit>(create: (_) => HomepageCubit()),
        BlocProvider<BookshelfCubit>(create: (_) => sl<BookshelfCubit>()),
        BlocProvider<CollectionListCubit>(
            create: (_) => sl<CollectionListCubit>()),
        BlocProvider<BookmarkListCubit>(create: (_) => BookmarkListCubit()),
      ],
      child: const _Scaffold(),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final WindowSize windowClass = WindowSize.fromWidth(screenWidth);

    /// Display the homepage based on the window size
    switch (windowClass) {
      case WindowSize.compact:
        return const HomepageCompactView();

      default:
        return const HomepageMediumView();
    }
  }
}
