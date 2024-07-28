import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class StoreCubit extends Cubit<StoreState> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  StoreCubit() : super(const StoreState());

  void init() async {
    _subscription = InAppPurchase.instance.purchaseStream.listen((purchaseDetailsList) {
      print(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      print(error);
    });

    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    emit(StoreState(errorCode: isAvailable ? StoreErrorCode.normal : StoreErrorCode.unavailable));

    if (!isAvailable) {
      return;
    }

    print((await InAppPurchase.instance.queryProductDetails({"test_product"})).productDetails);
  }
}

class StoreState extends Equatable {
  final StoreErrorCode errorCode;

  @override
  List<Object?> get props => [errorCode];

  const StoreState({
    this.errorCode = StoreErrorCode.loading,
  });
}

enum StoreErrorCode {
  loading,
  unavailable,
  normal,
}
