// ignore: depend_on_referenced_packages
import 'package:moxy/data/models/request/change_basket_dimen.dart';
import 'package:moxy/data/models/response/basket_response.dart';
import 'package:moxy/data/repositories/basket_repository.dart';
import 'package:moxy/domain/client/basket/basket_effect.dart';
import 'package:moxy/domain/mappers/basket_mapper.dart';
import 'package:moxy/domain/mappers/city_mapper.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/product_details.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'basket_state.dart';

class BasketCubit extends CubitWithEffects<BasketState, UiEffect>
    with ValidationMixin {
  final BasketRepository basketRepository = locate<BasketRepository>();
  final basketMapper = locate<BasketMapper>();
  final cityMapper = locate<CityMapper>();
  BasketCubit() : super(BasketState.defaultState()) {
    getBasketInfo();
  }

  void getBasketInfo() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await basketRepository.getBasket();
      result.when((basket) {
        if (basket != null) {
          emitSuccessBasket(basket);
        } else {
          emit(state.copyWith(isLoading: false, basket: null));
        }
      }, (error) {
        emit(state.copyWith(isLoading: false));
        emitEffect(BasketApiRequestFailed(
            'Failed get basket info ${error.toString()}'));
      });
    } catch (e, stack) {
      moxyPrint(stack);
    }
  }

  void emitSuccessBasket(NetworkBasket success) {
    Basket basket = basketMapper.mapToBasket(success);
    bool isFreeShipping =
        basket.amountForFreeShipping() > basket.freeShippingThreshold;
    emit(
      state.copyWith(
        basket: basket,
        isFreeShipping: isFreeShipping,
        isLoading: false,
      ),
    );
  }

  void addQuantityOfProduct(BasketItem basketItem) {
    if (checkMaxQuantityAvailability(basketItem)) {
      String? productId = basketItem.product.id;
      BasketItem item = state.basket.basketItems
          .firstWhere((element) => element.product.id == productId);
      basketItem.dimension.quantity++;
      item.dimension = basketItem.dimension;
      emit(
        state.copyWith(
          basket: state.basket.copyWith(basketItems: state.basket.basketItems),
        ),
      );
      updateCart(item);
    }
  }

  void removeQuantityOfProduct(BasketItem basketItem) {
    if (checkMinQuantityAvailability(basketItem)) {
      String? productId = basketItem.product.id;
      BasketItem item = state.basket.basketItems
          .firstWhere((element) => element.product.id == productId);
      basketItem.dimension.quantity--;
      item.dimension = basketItem.dimension;
      emit(
        state.copyWith(
          basket: state.basket.copyWith(basketItems: state.basket.basketItems),
        ),
      );
      updateCart(item);
    }
  }

  void updateCart(BasketItem basketItem) async {
    NetworkAddOrChange item = basketMapper.mapToNetworkBasketChange(basketItem);
    final result = await basketRepository.changeBasketProductDimen(item);
    result.when((success) {
      emitSuccessBasket(success);
    }, (error) {
      emit(state.copyWith(isLoading: false));
      emitEffect(
          BasketApiRequestFailed('Failed update cart ${error.toString()}'));
    });
  }

  bool checkMaxQuantityAvailability(BasketItem basketItem) {
    Dimension orderedDimen = basketItem.dimension;
    Dimension productDimen = basketItem.product.dimensions
        .firstWhere((d) => d.color.id == orderedDimen.color.id);
    if (orderedDimen.quantity < productDimen.quantity) {
      return true;
    }
    return false;
  }

  bool checkMinQuantityAvailability(BasketItem basketItem) {
    Dimension orderedDimen = basketItem.dimension;
    if (orderedDimen.quantity > 0) {
      return true;
    }
    return false;
  }

  void removeProductFromBasket(BasketItem item) {
    List<BasketItem> items = state.basket.basketItems;
    items.removeWhere((element) => element.product.id == item.product.id);
    emit(state.copyWith(basket: state.basket.copyWith(basketItems: items)));
    removeProductFromCart(item);
  }

  void removeProductFromCart(BasketItem basketItem) async {
    NetworkRemoveProduct remove =
        NetworkRemoveProduct(productId: basketItem.product.id!);
    final result = await basketRepository.removeProductFromBasket(remove);
    result.when((success) {
      emitSuccessBasket(success);
    }, (error) {
      emitEffect(
          BasketApiRequestFailed('Failed remove product ${error.toString()}'));
    });
  }

  void addProductToBasket(Product product) async {
    emit(state.copyWith(isLoading: true));
    NetworkAddOrChange item =
        basketMapper.productMapToNetworkBasketChange(product);
    final result = await basketRepository.addProductToBasket(item);
    result.when((success) {
      final List<BasketItem> updateBasketItemsList = [
        ...state.basket.basketItems,
        BasketItem(
            product: product,
            dimension: Dimension(
                color: product.dimensions.first.color,
                quantity: 1,
                material: product.dimensions.first.material,
                size: product.dimensions.first.size,
                images: product.dimensions.first.images)),
      ];
      emit(state.copyWith(
          isLoading: false,
          basket: state.basket.copyWith(basketItems: updateBasketItemsList)));
    }, (error) {
      emit(state.copyWith(isLoading: false));
      emitEffect(BasketApiRequestFailed(
          'Failed add product to basket  ${error.toString()}'));
    });
  }

  void addBasketItemToBasket(BasketItem basketItem) async {
    emit(state.copyWith(isLoading: true));
    NetworkAddOrChange item = basketMapper.mapToNetworkBasketChange(basketItem);
    final result = await basketRepository.addProductToBasket(item);
    result.when((success) {
      emit(state.copyWith(
          basket: state.basket.copyWith(basketItems: [basketItem])));
    }, (error) {
      emit(state.copyWith(isLoading: false));
      emitEffect(BasketApiRequestFailed(
          'Failed add product to basket  ${error.toString()}'));
    });
  }

  Future<bool> addProductDetailsToBasket({
    required ProductDetails productDetails,
    bool navigateToCheckout = false,
  }) async {
    emit(state.copyWith(isLoading: true));
    bool isProductInBasket = false;
    NetworkAddOrChange item =
        basketMapper.productDetailsMapToNetworkBasketChange(productDetails);
    final result = await basketRepository.addProductToBasket(item);
    result.when((success) {
      emit(
        state.copyWith(
          isLoading: false,
          basket: state.basket.copyWith(
            basketItems: [
              ...state.basket.basketItems,
              BasketItem(
                  product: productDetails.product,
                  dimension: productDetails.selectedDimension)
            ],
          ),
        ),
      );
      if (navigateToCheckout) {
        emitEffect(NavigateToCheckout());
      }
    }, (error) {
      emit(state.copyWith(isLoading: false));
      emitEffect(BasketApiRequestFailed(
          'Failed add product to basket  ${error.toString()}'));
    });
    return isProductInBasket;
  }

  String getBasketCount() {
    int basketCount = 0;
    for (BasketItem item in state.basket.basketItems) {
      basketCount += item.dimension.quantity;
    }
    return basketCount.toString();
  }
}
