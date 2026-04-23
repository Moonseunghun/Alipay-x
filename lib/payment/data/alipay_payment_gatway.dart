import 'package:dio/dio.dart';
import 'package:example_alipay/payment/domain/payment_gateway.dart';
import 'package:example_alipay/payment/domain/payment_models.dart';
import 'package:example_alipay/payment/domain/payment_status.dart';
import 'package:flutter/material.dart';

class AlipayPaymentGatway implements PaymentGateway {
  final Dio dio;

  AlipayPaymentGatway(this.dio);

  @override
  Future<PaymentStartResponse> createPayment(PaymentModels request) async {
    final response = await dio.post('a' ,data: request.toJson());

    return PaymentStartResponse.fromJson(response.data);
  }

  @override
  Future<PaymentStatus> getPaymentStatus(String orderId) async {
    final response = await dio.get('/payment/$orderId/status');

    final raw = response.data['status'] as String;

    switch (raw) {
      case 'SUCCESS':
       return PaymentStatus.success;
      case 'FAIlED':
       return PaymentStatus.failed;
      case 'CANCELLED':
        return PaymentStatus.cancelled;
      default:
        return PaymentStatus.pending;
    }
  }
}