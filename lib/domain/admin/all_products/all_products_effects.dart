import '../../ui_effect.dart';

class ProductsLoadingFailed implements UiEffect {
  String failureText;
  ProductsLoadingFailed(this.failureText);
}

class DeleteProductFailed implements UiEffect {
  String failureText;
  DeleteProductFailed(this.failureText);
}
