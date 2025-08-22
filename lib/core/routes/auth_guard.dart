import 'package:auto_route/auto_route.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/storage/session_storage_service.dart';

class AuthGuard extends AutoRouteGuard {
  final SessionStorageService _sessionStorageService;

  AuthGuard(this._sessionStorageService);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    try {
      final accessToken = await _sessionStorageService.getAccessToken();

      // Debug print untuk memastikan token
      print('AuthGuard - Access Token: $accessToken');

      if (accessToken != null && accessToken.isNotEmpty) {
        print('AuthGuard - User authenticated, allowing navigation');
        resolver.next(true);
      } else {
        print('AuthGuard - User not authenticated, redirecting to login');
        // Redirect ke login dan clear navigation stack
        await router.push(const LoginRoute());
        resolver.next(false);
      }
    } catch (e) {
      print('AuthGuard - Error checking authentication: $e');
      // Jika error, redirect ke login untuk safety
      await router.pushAndPopUntil(const LoginRoute(), predicate: (_) => false);
      resolver.next(false);
    }
  }
}
