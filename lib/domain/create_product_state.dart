import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:moxy/components/base_state.dart';
import 'package:moxy/constant/route_name.dart';
import 'package:moxy/data/models/product.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/data/repositories/user_repository.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/services/image_picker_service.dart';
import 'package:moxy/services/navigation_service.dart';
import 'package:moxy/utils/common.dart';
import 'package:random_string/random_string.dart';

class CreateProductState extends BaseState {
  final userRepository = locate<UserRepository>();
  final imagePickerService = locate<ImagePickerService>();

  final productRepository = locate<ProductRepository>();

  late PageController pageController;
  int currentPage = 0;
  List<int> visitedPages = [0];

  String? seletedCategory;

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController previousPriceController;

  Uint8List? imageUnit8List;
  bool isLive = true;

  CreateProductState() {
    pageController = PageController();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    previousPriceController = TextEditingController();

    titleController.addListener(notifier);
    descriptionController.addListener(notifier);
    previousPriceController.addListener(notifier);
    descriptionController.addListener(notifier);
  }

  @override
  void dispose() {
    titleController.removeListener(notifier);
    descriptionController.removeListener(notifier);
    previousPriceController.removeListener(notifier);
    descriptionController.removeListener(notifier);
    super.dispose();
  }

  bool get detailPageIsValid =>
      titleController.text.trim().isNotEmpty &&
      descriptionController.text.trim().isNotEmpty &&
      seletedCategory != null &&
      seletedCategory!.isNotEmpty;

  bool get pricingPageIsValid =>
      priceController.text.trim().isNotEmpty &&
      previousPriceController.text.trim().isNotEmpty;

  void notifier() {
    notifyListeners();
  }

  void setCategory(String value) {
    seletedCategory = value;
    notifyListeners();
  }

  void moveToNexPage() {
    currentPage++;
    notifyListeners();
    animateToPage(currentPage);
  }

  void moveToPreviousPage() {
    currentPage--;
    notifyListeners();
    animateToPage(currentPage);
  }

  void animateToPage(int page) {
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void onChangePage(int value) {
    currentPage = value;
    notifyListeners();
    if (!visitedPages.contains(value)) {
      visitedPages.add(value);
    }
  }

  void pickImage() async {
    Uint8List? image = await imagePickerService.pickImages();
    imageUnit8List = image;
    notifyListeners();
  }

  Future<void> publishProduct() async {
    if (isLoading == false) {
      setLoading(true);
      final id = randomAlphaNumeric(8);
      if (imageUnit8List == null) return;

      String imageUrl = await imagePickerService.uploadImageToDefaultBucket(
          imageUnit8List!, "product_$id");

      final product = Product(
        id: id,
        title: titleController.text.trim(),
        imageUrl: imageUrl,
        description: descriptionController.text.trim(),
        category: "$seletedCategory ",
        price: int.tryParse(priceController.text) ?? 0,
        createdAt: timeNow(),
        updatedAt: timeNow(),
        isLive: isLive,
        ingridients: const [],
        previousPrice: int.tryParse(previousPriceController.text) ?? 0,
        createdBy: {
          "uid": userRepository.currentUserUID,
          "name": userRepository.currentUserNotifier.value?.name,
          "email": userRepository.currentUserNotifier.value?.email,
        },
      );

      final addProduct = await productRepository.addProduct(product);
      setLoading(false);

      if (addProduct.isRight) {
        navigatePushReplaceName(productsPath);
      } else {
        moxyPrint(addProduct.left);
      }
    }
  }

  void setLive(bool value) {
    isLive = value;
    notifyListeners();
  }
}
