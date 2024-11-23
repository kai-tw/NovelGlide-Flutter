part of '../reader.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const CommonBackButton(),
      title: BlocBuilder<ReaderCubit, ReaderState>(
        buildWhen: (previous, current) => previous.bookName != current.bookName,
        builder: (BuildContext context, ReaderState state) {
          return Text(state.bookName);
        },
      ),
      actions: const [
        SearchButton(),
      ],
    );
  }
}
