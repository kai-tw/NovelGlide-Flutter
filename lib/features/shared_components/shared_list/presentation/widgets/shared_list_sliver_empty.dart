part of '../../shared_list.dart';

class SharedListSliverEmpty extends SharedListEmpty {
  const SharedListSliverEmpty({super.key, super.title});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: super.build(context),
    );
  }
}
