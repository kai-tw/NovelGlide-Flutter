import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enum/loading_state_code.dart';
import '../../../enum/window_class.dart';
import '../../../generated/i18n/app_localizations.dart';
import '../../../utils/route_utils.dart';
import '../../common_components/common_back_button.dart';
import '../../common_components/common_loading.dart';
import '../cubit/reader_cubit.dart';

part 'search_button.dart';
part 'search_field.dart';
part 'search_item_operation_dialog.dart';
part 'search_range_selector.dart';
part 'search_result_list.dart';
part 'search_submit_button.dart';

class SearchScaffold extends StatelessWidget {
  const SearchScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommonBackButton(),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: WindowClass.compact.maxWidth),
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
