import 'package:auto_route/auto_route.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/storage/session_storage_service.dart';

class AuthGuard extends AutoRouteGuard {
  final SessionStorageService _sessionStorageService;

  AuthGuard(this._sessionStorageService);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final accessToken = await _sessionStorageService.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      resolver.next(true);
    } else {
      // Selalu redirect ke UserTabRoute (home) untuk unauthenticated users
      // User tetap bisa akses home, tapi untuk fitur yang perlu auth
      // akan diminta login di level component/screen
      router.pushAndPopUntil(const UserTabRoute(), predicate: (_) => false);
      resolver.next(false);
    }
  }
}
