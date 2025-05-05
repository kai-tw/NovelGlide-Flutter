import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/route_utils.dart';
import '../../../../enum/loading_state_code.dart';
import '../../../../enum/window_size.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../common_components/common_loading.dart';
import '../reader_page/cubit/reader_cubit.dart';
import 'cubit/reader_search_cubit.dart';

part 'widgets/search_button.dart';
part 'widgets/search_field.dart';
part 'widgets/search_item_operation_dialog.dart';
part 'widgets/search_range_selector.dart';
part 'widgets/search_result_list.dart';
part 'widgets/search_submit_button.dart';

class SearchScaffold extends StatelessWidget {
  const SearchScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.readerSearch),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: WindowSize.compact.maxWidth),
          child: Column(
            children: <Widget>[
              const Expanded(
                child: _SearchResultList(),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 0.0, 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _SearchField(),
                        ),
                        _SearchRangeSelector(),
                        _SearchSubmitButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
