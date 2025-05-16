class Planer {
  final String id;
  final List<String> planerItems;

  Planer({required this.id, required this.planerItems});

  factory Planer.fromJson(Map<String, dynamic> json) {
    return Planer(
      id: json['id'],
      planerItems: List<String>.from(json['planerItems']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'planerItems': planerItems,
    };
  }
}
