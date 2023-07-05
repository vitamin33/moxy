import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moxy/data/http/dio_client.dart';
import 'package:moxy/data/http/nova_poshta_client.dart';
import 'package:moxy/data/http/token_service.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/data/secure_storage.dart';
import 'package:moxy/domain/mappers/order_mapper.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/mappers/user_mapper.dart';
import 'package:moxy/domain/mappers/warehouse_mapper.dart';
import 'package:moxy/services/navigation_service.dart';
import '../data/repositories/order_repository.dart';
import '../data/repositories/product_repository.dart';
import '../data/secure_storage_repository.dart';
import '../domain/mappers/city_mapper.dart';
import 'image_picker_service.dart';

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    final dio = Dio();
    getIt.registerSingleton<ProductMapper>(ProductMapper());
    getIt.registerSingleton<OrderMapper>(OrderMapper());
    getIt.registerSingleton<Dio>(dio);
    getIt.registerSingleton<TokenService>(TokenService(dio));
    getIt.registerSingleton<DioClient>(DioClient());
    getIt.registerSingleton<UserMapper>(UserMapper());
    getIt.registerSingleton<AuthRepository>(AuthRepository());
    getIt.registerSingleton<ISecureStorageRepository>(
        SecureStorageRepository.instance);
    getIt.registerSingleton<NavigationService>(NavigationService());
    getIt.registerSingleton<ProductRepository>(ProductRepository());
    getIt.registerSingleton<OrderRepository>(OrderRepository());
    getIt.registerSingleton<ImagePickerService>(ImagePickerService());
    getIt.registerSingleton(NovaPoshtaClient());
    getIt.registerSingleton(CityMapper());
    getIt.registerSingleton(WarehouseMapper());
  }
}

T locate<T extends Object>() {
  return GetItService.getIt<T>();
}
