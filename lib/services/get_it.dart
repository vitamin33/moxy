import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moxy/data/http/basket_service.dart';
import 'package:moxy/data/http/config_service.dart';
import 'package:moxy/data/http/dio_client.dart';
import 'package:moxy/data/http/nova_poshta_client.dart';
import 'package:moxy/data/http/order_service.dart';
import 'package:moxy/data/http/products_service.dart';
import 'package:moxy/data/http/profile_service.dart';
import 'package:moxy/data/http/token_service.dart';
import 'package:moxy/data/http/user_service.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/data/repositories/basket_repository.dart';
import 'package:moxy/data/repositories/config_repository.dart';
import 'package:moxy/data/repositories/filter_repository.dart';
import 'package:moxy/data/repositories/overview_repository.dart';
import 'package:moxy/data/repositories/promo_repository.dart';
import 'package:moxy/data/secure_storage.dart';
import 'package:moxy/domain/mappers/basket_mapper.dart';
import 'package:moxy/domain/mappers/config_mapper.dart';
import 'package:moxy/domain/mappers/order_mapper.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/mappers/profile_mapper.dart';
import 'package:moxy/domain/mappers/promo_mapper.dart';
import 'package:moxy/domain/mappers/user_mapper.dart';
import 'package:moxy/domain/mappers/warehouse_mapper.dart';
import '../data/repositories/footer_repository.dart';
import '../data/repositories/order_repository.dart';
import '../data/repositories/product_repository.dart';
import '../data/repositories/profile_repository.dart';
import '../data/secure_storage_repository.dart';
import '../domain/mappers/city_mapper.dart';
import '../domain/mappers/filter_params_mapper.dart';
import 'image_picker_service.dart';

class GetItService {
  static final getIt = GetIt.instance;
  static initializeService() {
    final dio = Dio();
    getIt.registerSingleton<ProductMapper>(ProductMapper());
    getIt.registerSingleton<FilterParamsMapper>(FilterParamsMapper());
    getIt.registerSingleton<ConfigMapper>(ConfigMapper());
    getIt.registerSingleton<CityMapper>(CityMapper());
    getIt.registerSingleton<WarehouseMapper>(WarehouseMapper());
    getIt.registerSingleton<OrderMapper>(OrderMapper());
    getIt.registerSingleton<UserMapper>(UserMapper());
    getIt.registerSingleton<BasketMapper>(BasketMapper());
    getIt.registerSingleton<Dio>(dio);
    getIt.registerSingleton<TokenService>(TokenService(dio));
    getIt.registerSingleton<ProfileService>(ProfileService(dio));
    getIt.registerSingleton<ProductsService>(ProductsService(dio));
    getIt.registerSingleton<BasketService>(BasketService(dio));
    getIt.registerSingleton<ConfigService>(ConfigService(dio));
    getIt.registerSingleton<OrderService>(OrderService(dio));
    getIt.registerSingleton<UserService>(UserService(dio));
    getIt.registerSingleton<DioClient>(DioClient());
    getIt.registerSingleton<AuthRepository>(AuthRepository());
    getIt.registerSingleton<ConfigRepository>(ConfigRepository());
    getIt.registerSingleton<ISecureStorageRepository>(
        SecureStorageRepository.instance);
    getIt.registerSingleton<FilterRepository>(FilterRepository());
    getIt.registerSingleton<ProductRepository>(ProductRepository());
    getIt.registerSingleton<OrderRepository>(OrderRepository());
    getIt.registerSingleton<ImagePickerService>(ImagePickerService());
    getIt.registerSingleton<NovaPoshtaClient>(NovaPoshtaClient());
    getIt.registerSingleton<PromoMapper>(PromoMapper());
    getIt.registerSingleton<OverviewRepository>(OverviewRepository());
    getIt.registerSingleton<FooterRepository>(FooterRepository());
    getIt.registerSingleton<PromoRepository>(PromoRepository());
    getIt.registerSingleton<BasketRepository>(BasketRepository());
    getIt.registerSingleton<ProfileMapper>(ProfileMapper());
    getIt.registerSingleton<ProfileRepository>(ProfileRepository());
  }
}


T locate<T extends Object>() {
  return GetItService.getIt<T>();
}
