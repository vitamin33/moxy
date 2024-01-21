import 'package:flutter/material.dart';
import 'package:moxy/data/http/nova_poshta_client.dart';
import 'package:moxy/domain/admin/create_order/create_order_cubit.dart';
import 'package:moxy/domain/admin/nova_post_ttns/nova_post_ens_effects.dart';
import 'package:moxy/domain/models/nova_en.dart';
import 'package:moxy/services/cubit_with_effects.dart';

import '../../../services/get_it.dart';
import '../../ui_effect.dart';
import 'nova_post_ens_state.dart';

class NovaPostENsCubit extends CubitWithEffects<NovaPostENsState, UiEffect> {
  final novaPostClient = locate<NovaPoshtaClient>();
  final TextEditingController apiKeyController = TextEditingController();
  final CreateOrderCubit orderCubit;

  NovaPostENsCubit({required this.orderCubit})
      : super(NovaPostENsState.defaultAllENsState()) {
    loadAllENs();
  }

  void loadAllENs() async {
    try {
      final apiKey = await novaPostClient.getSavedNovaPostApiKey();
      if (apiKey == null) {
        emitEffect(ApiKeyNotSaved());
      } else {
        apiKeyController.text = apiKey;
        emit(state.copyWith(isLoading: true, savedNovaPostApiKey: apiKey));
        final result = await novaPostClient.fetchExpressWaybills(apiKey);
        final allENsList = result.map((e) => NovaEN.fromNetwork(e)).toList();
        emit(state.copyWith(allENs: allENsList, isLoading: false));
      }
    } catch (e) {
      emitEffect(ENsLoadingFailed(e.toString()));
      emit(state.copyWith(isLoading: false));
    }
  }

  void submitNovaPostApiKey(String? apiKey) async {
    if (apiKey != null && apiKey.isNotEmpty) {
      await novaPostClient.saveNovaPostApiKey(apiKey);
      emit(state.copyWith(savedNovaPostApiKey: apiKey));
      refreshAllENs();
    }
  }

  void refreshAllENs() {
    loadAllENs();
  }

  void searchProducts(String searchTerm) {
    final filteredList = state.allENs.where((element) {
      bool hasAddr = element.recipientAddressDescription
          .toLowerCase()
          .contains(searchTerm.toLowerCase());
      bool hasName = element.recipientContactPerson
          .toLowerCase()
          .contains(searchTerm.toLowerCase());
      bool hasPhone = element.recipientPhone
          .toLowerCase()
          .contains(searchTerm.toLowerCase());
      return hasAddr || hasName || hasPhone;
    }).toList();
    emit(state.copyWith(allENs: filteredList));
  }

  void onApiKeyTextChanged(String value) {
    if (value.isNotEmpty) {
      final String apiKey = value;
      emit(state.copyWith(savedNovaPostApiKey: apiKey));
    }
  }

  void loadENsData(NovaEN item) {
    orderCubit.loadDataFromEN(item);
  }
}
