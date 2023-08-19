import 'package:moxy/domain/copyable.dart';

import '../../models/promo.dart';

class PromoState implements Copyable<PromoState> {
  final bool isLoading;
  final List<Promo> allPromo;
  final String errorMessage;
  final int activePage;

  PromoState({
    required this.isLoading,
    required this.allPromo,
    required this.errorMessage,
    required this.activePage,
  });

  static defaultPromoState() {
    return PromoState(
      isLoading: false,
      allPromo: [Promo.defaultPromo()],
      errorMessage: '',
      activePage: 0,
    );
  }

  @override
  PromoState copyWith({
    bool? isLoading,
    List<Promo>? allPromo,
    String? errorMessage,
    int? activePage,
  }) {
    return PromoState(
      isLoading: isLoading ?? this.isLoading,
      allPromo: allPromo ?? this.allPromo,
      errorMessage: errorMessage ?? this.errorMessage,
      activePage: activePage ?? this.activePage,
    );
  }
}
