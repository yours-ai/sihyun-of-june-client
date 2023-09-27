import '../client.dart';

Future<void> appleTransactionVerify(String serverVerificationData) async {
  await dio.post('/transaction/apple/transaction/', data: {
    'signedPayload': serverVerificationData,
  });
  return;
}

Future<void> googleTransactionVerify(String serverVerificationData) async {
  await dio.post('/transaction/google/transaction/', data: {
    'product_id': serverVerificationData,
    'token': serverVerificationData,
  });
  return;
}
