import 'dart:async';
import 'dart:io';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/product_widget.dart';

import '../actions/auth/queries.dart';
import '../constants.dart';
import '../services/transaction_service.dart';

const String _kConsumableId = 'purchase_50_coins';
const List<String> _kProductIds = <String>[
  _kConsumableId,
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

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    Future<void> _updateStoreInfo() async {
      final updatedStoreInfoDTO = await transactionService.initStoreInfo(
          _kProductIds, _inAppPurchase, _storeInfoDTO);
      setState(() {
        _storeInfoDTO = updatedStoreInfoDTO;
      });
    }

    _updateStoreInfo();
    super.initState();
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(
      (PurchaseDetails purchaseDetails) async {
        if (purchaseDetails.status == PurchaseStatus.pending) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                '잠시만 기다려주세요...',
              ),
            ),
          );
        } else {
          if (purchaseDetails.status == PurchaseStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  '결제 도중 에러가 발생했어요. 에러가 계속되면 고객센터로 문의주세요.',
                ),
              ),
            );
          } else if (purchaseDetails.status == PurchaseStatus.purchased ||
              purchaseDetails.status == PurchaseStatus.restored) {
            bool valid =
                await transactionService.verifyPurchase(purchaseDetails);
            if (valid) {
              print('valid'); // 서버에서 다 해줌.
            } else {
              print('invalid');
            }
          }
          if (purchaseDetails.pendingCompletePurchase) {
            await InAppPurchase.instance.completePurchase(purchaseDetails);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: QueryBuilder(
          query: getRetrieveMeQuery(),
          builder: (context, state) {
            return state.data == null
                ? const SizedBox.shrink()
                : TitleLayout(
                    titleText: '내 코인',
                    titleAddOn: Row(
                      children: [
                        Text(state.data!.coin.toString(),
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Icon(
                          PhosphorIcons.coin_vertical,
                          color: ColorConstants.black,
                          size: 32,
                        ),
                      ],
                    ),
                    body: Column(
                      children: [
                        SizedBox(height: 16),
                        ProductWidget(
                          products: _storeInfoDTO.products,
                          inAppPurchase: _inAppPurchase,
                          kConsumableId: _kConsumableId,
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
