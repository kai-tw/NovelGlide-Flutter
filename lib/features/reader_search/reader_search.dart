import 'package:flutter/material.dart';

import '../common_components/common_back_button.dart';
import 'reader_search_field.dart';
import 'reader_search_range_selector.dart';
import 'reader_search_result_list.dart';
import 'reader_search_submit_btn.dart';

class ReaderSearch extends StatelessWidget {
  const ReaderSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
      ),
      body: const ReaderSearchResultList(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: const SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReaderSearchRangeSelector(),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 24.0, 0.0, 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ReaderSearchField(),
                    ),
                    ReaderSearchSubmitBtn(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
