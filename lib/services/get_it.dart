import 'package:get_it/get_it.dart';
import 'package:moxy/services/navigation_service.dart';

import '../repositories/product_repository.dart';
import '../repositories/user_repository.dart';
import 'image_picker_service.dart';

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    getIt.registerSingleton<UserRepository>(UserRepository());
    getIt.registerSingleton<NavigationService>(NavigationService());
    getIt.registerSingleton<ProductRepository>(ProductRepository());
    getIt.registerSingleton<ImagePickerService>(ImagePickerService());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}
