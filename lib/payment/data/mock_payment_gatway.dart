import 'package:example_alipay/payment/domain/payment_gateway.dart';
import 'package:example_alipay/payment/domain/payment_models.dart';
import 'package:example_alipay/payment/domain/payment_status.dart';

class MockPaymentGatway implements PaymentGateway {
  final Map<String, PaymentStatus> _statusStore = {};

  @override
  Future<PaymentStartResponse> createPayment(PaymentModels request) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final orderId = 'Mock_${DateTime
        .now()
        .millisecondsSinceEpoch}';

    _statusStore[orderId] = PaymentStatus.pending;

    return PaymentStartResponse(
        orderId: orderId,
        checkoutUrl: 'https://sssssssss.example.com/pay?orderId=$orderId',
        redirectSuccessUrl: '실제 앱 ',
        redirectFailUrl: '실패 했을때 표시 랜딩',
    );
  }

  @override
  Future<PaymentStatus> getPaymentStatus(String orderId) async {
   await  Future.delayed(const Duration(milliseconds: 300));

   return _statusStore[orderId] ?? PaymentStatus.pending;
  }

  void markSuccess(String orderId) {
    _statusStore[orderId] = PaymentStatus.success;
  }

  void markFailed(String orderId) {
    _statusStore[orderId] = PaymentStatus.failed;
  }

  void markCancelled(String orderId) {
    _statusStore[orderId] = PaymentStatus.cancelled;
  }
}