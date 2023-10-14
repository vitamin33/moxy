import 'package:freezed_annotation/freezed_annotation.dart';

part 'mono_create_invoice_request.g.dart';

@JsonSerializable()
class CreateInvoiceRequest {
  int amount;
  int ccy = 980; // default currency cod for UAH
  String redirectUrl;
  String webHookUrl;
  String paymentType;
  NetworkMerchantInfo merchantPaymInfo;

  CreateInvoiceRequest({
    required this.amount,
    required this.ccy,
    required this.redirectUrl,
    required this.merchantPaymInfo,
    required this.paymentType,
    required this.webHookUrl,
  });

  factory CreateInvoiceRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateInvoiceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateInvoiceRequestToJson(this);
}

@JsonSerializable()
class NetworkMerchantInfo {
  List<MonoBasketItem> basketOrder;
  String comment;
  String destination;
  String reference;

  NetworkMerchantInfo({
    required this.basketOrder,
    required this.comment,
    required this.destination,
    required this.reference,
  });
  factory NetworkMerchantInfo.fromJson(Map<String, dynamic> json) =>
      _$NetworkMerchantInfoFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkMerchantInfoToJson(this);
}

@JsonSerializable()
class MonoBasketItem {
  String name;
  int qty;
  int sum;
  String icon;
  String unit;
  String code;

  MonoBasketItem({
    required this.name,
    required this.qty,
    required this.sum,
    required this.code,
    required this.icon,
    required this.unit,
  });
  factory MonoBasketItem.fromJson(Map<String, dynamic> json) =>
      _$MonoBasketItemFromJson(json);

  Map<String, dynamic> toJson() => _$MonoBasketItemToJson(this);
}
