class Profile {
  String name;
  String avatarBase64;

  Profile({required this.name, required this.avatarBase64});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      avatarBase64: json['avatarBase64'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatarBase64': avatarBase64,
    };
  }
}
