import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../bloc/store_bloc.dart';

class StoreSubscriptionPlanWidget extends StatelessWidget {
  final ProductDetails? productDetails;

  const StoreSubscriptionPlanWidget({super.key, this.productDetails});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final String planTitle = productDetails?.title ?? appLocalizations.storeSubscriptionsFreePlan;
    final BorderRadius borderRadius = BorderRadius.circular(24.0);

    return BlocBuilder<StoreCubit, StoreState>(
      buildWhen: (previous, current) => previous.activeSubscriptionId != current.activeSubscriptionId,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: InkWell(
            onTap: () {
              BlocProvider.of<StoreCubit>(context).planChanged(productDetails);
            },
            borderRadius: borderRadius,
            child: Container(
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withOpacity(state.activeSubscriptionId == productDetails?.id ? 1 : 0.5),
                  width: 2.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    planTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${productDetails?.price ?? appLocalizations.storeSubscriptionsFreePrice} ${productDetails?.currencyCode ?? ""}",
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                TextSpan(
                                  text: productDetails != null ? " / ${appLocalizations.storePerMonth}" : "",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Checkbox(
                          value: state.activeSubscriptionId == productDetails?.id,
                          onChanged: (value) {
                            if (value == true) {
                              BlocProvider.of<StoreCubit>(context).planChanged(productDetails);
                            }
                          },
                          semanticLabel: planTitle,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    getPlanDescription(appLocalizations, productDetails),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String getPlanDescription(AppLocalizations appLocalizations, ProductDetails? productDetails) {
    switch (productDetails?.id) {
      case "starter.monthly":
        return appLocalizations.storeSubscriptionsStarterDescription;
      default:
        return appLocalizations.storeSubscriptionsFreeDescription;
    }
  }
}
