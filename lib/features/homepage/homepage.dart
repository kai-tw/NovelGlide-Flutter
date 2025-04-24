import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_model/book_data.dart';
import '../../data_model/bookmark_data.dart';
import '../../data_model/collection_data.dart';
import '../../enum/window_class.dart';
import '../../generated/i18n/app_localizations.dart';
import '../book_add/book_add_dialog.dart';
import '../bookmark_list/bookmark_list.dart';
import '../bookmark_list/cubit/cubit.dart';
import '../bookshelf/bookshelf.dart';
import '../bookshelf/cubit/bookshelf_cubit.dart';
import '../collection_add/collection_add_dialog.dart';
import '../collection_list/collection_list.dart';
import '../collection_list/cubit/cubit.dart';
import '../common_components/common_delete_drag_target.dart';
import '../common_components/common_list/list_template.dart';
import '../settings_page/settings_page.dart';

part 'bloc/cubit.dart';
part 'view/compact_view.dart';
part 'view/medium_view.dart';
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
        BlocProvider<BookshelfCubit>(create: (_) => BookshelfCubit()),
        BlocProvider<CollectionListCubit>(create: (_) => CollectionListCubit()),
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final WindowClass windowClass = WindowClass.fromWidth(screenWidth);

    /// Display the homepage based on the window size
    switch (windowClass) {
      case WindowClass.compact:
        return const _CompactView();

      default:
        return const _MediumView();
    }
  }
}
