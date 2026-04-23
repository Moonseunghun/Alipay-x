import 'package:example_alipay/payment/domain/payment_models.dart';
import 'package:example_alipay/payment/domain/payment_status.dart';

abstract class PaymentGateway {
  // url  받아옴
  Future<PaymentStartResponse> createPayment(PaymentModels request);
  Future<PaymentStatus> getPaymentStatus(String orderId);







}