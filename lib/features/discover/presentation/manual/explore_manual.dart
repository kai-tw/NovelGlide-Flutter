import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/markdown.dart';

class ExploreManual extends StatelessWidget {
  const ExploreManual({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discovery Manual'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: MarkdownWidget(
            data: '# What\'s Discovery?\n\n'
                'The discovery system can help you to view catalogs on web, '
                'and download books directly into your bookshelf.',
          ),
        ),
      ),
    );
  }
}
