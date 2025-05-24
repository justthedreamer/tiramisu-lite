import 'package:mobile/config/route_aggregate.dart';

class PlanerItemRoutes extends RouteAggregate {
  PlanerItemRoutes({required super.baseUrl});

  Uri fetchItems(String profileName) =>
      Uri.parse('$baseUrl/profiles/$profileName/planer/items');

  Uri createItem(String profileName) =>
      Uri.parse('$baseUrl/profiles/$profileName/planer/items');

  Uri fetchItem(String profileName, String itemId) =>
      Uri.parse('$baseUrl/profiles/$profileName/planer/items/$itemId');

  Uri updateItem(String profileName, String itemId) =>
      Uri.parse('$baseUrl/profiles/$profileName/planer/items/$itemId');

  Uri deleteItem(String profileName, String itemId) =>
      Uri.parse('$baseUrl/profiles/$profileName/planer/items/$itemId');
}
