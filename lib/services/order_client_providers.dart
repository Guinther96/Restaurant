import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_ordering_client/core/constants/app_constants.dart';

import 'order_client_api_service.dart';

final backendBaseUrlProvider = Provider<String>((ref) {
  return AppConstants.apiBaseUrl;
});

final restaurantIdProvider = Provider<String>((ref) {
  return '11111111-1111-1111-1111-111111111111';
});

final orderClientApiServiceProvider = Provider<OrderClientApiService>((ref) {
  final baseUrl = ref.watch(backendBaseUrlProvider);
  final service = OrderClientApiService(baseUrl: baseUrl);
  ref.onDispose(service.dispose);
  return service;
});

/// FutureProvider exposing the menu DTOs from [OrderClientApiService].
/// Named [clientMenuProvider] to avoid conflicts with the ordering feature's
/// [menuProvider] StateNotifierProvider.
final clientMenuProvider = FutureProvider<List<MenuItemDto>>((ref) async {
  final service = ref.watch(orderClientApiServiceProvider);
  final restaurantId = ref.watch(restaurantIdProvider);
  return service.fetchMenu(restaurantId);
});

/// FutureProvider exposing the restaurant tables from [OrderClientApiService].
final clientTablesProvider = FutureProvider<List<TableDto>>((ref) async {
  final service = ref.watch(orderClientApiServiceProvider);
  final restaurantId = ref.watch(restaurantIdProvider);
  return service.fetchTables(restaurantId);
});
