import 'package:mobile/model/planer_item.dart';

class Planer {
  final String id;
  final List<PlanerItem> items;

  Planer({required this.id, required this.items});

  factory Planer.fromJson(Map<String, dynamic> json) {
    return Planer(
      id: json['id'],
      items:
          (json['items'] as List)
              .map((item) => PlanerItem.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'planerItems': items};
  }
}
