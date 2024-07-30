import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/store_bloc.dart';
import 'widgets/store_subscription_plan_widget.dart';

class StoreSubscriptionList extends StatelessWidget {
  const StoreSubscriptionList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StoreCubit>(context).refreshSubscriptions();
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<StoreCubit>(context).refreshSubscriptions(),
      child: CustomScrollView(
        slivers: [
          BlocBuilder<StoreCubit, StoreState>(
            buildWhen: (previous, current) => previous.subscriptionList != current.subscriptionList,
            builder: (context, state) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return StoreSubscriptionPlanWidget(
                      productDetails: index == 0 ? null : state.subscriptionList[index - 1],
                    );
                  },
                  childCount: state.subscriptionList.length + 1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
