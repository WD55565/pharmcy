import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/pharmacy_model.dart';

part 'pharmacy_remote_data_source.g.dart';

/// Talks to the Spring Boot backend's `/api/pharmacies` endpoint. Returns
/// raw [PharmacyModel]s; throws [DioException] on failure, left for the
/// repository layer to translate into a [Failure].
class PharmacyRemoteDataSource {
  PharmacyRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<PharmacyModel>> getPharmacies() async {
    final response = await _dio.get<List<dynamic>>(ApiEndpoints.pharmacies);
    final payload = response.data ?? const <dynamic>[];
    return payload
        .map((json) => PharmacyModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<PharmacyModel> getPharmacyById(int id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      ApiEndpoints.pharmacyById(id),
    );
    return PharmacyModel.fromJson(response.data!);
  }
}

@riverpod
PharmacyRemoteDataSource pharmacyRemoteDataSource(Ref ref) {
  return PharmacyRemoteDataSource(ref.watch(dioProvider));
}
