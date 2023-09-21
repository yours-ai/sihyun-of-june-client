import '../client.dart';
import 'models/CoinLog.dart';

Future<List<CoinLog>> fetchCoinLogs() async {
  final response = await dio.get('/transaction/coin/logs/');
  return (response.data as List).map((e) => CoinLog.fromJson(e)).toList();
}

Future<void> purchaseCoin(CoinLog) async {
  await dio.post('/transaction/coin/purchase/');
  return;
}


