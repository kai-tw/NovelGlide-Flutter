import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../toolbox/emoticon_collection.dart';
import '../common_components/common_back_button.dart';
import '../common_components/common_loading.dart';
import 'bloc/store_bloc.dart';
import 'widgets/store_unavailable_text.dart';

class StoreScaffold extends StatelessWidget {
  const StoreScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit()..init(),
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(AppLocalizations.of(context)!.titleStore),
        ),
        body: BlocBuilder<StoreCubit, StoreState>(
          builder: (context, state) {
            switch (state.errorCode) {
              case StoreErrorCode.normal:
                return const Center(child: Text("Normal"));

              case StoreErrorCode.loading:
                return const Center(child: CommonLoading());

              default:
                return const StoreUnavailableText();
            }
          },
        ),
      ),
    );
  }
}
