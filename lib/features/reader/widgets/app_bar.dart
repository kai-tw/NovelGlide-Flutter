part of '../reader.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const CommonBackButton(),
      title: BlocBuilder<ReaderCubit, ReaderState>(
        buildWhen: (ReaderState previous, ReaderState current) =>
            previous.bookName != current.bookName,
        builder: (BuildContext context, ReaderState state) {
          return Text(state.bookName);
        },
      ),
      actions: const <Widget>[
        SearchButton(),
      ],
    );
  }
}
