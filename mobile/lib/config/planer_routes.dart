import 'package:mobile/config/route_aggregate.dart';

class PlanerRoutes extends RouteAggregate {
  PlanerRoutes({required super.baseUrl});

  Uri fetch(String profileName) =>
      Uri.parse('$baseUrl/profiles/$profileName/planer');

  Uri fetchItems(String profileName) =>
      Uri.parse('$baseUrl/profiles/$profileName/planer/items');

  Uri fetchItem(String profileName, String itemId) =>
      Uri.parse('$baseUrl/profiles/$profileName/planer/$itemId');

  Uri createItem(String profileName) =>
      Uri.parse('$baseUrl/profiles/$profileName/planer/items');

  Uri updateItem(String profileName, String itemId) =>
      Uri.parse('$baseUrl/profiles/$profileName/planer/items/$itemId');

  Uri deleteItem(String profileName, String itemId) =>
      Uri.parse('$baseUrl/profiles/$profileName/planer/items/$itemId');
}