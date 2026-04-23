class PaymentModels {
  final String merchantOrderId;
  final int amount;
  final String currency;
  final String title;

  PaymentModels({
    required this.merchantOrderId,
    required this.amount,
    required this.currency,
    required this.title,
  });

  Map<String, dynamic> toJson() =>
      {
        'merchantOrderId': merchantOrderId,
        'amount': amount,
        'currency': currency,
        'title': title,
      };
}

class PaymentStartResponse {
  final String orderId;
  final String checkoutUrl;
  final String redirectSuccessUrl;
  final String redirectFailUrl;

  PaymentStartResponse({
    required this.orderId,
    required this.checkoutUrl,
    required this.redirectSuccessUrl,
    required this.redirectFailUrl,
  });

  factory PaymentStartResponse.fromJson(Map<String, dynamic> json) {
    return PaymentStartResponse(
        orderId: json['orderId'] as String,
        checkoutUrl: json['checkoutUrl'] as String,
        redirectSuccessUrl: json['redirectSuccessUrl'] as String,
        redirectFailUrl: json['redirectFailUrl'] as String
    );
  }
}
