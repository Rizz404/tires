import 'package:auto_route/auto_route.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/core/storage/session_storage_service.dart';
import 'package:tires/features/user/domain/entities/user.dart';

class AuthGuard extends AutoRouteGuard {
  final SessionStorageService _sessionStorageService;

  AuthGuard(this._sessionStorageService);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final accessToken = await _sessionStorageService.getAccessToken();
    final isAuthenticated = accessToken != null && accessToken.isNotEmpty;

    if (!isAuthenticated) {
      // Jika tidak login, paksa ke halaman login dan hentikan navigasi saat ini.
      await router.replaceAll([const LoginRoute()]);
      return;
    }

    // Jika sudah login, periksa peran pengguna.
    final user = await _sessionStorageService.getUser();
    final isAdmin = user?.role == UserRole.admin;
    final isTargetingAdminRoute = resolver.route.path.startsWith('/admin');

    if (isAdmin && !isTargetingAdminRoute) {
      // Jika pengguna adalah admin tetapi mencoba mengakses rute non-admin (misalnya rute awal '/'),
      // alihkan mereka ke dashboard admin.
      await router.replaceAll([const AdminTabRoute()]);
      return;
    }

    if (!isAdmin && isTargetingAdminRoute) {
      // Jika pengguna bukan admin tetapi mencoba mengakses rute admin,
      // alihkan mereka ke home screen pengguna biasa.
      await router.replaceAll([const UserTabRoute()]);
      return;
    }

    // Jika semua kondisi di atas tidak terpenuhi, navigasi diizinkan.
    // Contoh: Admin mengakses rute admin, atau Customer mengakses rute customer.
    resolver.next(true);
  }
}
