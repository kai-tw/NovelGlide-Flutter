import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/main/bloc/librar_book_list.dart';
import 'package:novelglide/ui/pages/main/layout/main_page_library_book_list.dart';

class LibraryWidget extends StatelessWidget {
  const LibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
            create: (_) => LibraryBookListCubit(),
            child: const MainPageLibraryBookList()));
  }
}
