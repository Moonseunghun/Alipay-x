import 'package:dio/dio.dart';
import 'package:example_alipay/payment/data/alipay_payment_gatway.dart';
import 'package:example_alipay/payment/data/mock_payment_gatway.dart';
import 'package:example_alipay/payment/domain/payment_gateway.dart';
import 'package:example_alipay/payment/domain/payment_status.dart';
import 'package:riverpod/riverpod.dart';


const currentPaymentMode = PaymentMode.mock;

const baseUrl = 'a';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),

      headers: {
        'Content-type' : 'application/json',
      }
    )
  );
});

final paymentGatewayProvider = Provider<PaymentGateway>((ref) {
  switch (currentPaymentMode) {
    case PaymentMode.mock :
      return MockPaymentGatway();
    case PaymentMode.real :
      return AlipayPaymentGatway(ref.watch(dioProvider));
  }
});
