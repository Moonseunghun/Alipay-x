import 'package:example_alipay/payment/domain/payment_models.dart';
import 'package:example_alipay/payment/presentation/payment_providers.dart';
import 'package:riverpod/legacy.dart';
import 'package:riverpod/riverpod.dart';

import '../domain/payment_status.dart';

sealed class PaymentState {
  const PaymentState();
}

class PaymentIdle extends PaymentState {
  const PaymentIdle();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentReady extends PaymentState {
  final PaymentStartResponse response;

  PaymentReady(this.response);
}

class PaymentSuccess extends PaymentState {
  final String orderId;

  const PaymentSuccess(this.orderId);
}

class PaymentFailure extends PaymentState {
  final String message;

  PaymentFailure(this.message);
}

final paymentControllerProvider = StateNotifierProvider<
    PaymentController,
    PaymentState>((ref) {
  return PaymentController(ref);
});

class PaymentController extends StateNotifier<PaymentState> {
  final Ref ref;

  PaymentController(this.ref) : super(const PaymentIdle());

  Future<void> startPayment({
    required String merchantOrderId,
    required int amount,
    required String currency,
    required String title,
  }) async {
    state = const PaymentLoading();

    try {
      final gateway = ref.read(paymentGatewayProvider);

      final result = await gateway.createPayment(
          PaymentModels(
              merchantOrderId: merchantOrderId, amount: amount, currency: currency, title: title
          )
      );
      print(result);
      state = PaymentReady(result);
    } catch (e) {
      state = PaymentFailure('실패: $e');
    }
  }

  Future<void> refreshStatus(String orderId) async {
    try{
      final gateway = ref.read(paymentGatewayProvider);
      final status = await gateway.getPaymentStatus(orderId);

      switch (status) {
        case PaymentStatus.success:
          state = PaymentSuccess(orderId);
          break;
        case PaymentStatus.failed:
          state = PaymentFailure('결제 실패');
          break;
        case PaymentStatus.cancelled:
          state = PaymentFailure('결제 취소');
          break;
        case PaymentStatus.pending:
          state = PaymentFailure('결제 대기 중');
          break;
      }
    }catch (e) {
      state = PaymentFailure('결제 조회 실패 $e');
    }
  }
}
