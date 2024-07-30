import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_components/common_back_button.dart';
import '../common_components/common_loading.dart';
import 'bloc/store_bloc.dart';
import 'store_subscription_list.dart';
import 'widgets/store_unavailable_text.dart';

class StoreScaffold extends StatelessWidget {
  const StoreScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreCubit()..init(),
      child: const _StoreScaffold(),
    );
  }
}

class _StoreScaffold extends StatelessWidget {
  const _StoreScaffold();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButton(),
          title: Text(AppLocalizations.of(context)!.titleStore),
          bottom: TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context)!.storeSubscriptionsPlan),
            ],
          ),
        ),
        body: BlocBuilder<StoreCubit, StoreState>(
          buildWhen: (previous, current) => previous.errorCode != current.errorCode,
          builder: (context, state) {
            switch (state.errorCode) {
              case StoreErrorCode.normal:
                return const TabBarView(
                  children: [
                    StoreSubscriptionList(),
                  ],
                );

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
