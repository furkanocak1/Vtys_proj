import '../config/app_config.dart';
import 'arac_api_repository.dart';
import 'arac_mock_repository.dart';
import 'arac_repository.dart';

class RepositoryProvider {
  static AracRepository get aracRepository {
    if (AppConfig.useMock) return AracMockRepository();
    return AracApiRepository();
  }
}
