class Account {
  late final int id;
  late final String userId;
  late final String name;
  late final double amount;
  late final String remarks;
  late final String? iconUrl;
  late final DateTime createdAt;
  late final DateTime updatedAt;

  Account({
    required this.id,
    required this.userId,
    required this.name,
    required this.amount,
    required this.remarks,
    required this.iconUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    userId = json['user_id'] as String;
    name = json['name'] as String;
    amount = json['amount'] as double;
    remarks = json['remarks'] as String;
    iconUrl = json['icon_url'] as String?;
    createdAt = DateTime.parse(json['created_at'] as String);
    updatedAt = DateTime.parse(json['updated_at'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['amount'] = amount;
    data['remarks'] = remarks;
    data['icon_url'] = iconUrl;
    data['created_at'] = createdAt.toIso8601String();
    data['updated_at'] = updatedAt.toIso8601String();
    return data;
  }
}
