import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enum/loading_state_code.dart';
import '../../../../enum/window_size.dart';
import '../../../../generated/i18n/app_localizations.dart';
import '../../../shared_components/common_error_widgets/common_error_widget.dart';
import '../../../shared_components/common_loading_widgets/common_loading_widget.dart';
import '../../../shared_components/shared_bottom_container.dart';
import '../../domain/entities/reader_search_result_data.dart';
import 'cubit/reader_search_cubit.dart';

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
          child: const Column(
            children: <Widget>[
              Expanded(
                child: _SearchResultList(),
              ),
              SharedBottomContainer(
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
            ],
          ),
        ),
      ),
    );
  }
}
