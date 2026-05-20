// import 'package:attend/features/auth/data/data_sources/local/auth_local_data_source.dart';
// import 'package:attend/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
// import 'package:attend/features/auth/domain/entities/user_entity.dart';
// import 'package:attend/features/global/enums/role.dart';
// import '../../domain/entities/auth_entity.dart';
// import '../../domain/repositories/auth_repository.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final AuthRemoteDataSource remoteDataSource;
//   final AuthLocalDataSource localDataSource;

//   AuthRepositoryImpl({
//     required this.remoteDataSource,
//     required this.localDataSource,
//   });

//   Future<(AuthEntity, UserEntity)> _saveAndReturn(
//     Future<(AuthEntity, UserEntity)> Function() call,
//   ) async {
//     final result = await call();
//     final auth = result.$1;
//     final user = result.$2;
//     await localDataSource.saveAccessToken(auth.accessToken);
//     await localDataSource.saveRefreshToken(auth.refreshToken);
//     await localDataSource.saveRole(user.role.name);
//     await localDataSource.saveUserData(user.userId, user.name, user.email);
//     return result;
//   }

//   @override
//   Future<(AuthEntity, UserEntity)> continueWithGoogle() =>
//       _saveAndReturn(remoteDataSource.continueWithGoogle);

//   @override
//   Future<(AuthEntity, UserEntity)> continueWithApple() =>
//       _saveAndReturn(remoteDataSource.continueWithApple);

//   @override
//   Future<(AuthEntity, UserEntity)> registerWithEmailPassword(
//     String name,
//     String email,
//     String password,
//   ) => _saveAndReturn(
//     () => remoteDataSource.registerWithEmailPassword(name, email, password),
//   );

//   @override
//   Future<(AuthEntity, UserEntity)> loginWithEmailPassword(
//     String email,
//     String password,
//   ) => _saveAndReturn(
//     () => remoteDataSource.loginWithEmailPassword(email, password),
//   );

//   @override
//   Future<(AuthEntity, UserEntity)> verifyLinkAccount(
//     String otp,
//     String email,
//     String password, {
//     String? name,
//   }) => _saveAndReturn(
//     () => remoteDataSource.verifyLinkAccount(otp, email, password, name: name),
//   );

//   @override
//   Future<void> forgotPassword(String email) =>
//       remoteDataSource.forgotPassword(email);

//   @override
//   Future<void> resetPassword(String otp, String email, String newPassword) =>
//       remoteDataSource.resetPassword(otp, email, newPassword);

//   @override
//   Future<void> logout() async {
//     final refreshToken = await localDataSource.getRefreshToken();

//     if (refreshToken != null) {
//       try {
//         await remoteDataSource.logout(refreshToken);
//       } catch (_) {
//         // Handle logout failure, e.g., log the error or ignore it
//       }
//       await localDataSource.logout();
//     }
//   }

//   @override
//   Future<void> deleteAccount() async {
//     final roleStr = await localDataSource.getRole();
//     final role = Role.values.firstWhere((r) => r.name == roleStr);
//     await remoteDataSource.deleteAccount(role);
//     await localDataSource.logout();
//   }

//   @override
//   Future<UserEntity?> getStoredUser() => localDataSource.getStoredUser();
// }
