import '../../../../core/network/result.dart';
import '../entities/pharmacy.dart';

/// Contract the presentation layer depends on. Implemented by
/// `data/repositories/pharmacy_repository_impl.dart`; presentation code
/// never imports Dio or [PharmacyModel] directly.
abstract interface class PharmacyRepository {
  Future<Result<List<Pharmacy>>> getPharmacies();

  Future<Result<Pharmacy>> getPharmacyById(int id);
}
