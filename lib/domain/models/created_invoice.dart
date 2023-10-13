import 'package:moxy/domain/copyable.dart';

class CreatedInvoice implements Copyable<CreatedInvoice> {
  String invoiceId;
  String pageUrl;

  CreatedInvoice({
    required this.invoiceId,
    required this.pageUrl,
  });

  static CreatedInvoice defaultBasket() {
    return CreatedInvoice(
      invoiceId: '',
      pageUrl: '',
    );
  }

  @override
  CreatedInvoice copyWith({
    String? invoiceId,
    String? pageUrl,
  }) {
    return CreatedInvoice(
      invoiceId: invoiceId ?? this.invoiceId,
      pageUrl: pageUrl ?? this.pageUrl,
    );
  }
}
