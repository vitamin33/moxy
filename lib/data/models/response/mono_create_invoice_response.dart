import 'package:freezed_annotation/freezed_annotation.dart';

part 'mono_create_invoice_response.g.dart';

@JsonSerializable()
class NetworkCreateInvoiceResponse {
  String invoiceId;
  String pageUrl;

  NetworkCreateInvoiceResponse({
    required this.invoiceId,
    required this.pageUrl,
  });

  factory NetworkCreateInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$NetworkCreateInvoiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkCreateInvoiceResponseToJson(this);
}
