import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/ui/pages/chapter_list/bloc/chapter_list_bloc.dart';
import 'package:novelglide/ui/pages/chapter_list/layout/chapter_app_bar.dart';

class ChapterList extends StatelessWidget {
  const ChapterList({super.key, required this.bookName});

  final String bookName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ChapterListCubit(),
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              ChapterListAppBar(bookName),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return TextButton(
                      style: const ButtonStyle(),
                      onPressed: () {},
                      child: Text(
                        (index + 1).toString(),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                  childCount: 100,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
