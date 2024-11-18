part of '../theme_manager.dart';

class _ThemeGrid extends StatelessWidget {
  const _ThemeGrid();

  static const double _maxAxisExtent = 100.0;
  static const double _maxCrossAxisExtent = 100.0;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ThemeManagerCubit>(context);
    final windowWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = windowWidth ~/ _maxCrossAxisExtent;

    return SizedBox(
      height: min<double>(200,
          (ThemeId.values.length / crossAxisCount).ceil() * _maxAxisExtent),
      child: CustomScrollView(
        controller: cubit.scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _ThemeSwitcher(
                  themeId: ThemeId.values[index],
                ),
                childCount: ThemeId.values.length,
              ),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                mainAxisExtent: _maxAxisExtent,
                maxCrossAxisExtent: _maxCrossAxisExtent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
