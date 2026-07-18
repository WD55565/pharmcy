import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_exception_mapper.dart';
import '../../../../core/network/failure.dart';
import '../../../../core/network/result.dart';
import '../../domain/entities/pharmacy.dart';
import '../../domain/repositories/pharmacy_repository.dart';
import '../datasources/pharmacy_remote_data_source.dart';

part 'pharmacy_repository_impl.g.dart';

class PharmacyRepositoryImpl implements PharmacyRepository {
  PharmacyRepositoryImpl(this._remoteDataSource);

  final PharmacyRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<Pharmacy>>> getPharmacies() async {
    try {
      final models = await _remoteDataSource.getPharmacies();
      final pharmacies = models.map((model) => model.toEntity()).toList();
      return Result.success(pharmacies);
    } on DioException catch (exception) {
      return Result.failure(mapDioExceptionToFailure(exception));
    } catch (exception) {
      return Result.failure(Failure.unknown(exception.toString()));
    }
  }

  @override
  Future<Result<Pharmacy>> getPharmacyById(int id) async {
    try {
      final model = await _remoteDataSource.getPharmacyById(id);
      return Result.success(model.toEntity());
    } on DioException catch (exception) {
      return Result.failure(mapDioExceptionToFailure(exception));
    } catch (exception) {
      return Result.failure(Failure.unknown(exception.toString()));
    }
  }
}

@riverpod
PharmacyRepository pharmacyRepository(Ref ref) {
  return PharmacyRepositoryImpl(ref.watch(pharmacyRemoteDataSourceProvider));
}
