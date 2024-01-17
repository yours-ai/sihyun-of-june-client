import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final oneLinkProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

final deepLinkProvider = StateProvider<DeepLink?>((ref) => null);
