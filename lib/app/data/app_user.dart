class AppUser {
  String? id;
  String? name;
  int? mobileNumber;
  String? email;
  String? avatarUrl;
  DateTime? updatedAt;
  DateTime? createdAt;
  AppUser({
    this.id,
    this.name,
    this.mobileNumber,
    this.email,
    this.avatarUrl,
    this.updatedAt,
    this.createdAt,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    mobileNumber = json['mobile_number'] as int?;
    email = json['email'] as String?;
    avatarUrl = json['avatar_url'] as String?;
    updatedAt = DateTime.tryParse(json['updated_at'] as String);
    createdAt = DateTime.tryParse(json['created_at'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile_number'] = mobileNumber;
    data['email'] = email;
    data['avatar_url'] = avatarUrl;
    data['updated_at'] = updatedAt?.toIso8601String();
    data['created_at'] = createdAt?.toIso8601String();
    return data;
  }
}
