import 'package:smart_moves/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:smart_moves/features/global/core/interceptors/auth_interceptor.dart';
import 'package:smart_moves/features/global/core/interceptors/refresh_token_interceptor.dart';
import 'package:smart_moves/features/global/storage/token_storage.dart';
import 'package:smart_moves/features/global/storage/token_storage_impl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:smart_moves/service_locator.dart';
import 'features/global/core/network/api_client.dart';
import 'features/global/core/network/network_info.dart';

Future<void> init() async {
  //connectivity
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  //network info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  //google sign in
  // final googleSignIn = GoogleSignIn.instance;
  // await googleSignIn.initialize(
  //   serverClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID'],
  // );
  // sl.registerLazySingleton(() => googleSignIn);

  // flutter secure storage
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());

  // token storage
  sl.registerLazySingleton<TokenStorage>(
    () => TokenStorageImpl(sl<FlutterSecureStorage>()),
  );
  //interceptors
  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(localDataSource: sl<AuthLocalDataSource>()),
  );
  sl.registerLazySingleton<RefreshTokenInterceptor>(
    () => RefreshTokenInterceptor(sl<AuthLocalDataSource>()),
  );
  //dio
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();

    final authInterceptor = sl<AuthInterceptor>();
    final refreshInterceptor = sl<RefreshTokenInterceptor>();

    refreshInterceptor.dio = dio;

    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(refreshInterceptor);

    return dio;
  });

  // api client
  sl.registerLazySingleton<ApiClient>(() {
    return ApiClient(sl<Dio>(), sl<NetworkInfo>());
  });

  // await authInjectionContainer();
  // await adminInjectionContainer();
  // await lecturerInjectionContainer();
  // await studentInjectionContainer();
}

// note for me: you create an instance when it's something coming from the outside, like google sign in, dio, connectivity, flutter secure storage. You don't create an instance for your own classes, you just register them.
// AuthInterceptor needs AuthLocalDataSource so it can: read access token → attach Authorization header
// RefreshTokenInterceptor needs two things: 1️⃣ AuthLocalDataSource → read/write tokens 2️⃣ Dio → retry the failed request
// I think it's weird that the interceptors are taking dio and localdatasource as constructors and hence 'datasource' being mentioned in the main_injection_container.dart file, But notice something important: I did not register the data source here, I only requested it.
