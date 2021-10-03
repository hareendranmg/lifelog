class AppUser {
  late final String id;
  late final String name;
  late final int? mobileNumber;
  late final String? email;
  late final String? avatarUrl;
  late final DateTime updatedAt;
  late final DateTime createdAt;
  AppUser({
    required this.id,
    required this.name,
    this.mobileNumber,
    this.email,
    this.avatarUrl,
    required this.updatedAt,
    required this.createdAt,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    mobileNumber = json['mobile_number'] as int?;
    email = json['email'] as String?;
    avatarUrl = json['avatar_url'] as String?;
    updatedAt = DateTime.parse(json['updated_at'] as String);
    createdAt = DateTime.parse(json['created_at'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile_number'] = mobileNumber;
    data['email'] = email;
    data['avatar_url'] = avatarUrl;
    data['updated_at'] = updatedAt.toIso8601String();
    data['created_at'] = createdAt.toIso8601String();
    return data;
  }
}
