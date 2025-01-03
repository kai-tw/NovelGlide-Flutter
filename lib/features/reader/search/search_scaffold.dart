import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';

import '../../../enum/loading_state_code.dart';
import '../../../utils/route_utils.dart';
import '../../common_components/common_back_button.dart';
import '../../common_components/common_loading.dart';
import '../reader.dart';

part '../bloc/search_cubit.dart';
part 'search_button.dart';
part 'search_field.dart';
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
      body: Column(
        children: [
          const Expanded(
            child: _SearchResultList(),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: const SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SearchRangeSelector(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 24.0, 0.0, 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: _SearchField(),
                        ),
                        _SearchSubmitButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
