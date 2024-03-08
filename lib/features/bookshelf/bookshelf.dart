import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bookshelf_bloc.dart';
import 'bookshelf_scaffold.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookshelfCubit(),
      child: const BookshelfScaffold(),
    );
  }
}
