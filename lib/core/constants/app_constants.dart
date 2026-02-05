/// Application-wide constants (Turkey locale, +90, routes, assets).
abstract class AppConstants {
  AppConstants._();

  static const String appName = 'nectar';
  static const String appTagline = 'online groceries';

  // Turkey
  static const String defaultLocation = 'İstanbul, Türkiye';
  static const String phoneCountryCode = '+90';
  static const String currencySymbol = '₺';
  static const String currencyCode = 'TL';

  // Routes
  static const String routeSplash = '/';
  static const String routeOnboarding = '/onboarding';
  static const String routeLogin = '/login';
  static const String routeSignUp = '/sign-up';
  static const String routeVerification = '/verification';
  static const String routeHome = '/home';
  static const String routeProductDetail = '/product-detail';
  static const String routeCart = '/cart';
  static const String routeCheckout = '/checkout';
  static const String routeOrderAccepted = '/order-accepted';
  static const String routeAccount = '/account';
  static const String routeExplore = '/explore';
  static const String routeFavorites = '/favorites';

  // Asset paths
  static const String assetSplash = 'assets/app-images/splash Screen.png';
  static const String assetOnboarding = 'assets/app-images/onbording.png';
  static const String assetLogin = 'assets/app-images/log in.png';
  static const String assetSignUp = 'assets/app-images/sign up.png';
  static const String assetVerification = 'assets/app-images/Verification.png';
  static const String assetHome = 'assets/app-images/Home Screen.png';
  static const String assetProductDetail = 'assets/app-images/Product Detail.png';
  static const String assetCart = 'assets/app-images/My Cart.png';
  static const String assetCheckout = 'assets/app-images/Checkout.png';
  static const String assetOrderAccepted = 'assets/app-images/order accepted.png';
  static const String assetAccount = 'assets/app-images/Account.png';
  static const String assetExplore = 'assets/app-images/Explore.png';
  static const String assetFavorites = 'assets/app-images/Favorites.png';

  static const String assetIcSplash = 'assets/images/ic_splash_screen.png';
  static const String assetIcOnboarding = 'assets/images/ic_onboarding_screen.png';
  static const String assetIcAuth = 'assets/images/ic_auth_screen.png';
  static const String assetIcApple = 'assets/images/ic_apple.png';
  static const String assetIcBanana = 'assets/images/ic_banana.png';
  static const String assetIcGinger = 'assets/images/ic_ginger.png';
  static const String assetIcPaprica = 'assets/images/ic_paprica.png';
}
