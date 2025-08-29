/// Callback type for invalidating providers during logout
typedef ProviderInvalidationCallback = void Function();

/// Service responsible for coordinating provider invalidation during logout
/// Uses callback approach to avoid circular dependencies
abstract class ProviderInvalidationService {
  /// Invalidates all user and admin related providers during logout
  void invalidateUserRelatedProviders();

  /// Sets the callback function that will be called to invalidate providers
  void setInvalidationCallback(ProviderInvalidationCallback callback);
}

class ProviderInvalidationServiceImpl implements ProviderInvalidationService {
  ProviderInvalidationCallback? _invalidationCallback;

  @override
  void setInvalidationCallback(ProviderInvalidationCallback callback) {
    _invalidationCallback = callback;
  }

  @override
  void invalidateUserRelatedProviders() {
    try {
      _invalidationCallback?.call();
    } catch (e) {
      // Log error but don't throw to avoid breaking logout process
      print(
        'Warning: Some providers could not be invalidated during logout: $e',
      );
    }
  }
}
