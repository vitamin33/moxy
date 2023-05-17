import 'package:get_it/get_it.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/data/secure_storage.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/services/navigation_service.dart';
import '../data/repositories/order_repository.dart';
import '../data/repositories/product_repository.dart';
import '../data/secure_storage_repository.dart';
import 'image_picker_service.dart';

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    getIt.registerSingleton<AuthRepository>(AuthRepository.instance);
    getIt.registerSingleton<ISecureStorageRepository>(
        SecureStorageRepository.instance);
    getIt.registerSingleton<NavigationService>(NavigationService());
    getIt.registerSingleton<ProductRepository>(ProductRepository());
    getIt.registerSingleton<OrderRepository>(OrderRepository());
    getIt.registerSingleton<ImagePickerService>(ImagePickerService());
    getIt.registerSingleton<ProductMapper>(ProductMapper());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}
