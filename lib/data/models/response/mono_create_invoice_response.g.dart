// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mono_create_invoice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkCreateInvoiceResponse _$NetworkCreateInvoiceResponseFromJson(
        Map<String, dynamic> json) =>
    NetworkCreateInvoiceResponse(
      invoiceId: json['invoiceId'] as String,
      pageUrl: json['pageUrl'] as String,
    );

Map<String, dynamic> _$NetworkCreateInvoiceResponseToJson(
        NetworkCreateInvoiceResponse instance) =>
    <String, dynamic>{
      'invoiceId': instance.invoiceId,
      'pageUrl': instance.pageUrl,
    };
