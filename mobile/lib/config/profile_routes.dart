import 'package:mobile/config/route_aggregate.dart';

class ProfileRoutes extends RouteAggregate {
  ProfileRoutes({required super.baseUrl});

  Uri fetch() => Uri.parse('$baseUrl/profiles');

  Uri create() => fetch();

  Uri update(String profileName) => Uri.parse('$baseUrl/profiles/$profileName');

  Uri delete(String profileName) => update(profileName);
}