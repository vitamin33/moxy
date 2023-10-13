import 'package:moxy/data/http/config_service.dart';
import 'package:moxy/domain/mappers/config_mapper.dart';
import 'package:moxy/domain/models/attributes.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

class ConfigRepository {
  Attributes? attributes;

  ConfigRepository();
  final ConfigService client = locate<ConfigService>();
  final ConfigMapper mapper = locate<ConfigMapper>();

  Future<bool> loadConfig() async {
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
    return attributes != null;
  }
}
