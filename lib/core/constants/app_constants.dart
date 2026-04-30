class AppConstants {
  const AppConstants._();

  static const String appName = 'Commande à table';
  static const String apiBaseUrl = 'http://localhost:3000';

  // Basculer à false pour utiliser le backend réel.
  static const bool useMockData = false;

  static const Duration orderPollingInterval = Duration(seconds: 5);
}
