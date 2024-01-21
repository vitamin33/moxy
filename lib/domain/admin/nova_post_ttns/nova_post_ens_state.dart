import 'package:moxy/domain/models/nova_en.dart';

import '../../copyable.dart';

class NovaPostENsState implements Copyable<NovaPostENsState> {
  final List<NovaEN> allENs;
  final NovaEN? selectedEN;
  final String? savedNovaPostApiKey;
  final bool isLoading;
  final String? errorMessage;

  NovaPostENsState({
    required this.allENs,
    required this.selectedEN,
    required this.isLoading,
    required this.savedNovaPostApiKey,
    this.errorMessage,
  });

  static NovaPostENsState defaultAllENsState() {
    return NovaPostENsState(
      allENs: [],
      selectedEN: null,
      savedNovaPostApiKey: null,
      isLoading: false,
      errorMessage: '',
    );
  }

  @override
  NovaPostENsState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<NovaEN>? allENs,
    NovaEN? selectedEN,
    String? savedNovaPostApiKey,
  }) {
    return NovaPostENsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      allENs: allENs ?? this.allENs,
      selectedEN: selectedEN ?? this.selectedEN,
      savedNovaPostApiKey: savedNovaPostApiKey ?? this.savedNovaPostApiKey,
    );
  }
}
