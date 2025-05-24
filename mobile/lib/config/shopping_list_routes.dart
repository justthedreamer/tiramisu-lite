import 'package:mobile/config/route_aggregate.dart';

class ShoppingListRoutes extends RouteAggregate {
  ShoppingListRoutes({required super.baseUrl});

  Uri fetch(String profileName) =>
      Uri.parse('$baseUrl/profiles/$profileName/shopping-lists');

  Uri fetchById(String profileName, String id) =>
      Uri.parse('$baseUrl/profiles/$profileName/shopping-lists/$id');

  Uri create(String profileName) =>
      Uri.parse('$baseUrl/profiles/$profileName/shopping-lists');

  Uri update(String profileName, String id) =>
      Uri.parse('$baseUrl/profiles/$profileName/shopping-lists/$id');

  Uri delete(String profileName, String id) =>
      Uri.parse('$baseUrl/profiles/$profileName/shopping-lists/$id');
}