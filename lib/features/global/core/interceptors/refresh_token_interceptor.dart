import 'dart:async';

import 'package:dio/dio.dart';
import 'package:smart_moves/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:smart_moves/features/global/core/config/flavor_config.dart';
import 'package:smart_moves/features/global/core/network/api_endpoints.dart';

class RefreshTokenInterceptor extends Interceptor {
  final AuthLocalDataSource localDataSource;

  late Dio dio;

  final Dio refreshClient = Dio();

  bool _isRefreshing = false;
  Completer<String>? _refreshCompleter;

  RefreshTokenInterceptor(this.localDataSource) {
    refreshClient.options.baseUrl = FlavorConfig.instance.baseApiUrl;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode != 401) {
      return handler.next(err);
    }

    // Prevent infinite loop
    if (err.requestOptions.path.contains('refresh-token')) {
      return handler.next(err);
    }

    // Queue concurrent 401s — wait for the in-flight refresh instead of failing
    if (_isRefreshing) {
      try {
        final newToken = await _refreshCompleter!.future;
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        return handler.resolve(await dio.fetch(err.requestOptions));
      } catch (_) {
        return handler.next(err);
      }
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<String>();

    try {
      final refreshToken = await localDataSource.getRefreshToken();

      if (refreshToken == null) {
        await localDataSource.logout();
        _refreshCompleter!.completeError('no_refresh_token');
        return handler.next(err);
      }

      final response = await refreshClient.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      final newAccess = response.data['accessToken'] as String;
      final newRefresh = response.data['refreshToken'] as String;

      await localDataSource.saveAccessToken(newAccess);
      await localDataSource.saveRefreshToken(newRefresh);

      _refreshCompleter!.complete(newAccess);

      err.requestOptions.headers['Authorization'] = 'Bearer $newAccess';
      final cloneResponse = await dio.fetch(err.requestOptions);

      return handler.resolve(cloneResponse);
    } catch (e) {
      _refreshCompleter!.completeError(e);
      await localDataSource.logout();
      return handler.next(err);
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }
}
