import 'package:moxy/constants.dart';
import 'package:moxy/data/http/config_service.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/domain/mappers/config_mapper.dart';
import 'package:moxy/domain/models/attributes.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigRepository {
  Attributes? attributes;

  ConfigRepository();
  final AuthRepository authClient = locate<AuthRepository>();
  final ConfigService client = locate<ConfigService>();
  final ConfigMapper mapper = locate<ConfigMapper>();

  Future<bool> loadConfig() async {
    bool loggedIn = await hasLoggedIn();
    if (!loggedIn) {
      authClient.generateGuestToken();
    }
    return getAttributes().then((value) => true);
  }

  Future<Attributes> getAttributes() async {
    try {
      final result = await client.getAttributes();
      result.whenSuccess((success) {
        attributes = mapper.mapToAttributes(success);
        return attributes;
      });
      return Attributes.defaultAttributes();
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<bool> hasConfig() async {
    await getAttributes();
    bool noToken = await hasLoggedIn();
    return attributes != null && noToken;
  }

  Future<List<String>> getAttributesColorList() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> colorList =
          prefs.getStringList(attributesColorListKey) ?? [];
      return colorList;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<List<String>> getAttributesSizeList() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> sizeList = prefs.getStringList(attributesSizeListKey) ?? [];
      return sizeList;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<bool> hasLoggedIn() async {
    final loggedIn = await authClient.checkLoggedInState();
    return loggedIn;
  }
}
