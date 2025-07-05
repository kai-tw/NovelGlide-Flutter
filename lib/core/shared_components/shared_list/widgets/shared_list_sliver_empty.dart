part of '../shared_list.dart';

class SharedListSliverEmpty extends StatelessWidget {
  const SharedListSliverEmpty({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: SharedListEmpty(title: title),
    );
  }
}
