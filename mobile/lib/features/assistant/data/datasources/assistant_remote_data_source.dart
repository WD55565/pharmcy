import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/config/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';

part 'assistant_remote_data_source.g.dart';

/// Talks to the backend's `/api/assistant/chat` endpoint, which itself
/// calls Gemini server-side — the API key never reaches this client, so
/// nothing secret ends up in the compiled web bundle.
class AssistantRemoteDataSource {
  AssistantRemoteDataSource(this._dio);

  final Dio _dio;

  Future<String> chat({
    required String message,
    required List<Map<String, String>> history,
    required String language,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.assistantChat,
      data: {'message': message, 'history': history, 'language': language},
    );
    return response.data!['reply'] as String;
  }
}

@riverpod
AssistantRemoteDataSource assistantRemoteDataSource(Ref ref) {
  return AssistantRemoteDataSource(ref.watch(dioProvider));
}
