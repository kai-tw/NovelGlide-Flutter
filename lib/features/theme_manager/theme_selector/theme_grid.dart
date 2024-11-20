part of '../theme_manager.dart';

class _ThemeGrid extends StatelessWidget {
  const _ThemeGrid();

  static const double _maxAxisExtent = 100.0;
  static const double _maxCrossAxisExtent = 100.0;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ThemeManagerCubit>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final parentWidth = constraints.maxWidth;
        final crossAxisCount = parentWidth ~/ _maxCrossAxisExtent;
        final rowCount = (ThemeId.values.length / crossAxisCount).ceil();
        return SizedBox(
          height: min<double>(200, rowCount * _maxAxisExtent),
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
      },
    );
  }
}
