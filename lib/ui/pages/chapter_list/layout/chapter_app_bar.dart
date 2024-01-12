import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ChapterListAppBar extends StatelessWidget {
  const ChapterListAppBar(this.bookName, {super.key});

  final String bookName;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        bookName,
        style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      ),
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Image(
          image: _getBannerImage(),
          fit: BoxFit.cover,
        ),
        stretchModes: const [StretchMode.zoomBackground],
      ),
      stretch: true,
    );
  }

  AssetImage _getBannerImage() {
    final Brightness brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;
    return AssetImage(isDarkMode ? 'assets/images/chapter_banner_dark.jpg' : 'assets/images/chapter_banner_light.jpg');
  }
}