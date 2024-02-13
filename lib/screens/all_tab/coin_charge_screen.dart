import 'dart:async';
import 'dart:io';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:project_june_client/actions/transaction/queries.dart';
import 'package:project_june_client/widgets/common/back_appbar.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/common/title_underline.dart';
import 'package:project_june_client/widgets/transaction/product_widget.dart';

import '../../actions/auth/queries.dart';
import '../../constants.dart';
import '../../services.dart';

class CoinChargeScreen extends StatefulWidget {
  const CoinChargeScreen({Key? key}) : super(key: key);

  @override
  State<CoinChargeScreen> createState() => _CoinChargeScreenState();
}

class _CoinChargeScreenState extends State<CoinChargeScreen> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  bool isProcessing = false;

  Future<void> handlePastTransactions() async {
    final transactions = await SKPaymentQueueWrapper().transactions();
    transactions.forEach(
      (SKPaymentTransactionWrapper) {
        SKPaymentQueueWrapper().finishTransaction(SKPaymentTransactionWrapper);
      },
    );
  }

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription.cancel();
      },
    );
    if (Platform.isIOS) handlePastTransactions();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(
      (PurchaseDetails purchaseDetails) async {
        setState(() {
          isProcessing = transactionService.purchaseUpdatedListener(
              context, purchaseDetails, InAppPurchase.instance);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbar(),
      body: SafeArea(
        child: QueryBuilder(
          query: fetchMeQuery(),
          builder: (context, state) {
            return state.data == null
                ? const SizedBox.shrink()
                : TitleLayout(
                    withAppBar: true,
                    title: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TitleUnderline(titleText: '충전하기'),
                              const SizedBox(height: 14),
                              Text(
                                '${transactionService.currencyFormatter.format(state.data!.coin)} 코인',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          QueryBuilder(
                            query: fetchStoreInfoQuery(),
                            builder: (context, state) {
                              if (state.status != QueryStatus.success ||
                                  state.data == null ||
                                  state.data!.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                );
                              }
                              return Column(
                                children: [
                                  if (isProcessing)
                                    ...[
                                      const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        '결제가 진행중이오니\n잠시만 기다려주세요.',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ].toList()
                                  else
                                    ...transactionService
                                        .productListFromJson(state.data!)
                                        .map((product) => ProductWidget(
                                              product: product,
                                              inAppPurchase:
                                                  InAppPurchase.instance,
                                              isProcessing: isProcessing,
                                            ))
                                        .toList()
                                ],
                              );
                            },
                          ),
                          ExpansionTile(
                            title: Text(
                              '코인 구매안내',
                              style: TextStyle(
                                  fontSize: 18, color: ColorConstants.primary),
                            ),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(28, 10, 28, 15),
                                child: Text(
                                  "• 구매한 코인은 유월의 시현이에서만 사용하실 수 있습니다.\n• 이벤트로 받은 무료 코인은 구매 취소 및 환불 대상이 아닙니다.\n• Google Play 결제로 구매한 코인은 구매 후 48시간 이내는 Google Play 고객센터를 통해 환불이 가능합니다.\n• Google Play 결제로 구매한 코인의 구매내역은 'Google Play 스토어 앱>계정>결제 및 정기 결제>예산 및 기록'에서도 확인하실 수 있습니다.\n• iOS앱에서 구매한 코인의 구매취소는 App Store의 정책 상 Apple 고객센터 를 통해서만 가능합니다.\n• iOS앱에서 구매한 코인 구매내역은 'iOS설정>계정' 또는 'iTunes> 계정>나의 계정보기> 구입내역' 메뉴에서도 확인 가능합니다.",
                                  style: TextStyle(
                                      height: 1.5,
                                      color: ColorConstants.primary),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
