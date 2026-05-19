import '../config/app_config.dart';
import 'arac_api_repository.dart';
import 'arac_mock_repository.dart';
import 'arac_repository.dart';
import 'musteri_api_repository.dart';
import 'musteri_mock_repository.dart';
import 'musteri_repository.dart';
import 'satis_api_repository.dart';
import 'satis_mock_repository.dart';
import 'satis_repository.dart';

class RepositoryProvider {
  static AracRepository get aracRepository {
    if (AppConfig.useMock) return AracMockRepository();
    return AracApiRepository();
  }

  static MusteriRepository get musteriRepository {
    if (AppConfig.useMock) return MusteriMockRepository();
    return MusteriApiRepository();
  }

  static SatisRepository get satisRepository {
    if (AppConfig.useMock) return SatisMockRepository();
    return SatisApiRepository();
  }
}
