import 'package:moxy/domain/copyable.dart';

import '../../models/promo.dart';

class PromoState implements Copyable<PromoState> {
  final bool isLoading;
  final List<Promo> allPromo;
  final String errorMessage;

  PromoState({
    required this.isLoading,
    required this.allPromo,
    required this.errorMessage,
  });

  static defaultPromoState() {
    return PromoState(
      isLoading: false,
      allPromo: [Promo.defaultPromo()],
      errorMessage:'',
    );
  }

  @override
  PromoState copyWith({
    bool? isLoading,
    List<Promo>? allPromo,
    String? errorMessage,
  }) {
    return PromoState(
      isLoading: isLoading ?? this.isLoading,
      allPromo: allPromo ?? this.allPromo,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
