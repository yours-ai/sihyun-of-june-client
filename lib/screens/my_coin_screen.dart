import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:project_june_client/actions/transaction/dtos.dart';
import 'package:project_june_client/widgets/common/title_layout.dart';
import 'package:project_june_client/widgets/menu_widget.dart';
import 'package:project_june_client/widgets/product_widget.dart';

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
      var transactionService = TransactionService();
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
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print('pending');
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          print(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          // bool valid = await _verifyPurchase(purchaseDetails);
          // if (valid) {
          //   _deliverProduct(purchaseDetails);
          // } else {
          //   _handleInvalidPurchase(purchaseDetails);
          // }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TitleLayout(
          titleText: '내 코인',
          titleAddOn: Row(
            children: [
              Text('80'),
              Icon(
                PhosphorIcons.coin_vertical,
                color: ColorConstants.black,
                size: 32,
              ),
            ],
          ),
          body: Column(
            children: [
              MenuWidget(
                title: '1,100원',
                onPressed: () {},
                suffix: Row(
                  children: [
                    Text('10'),
                    Icon(
                      PhosphorIcons.coin_vertical,
                      color: ColorConstants.black,
                      size: 32,
                    ),
                  ],
                ),
              ),
              ProductWidget(
                products: _storeInfoDTO.products,
                inAppPurchase: _inAppPurchase,
                kConsumableId: _kConsumableId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
