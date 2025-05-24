import 'package:mobile/config/planer_item_routes.dart';
import 'package:mobile/config/planer_routes.dart';
import 'package:mobile/config/profile_routes.dart';
import 'package:mobile/config/shopping_list_item_routes.dart';
import 'package:mobile/config/shopping_list_routes.dart';

class Routes {
  final String baseUrl;

  Routes({required this.baseUrl});

  ProfileRoutes get profile => ProfileRoutes(baseUrl: baseUrl);

  PlanerRoutes get planer => PlanerRoutes(baseUrl: baseUrl);

  ShoppingListRoutes get shoppingList => ShoppingListRoutes(baseUrl: baseUrl);

  ShoppingListItemRoutes get shoppingListItems =>
      ShoppingListItemRoutes(baseUrl: baseUrl);

  PlanerItemRoutes get planerItem => PlanerItemRoutes(baseUrl: baseUrl);
}
