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
      // If not authenticated, redirect to the Login page and prevent navigation.
      router.pushAndPopUntil(const LoginRoute(), predicate: (_) => false);
      resolver.next(false);
    }
  }
}
