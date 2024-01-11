import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class BookChapterList extends StatelessWidget {
  const BookChapterList({super.key, required this.bookName});

  final String bookName;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
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
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                child: Text('Item: $index'),
              );
            },
            childCount: 100,
          ),
        ),
      ],
    );
  }

  AssetImage _getBannerImage() {
    final Brightness brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;
    debugPrint('isDarkMode = $isDarkMode');
    return AssetImage(isDarkMode ? 'assets/images/chapter_banner_dark.jpg' : 'assets/images/chapter_banner_light.jpg');
  }
}
