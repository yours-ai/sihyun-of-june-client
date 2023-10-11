import 'dart:async';
import 'dart:io';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/product_widget.dart';

import '../actions/auth/queries.dart';
import '../actions/transaction/actions.dart';
import '../constants.dart';
import '../services/transaction_service.dart';

const List<String> _kProductIds = <String>[
  'purchase_50_coins',
  'purchase_100_coins'
];

class MyCoinScreen extends StatefulWidget {
  const MyCoinScreen({Key? key}) : super(key: key);

  @override
  State<MyCoinScreen> createState() => _MyCoinScreenState();
}

class _MyCoinScreenState extends State<MyCoinScreen> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StoreInfoDTO _storeInfoDTO = StoreInfoDTO();
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  var transactionService = TransactionService();

  Future<void> _updateStoreInfo() async {
    await initStoreInfo(_kProductIds, _inAppPurchase, _storeInfoDTO);
  }

  Future<void> handlePastTransactions() async{
    var transactions = await SKPaymentQueueWrapper().transactions();
    transactions.forEach((SKPaymentTransactionWrapper) {
      SKPaymentQueueWrapper().finishTransaction(SKPaymentTransactionWrapper);
    });
  }

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    });
    _updateStoreInfo();
    handlePastTransactions();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      transactionService.purchaseUpdatedListener(
          context, purchaseDetails, _inAppPurchase);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Container(
            padding: const EdgeInsets.only(left: 23),
            child: Icon(
              PhosphorIcons.arrow_left,
              color: ColorConstants.black,
              size: 32,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: QueryBuilder(
          query: getRetrieveMeQuery(),
          builder: (context, state) {
            return state.data == null
                ? const SizedBox.shrink()
                : TitleLayout(
                    withAppBar: true,
                    titleText: '내 코인',
                    titleAddOn: Row(
                      children: [
                        Text(state.data!.coin.toString(),
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Icon(
                          PhosphorIcons.coin_vertical,
                          color: ColorConstants.black,
                          size: 32,
                        ),
                      ],
                    ),
                    body: Column(
                      children: [
                        const SizedBox(height: 16),
                        ProductWidget(
                            products: _storeInfoDTO.products,
                            inAppPurchase: _inAppPurchase,
                            kProductIds: _kProductIds),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
