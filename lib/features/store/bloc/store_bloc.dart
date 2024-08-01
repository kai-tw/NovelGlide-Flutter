import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCubit extends Cubit<StoreState> {
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  StoreCubit() : super(const StoreState());

  Future<void> init() async {
    if (!Platform.isAndroid) {
      emit(const StoreState(errorCode: StoreErrorCode.unavailable));
      return;
    }

    _subscription = InAppPurchase.instance.purchaseStream.listen(_purchaseSubscriptionHandler, onDone: () {
      _subscription!.cancel();
    }, onError: (error) {});

    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    emit(StoreState(errorCode: isAvailable ? StoreErrorCode.normal : StoreErrorCode.unavailable));
  }

  Future<void> refreshSubscriptions() async {
    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    if (!isAvailable) {
      return;
    }

    final Set<String> idSet = {"starter.monthly"};
    final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(idSet);
    final List<ProductDetails> purchaseDetailsList = response.productDetails;
    emit(state.copyWith(subscriptionList: purchaseDetailsList));
    InAppPurchase.instance.restorePurchases();
  }

  Future<void> planChanged(ProductDetails? productDetails) async {
    if (!Platform.isAndroid) {
      return;
    }

    if (state.activeSubscriptionId != productDetails?.id) {
      if (state.activeSubscriptionId == null) {
        // From the free plan to any paid plan
        final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails!);
        InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
      } else if (productDetails != null) {
        // Change the subscription plan
        final InAppPurchaseAndroidPlatformAddition platform =
            InAppPurchase.instance.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
        final QueryPurchaseDetailsResponse purchaseDetailsList = await platform.queryPastPurchases();

        final GooglePlayPurchaseDetails? activeSubscription = purchaseDetailsList.pastPurchases
            .firstWhereOrNull((element) => element.productID == state.activeSubscriptionId);

        if (activeSubscription != null) {
          PurchaseParam purchaseParam = GooglePlayPurchaseParam(
            productDetails: productDetails,
            changeSubscriptionParam: ChangeSubscriptionParam(
              oldPurchaseDetails: activeSubscription,
            ),
          );
          InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
        }
      } else {
        launchUrl(Uri.parse("https://play.google.com/store/account/subscriptions"));
      }
    }
  }

  void _purchaseSubscriptionHandler(List<PurchaseDetails> purchaseDetailsList) {
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          emit(state.copyWith(activeSubscriptionId: purchaseDetails.productID));
          InAppPurchase.instance.completePurchase(purchaseDetails);
          break;
        default:
      }
    }
  }

  @override
  Future<void> close() async {
    super.close();

    if (_subscription != null) {
      _subscription!.cancel();
    }
  }
}

class StoreState extends Equatable {
  final StoreErrorCode errorCode;
  final List<ProductDetails> subscriptionList;
  final String? activeSubscriptionId;

  @override
  List<Object?> get props => [errorCode, subscriptionList, activeSubscriptionId];

  const StoreState({
    this.errorCode = StoreErrorCode.loading,
    this.subscriptionList = const [],
    this.activeSubscriptionId,
  });

  StoreState copyWith({
    StoreErrorCode? errorCode,
    List<ProductDetails>? subscriptionList,
    String? activeSubscriptionId,
  }) {
    return StoreState(
      errorCode: errorCode ?? this.errorCode,
      subscriptionList: subscriptionList ?? this.subscriptionList,
      activeSubscriptionId: activeSubscriptionId ?? this.activeSubscriptionId,
    );
  }
}

enum StoreErrorCode {
  loading,
  unavailable,
  normal,
}
