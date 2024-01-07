import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/config_repository.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/admin/create_product/create_product_effects.dart';
import 'package:moxy/domain/admin/create_product/create_product_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/utils/common.dart';

import '../../../services/get_it.dart';
import '../../mappers/product_mapper.dart';

class CreateProductCubit extends CubitWithEffects<CreateProductState, UiEffect>
    with ValidationMixin {
  final productMapper = locate<ProductMapper>();
  final productRepository = locate<ProductRepository>();
  final configRepository = locate<ConfigRepository>();
  final bool isEditMode;
  final String? productId;

  CreateProductCubit({required this.productId, required this.isEditMode})
      : super(
          CreateProductState.defaultCreateProductState(),
        ) {
    initState();
    if (isEditMode && productId != null) {
      getProductById(productId);
    }
  }
  List<TextEditingController> quantityControllers = [];

  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController costPriceInUsdController =
      TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController idNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController depthController = TextEditingController();
  final TextEditingController seasonController = TextEditingController();
  final TextEditingController furnitureController = TextEditingController();
  final TextEditingController strapController = TextEditingController();
  final TextEditingController producerController = TextEditingController();
  final TextEditingController styleController = TextEditingController();
  final PageController pageController = PageController(initialPage: 0);

  void addProduct() async {
    try {
      emit(state.copyWith(isLoading: true));
      final images = _getAllChosenFileDimenImages();
      final product = productMapper.mapToNetworkProduct(state.product);
      List<int> imageIndexes =
          formNumberOfChoseImagesIndexes(state.product.dimensions);
      final pushProduct =
          await productRepository.addProduct(product, images, imageIndexes);
      pushProduct.when((success) {
        _clearFieldsControllers();

        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
            product: Product.defaultProduct(),
          ),
        );
        initState();
      }, (error) {
        emit(state.copyWith(
            errorMessage: 'Failed', isLoading: false, activePage: 0));
      });
    } catch (e) {
      moxyPrint(e);
    }
  }

  Future<void> pickImage(int dimenIndex) async {
    try {
      Dimension dimension = state.product.dimensions[dimenIndex];
      final pickedFiles = await ImagePicker().pickMultiImage(imageQuality: 6);
      final images = <ImagePath>[...dimension.images];
      if (pickedFiles.isNotEmpty) {
        for (var element in pickedFiles) {
          final file = File(element.path);
          final imagePath = file.path;
          images.add(ImagePath(type: Type.file, imagePath: imagePath));
        }
        dimension.images = images;
        emit(
          state.copyWith(
            product:
                state.product.copyWith(dimensions: state.product.dimensions),
          ),
        );
      }
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void createNew() {
    emit(state.copyWith(isSuccess: false));
    clearState();
  }

  void backToProduct(context) {
    clearState();
    context.go(RouterProvider.adminProductsPath());
  }

  void onChangePage(int page) {
    emit(state.copyWith(activePage: page));
  }

  void categorySelected(String category) {
    emit(state.copyWith(product: state.product.copyWith(category: category)));
  }

  void nameChanged(value) {
    if (value.isEmpty) {
      return;
    }
    final String name = value;
    emit(state.copyWith(product: state.product.copyWith(name: name)));
  }

  void descriptionChanged(String value) {
    if (value.isEmpty) {
      return;
    }
    List<String> lines = value.split('\n');
    if (lines.length > 6) {
      lines.removeRange(6, lines.length);
      descriptionController.value = TextEditingValue(
        text: lines.join('\n'),
        selection: TextSelection.collapsed(offset: lines.join('\n').length),
      );
    }
    final String description = value;
    emit(state.copyWith(
        product: state.product.copyWith(description: description)));
  }

  void idNameChanged(String value) {
    if (value.isNotEmpty) {
      final String idName = value;
      emit(state.copyWith(product: state.product.copyWith(idName: idName)));
    }
  }

  void costPriceInUsdChanged(String value) {
    if (value.isNotEmpty) {
      final double costPrice = double.parse(value);
      emit(state.copyWith(
          product: state.product.copyWith(costPriceInUsd: costPrice)));
    }
  }

  void weightInGramsChanged(String value) {
    if (value.isNotEmpty) {
      final int weightInGrams = int.parse(value);
      emit(state.copyWith(
          product: state.product.copyWith(
              attributes: state.product.attributes
                  .copyWith(weightInGrams: weightInGrams))));
    }
  }

  void heightInCmChanged(String value) {
    if (value.isNotEmpty) {
      final int heightInCm = int.parse(value);
      emit(state.copyWith(
          product: state.product.copyWith(
              attributes:
                  state.product.attributes.copyWith(heightInCm: heightInCm))));
    }
  }

  void widthInCmChanged(String value) {
    if (value.isNotEmpty) {
      final int widthInCm = int.parse(value);
      emit(state.copyWith(
          product: state.product.copyWith(
              attributes:
                  state.product.attributes.copyWith(widthInCm: widthInCm))));
    }
  }

  void lengthInCmChanged(String value) {
    if (value.isNotEmpty) {
      final int lengthInCm = int.parse(value);
      emit(state.copyWith(
          product: state.product.copyWith(
              attributes:
                  state.product.attributes.copyWith(lengthInCm: lengthInCm))));
    }
  }

  void depthInCmChanged(String value) {
    if (value.isNotEmpty) {
      final int depthInCm = int.parse(value);
      emit(state.copyWith(
          product: state.product.copyWith(
              attributes:
                  state.product.attributes.copyWith(depthInCm: depthInCm))));
    }
  }

  void seasonChanged(value) {
    if (value.isEmpty) {
      return;
    }
    final String season = value;
    emit(state.copyWith(
        product: state.product.copyWith(
      attributes: state.product.attributes.copyWith(season: season),
    )));
  }

  void furnitureChanged(value) {
    if (value.isEmpty) {
      return;
    }
    final String furniture = value;
    emit(state.copyWith(
        product: state.product.copyWith(
      attributes: state.product.attributes.copyWith(furniture: furniture),
    )));
  }

  void strapChanged(value) {
    if (value.isEmpty) {
      return;
    }
    final String strap = value;
    emit(state.copyWith(
        product: state.product.copyWith(
      attributes: state.product.attributes.copyWith(strap: strap),
    )));
  }

  void producerChanged(value) {
    if (value.isEmpty) {
      return;
    }
    final String producer = value;
    emit(state.copyWith(
        product: state.product.copyWith(
      attributes: state.product.attributes.copyWith(producer: producer),
    )));
  }

  void styleChanged(value) {
    if (value.isEmpty) {
      return;
    }
    final String style = value;
    emit(state.copyWith(
        product: state.product.copyWith(
      attributes: state.product.attributes.copyWith(style: style),
    )));
  }

  void quantityLongAdd(int index, int? quantity) {
    Dimension? dimen = state.product.dimensions[index];
    if (quantity != null) {
      dimen.quantity += 10;
    }
    emit(state.copyWith(product: state.product));
  }

  void quantityAdd(int index, int? quantity) {
    Dimension? dimen = state.product.dimensions[index];
    if (quantity != null) {
      dimen.quantity++;
    }
    emit(state.copyWith(product: state.product));
  }

  void quantityRemove(int index, int? quantity) {
    Dimension? dimen = state.product.dimensions[index];

    if (quantity != null && dimen.quantity > 0) {
      dimen.quantity--;
    }
    emit(state.copyWith(product: state.product));
  }

  void quantityLongRemove(int index, int? quantity) {
    Dimension? dimen = state.product.dimensions[index];
    if (quantity != null && dimen.quantity > 0) {
      dimen.quantity -= 10;
    }
    emit(state.copyWith(product: state.product));
  }

  void quantityChanged(int index, String? quantity) {
    Dimension? dimen = state.product.dimensions[index];
    if (quantity != null && quantity.isNotEmpty) {
      dimen.quantity = int.parse(quantity);
      emit(state.copyWith(product: state.product));
    }
  }

  void salePriceChanged(value) {
    if (value != null) {
      final double salePrice = double.parse(value);
      emit(state.copyWith(
          product: state.product.copyWith(salePrice: salePrice)));
    }
  }

  void moveToNextPage() {
    if (state.activePage != 1) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      if (validateFields()) {
        if (isEditMode) {
          editProduct(state.editProductId);
        } else {
          addProduct();
        }
      }
    }
  }

  void moveToPreviustPage() {
    if (state.activePage != 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      moxyPrint(state.product);
    } else {
      return;
    }
  }

  void removeImage(int dimenIndex, int imageIndex) {
    Dimension dimension = state.product.dimensions[dimenIndex];
    List<ImagePath> updatedImages = List<ImagePath>.from(dimension.images);
    updatedImages.removeAt(imageIndex);
    dimension.images = updatedImages;
    emit(state.copyWith(
        product: state.product.copyWith(dimensions: state.product.dimensions)));
  }

  void clearState() {
    emit(state.copyWith(editProduct: null, product: null, activePage: 0));
  }

  void clearErrorState() {
    emit(state.copyWith(errorMessage: ''));
  }

  //  EDIT FUNCTION
  void getProductById(id) async {
    emit(state.copyWith(editProductId: id, isLoading: true));
    final productById = await productRepository.getProductById(id);
    emit(state.copyWith(isLoading: true));
    productById.when((success) {
      final product = productMapper.mapToProduct(success);
      final updatedAllDimens =
          checkSelectedColors(product.dimensions.map((e) => e.color).toList());
      emit(state.copyWith(
          product: product,
          allConfigColors: updatedAllDimens,
          isLoading: false));
    }, (error) {
      moxyPrint(error);
    });
    fillFields(state.product);
  }

  void fillFields(Product product) {
    nameController.text = product.name;
    descriptionController.text = product.description;
    costPriceInUsdController.text = product.costPriceInUsd.toString();
    weightController.text = product.attributes.weightInGrams.toString();
    salePriceController.text = product.salePrice.toString();
    idNameController.text = product.idName.toString();
    heightController.text = product.attributes.heightInCm.toString();
    widthController.text = product.attributes.widthInCm.toString();
    lengthController.text = product.attributes.lengthInCm.toString();
    depthController.text = (product.attributes.depthInCm ?? '').toString();
    seasonController.text = product.attributes.season ?? '';
    furnitureController.text = product.attributes.furniture ?? '';
    strapController.text = product.attributes.strap ?? '';
    producerController.text = product.attributes.producer ?? '';
    styleController.text = product.attributes.style ?? '';
  }

  void changeEdit() {
    emit(state.copyWith(isEdit: true));
  }

  void toggleColorField(int index) {
    state.allConfigColors[index].isSelected =
        !state.allConfigColors[index].isSelected;
    final updatedColors = state.allConfigColors;
    final updatedDimens = createSelectedDimensions(
      state.allConfigColors,
    );
    emit(state.copyWith(
      allConfigColors: updatedColors,
      product: state.product.copyWith(dimensions: updatedDimens),
    ));
  }

  void editProduct(editProductId) async {
    try {
      emit(state.copyWith(isLoading: true));
      List<ImagePath> allDimenImages = _getAllChosenFileDimenImages();
      final product = productMapper.mapToNetworkProduct(state.product);
      List<int> imageIndexes =
          formNumberOfChoseImagesIndexes(state.product.dimensions);
      List<Dimension> filteredDimens =
          filterFileImagesDimens(state.product.dimensions);
      final updated = await productRepository.editProduct(
          product, filteredDimens, allDimenImages, imageIndexes, editProductId);
      updated.when((success) {
        _clearFieldsControllers();
        emit(state.copyWith(isLoading: false));
        emitEffect(NavigateToProducts());
      }, (error) {
        emit(state.copyWith(
            errorMessage: 'Failed', isLoading: false, activePage: 0));
        emitEffect(ProductUpdateFailed(error.toString()));
      });
    } catch (e) {
      moxyPrint(e);
    }
  }

  bool validateFields() {
    final errors = FieldErrors.noErrors();
    var noErrors = true;
    if (isFieldEmpty(state.product.name)) {
      errors.productName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.product.description)) {
      errors.productDescription = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.product.idName)) {
      errors.productIdName = FieldError.empty;
      noErrors = false;
    }
    if (!isValidPrice(state.product.costPriceInUsd)) {
      errors.costPriceInUsd = FieldError.invalid;
      noErrors = false;
    }
    if (!isValidWeight(state.product.attributes.weightInGrams)) {
      errors.weightInGrams = FieldError.invalid;
      noErrors = false;
    }
    if (!isValidSizeValues(state.product.attributes.heightInCm)) {
      errors.heightInCm = FieldError.invalid;
      noErrors = false;
    }
    if (!isValidSizeValues(state.product.attributes.widthInCm)) {
      errors.widthInCm = FieldError.invalid;
      noErrors = false;
    }
    if (!isValidSizeValues(state.product.attributes.lengthInCm)) {
      errors.lengthInCm = FieldError.invalid;
      noErrors = false;
    }
    if (!isValidQuantity(state.product.dimensions)) {
      errors.dimensions = FieldError.invalid;
      noErrors = false;
    }
    if (!isValidPrice(state.product.salePrice)) {
      errors.salePrice = FieldError.invalid;
      noErrors = false;
    }
    if (!noErrors) {
      emitEffect(ValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(errors: errors));
    return noErrors;
  }

  List<ProductColor> checkSelectedColors(List<ProductColor> colors) {
    for (var element in state.allConfigColors) {
      element.isSelected = colors.contains(element);
    }
    return state.allConfigColors;
  }

  List<Dimension> createSelectedDimensions(
    List<ProductColor> colors,
  ) {
    final dimensions = colors
        .where((color) => color.isSelected)
        .map(
          (color) => Dimension(
            color: color,
            quantity: 1,
            material: null,
            size: null,
            images: [],
          ),
        )
        .toList();

    return dimensions;
  }

  List<ImagePath> _getAllChosenFileDimenImages() {
    List<ImagePath> result = [];
    state.product.dimensions
        .expand((dimension) => dimension.images)
        .forEach((element) {
      if (element.type == Type.file) {
        result.add(element);
      }
    });

    return result;
  }

  void _clearFieldsControllers() {
    nameController.clear();
    descriptionController.clear();
    costPriceInUsdController.clear();
    weightController.clear();
    salePriceController.clear();
    colorController.clear();
    idNameController.clear();
    heightController.clear();
    widthController.clear();
    lengthController.clear();
    depthController.clear();
    seasonController.clear();
    furnitureController.clear();
    strapController.clear();
    producerController.clear();
    styleController.clear();
    for (var element in quantityControllers) {
      element.clear();
    }
    List<ProductColor> updatedAllConfigColors =
        state.allConfigColors.map((color) {
      return ProductColor(
        id: color.id,
        hexCode: color.hexCode,
        name: color.name,
        isSelected: false,
      );
    }).toList();
    emit(state.copyWith(
        product: Product.defaultProduct(),
        allConfigColors: updatedAllConfigColors));
  }

  List<int> formNumberOfChoseImagesIndexes(List<Dimension> dimensions) {
    final result = dimensions.map((e) {
      if (e.images.isNotEmpty) {
        return e.images.where((element) => element.type == Type.file).length;
      } else {
        return 0;
      }
    }).toList();
    return result;
  }

  List<Dimension> filterFileImagesDimens(List<Dimension> dimensions) {
    final result = dimensions.map((dimension) {
      final filteredImages =
          dimension.images.where((image) => image.type != Type.file).toList();
      return dimension.copyWith(images: filteredImages);
    }).toList();

    return result;
  }

  void initState() {
    final colors = configRepository.attributes?.colors ?? [];
    final categories = configRepository.attributes?.productCategories ?? [];
    final firstCategory = categories.isNotEmpty ? categories.first : '';
    emit(
      state.copyWith(
        allConfigColors: colors,
        productCategories: categories,
        product: state.product.copyWith(category: firstCategory),
      ),
    );
  }
}
