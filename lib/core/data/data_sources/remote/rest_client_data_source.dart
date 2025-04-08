import 'package:dio/dio.dart';

import '../../../core.dart';

class RestClientDataSource {
  RestClientDataSource(
    String baseUrl, {
    Json? headers,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: '$baseUrl${baseUrl.endsWith('/') ? '' : '/'}',
            headers: headers,
            connectTimeout: const Duration(minutes: 1),
            sendTimeout: const Duration(minutes: 1),
            receiveTimeout: const Duration(minutes: 1),
          ),
        );

  final Dio _dio;

  Future<Either<T>> get<T>(
    String path, {
    JsonResponseDecoder<T>? jsonDecoder,
    JsonListResponseDecoder<T>? jsonListDecoder,
    Json? queryParameters,
  }) =>
      _httpRequest<T>(
        exec: () => _dio.get<dynamic>(
          path,
          queryParameters: queryParameters,
        ),
        jsonDecoder: jsonDecoder,
        jsonListDecoder: jsonListDecoder,
      );

  Future<Either<T>> _httpRequest<T>({
    required Future<Response<dynamic>> Function() exec,
    JsonResponseDecoder<T>? jsonDecoder,
    JsonListResponseDecoder<T>? jsonListDecoder,
  }) async {
    assert(
      jsonDecoder != null || jsonListDecoder != null,
      'At least one decoder should be set.',
    );

    Either<T>? result;

    try {
      final Response<dynamic> response = await exec();

      result = Either<T>.l(
        response.data is List
            ? jsonListDecoder!
                .call((response.data as List<dynamic>).cast<Json>())
            : jsonDecoder!.call(response.data as Json),
      );
    } on DioException catch (e) {
      result = Either<T>.r(Failure.fromException(e));
    }

    return result;
  }
}
