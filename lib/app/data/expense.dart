class Expense {
  late final int id;
  late final String userId;
  late final int account;
  late final int expenseCategory;
  late final double amount;
  late final String remarks;
  late final String? fileUrl;
  late final DateTime createdAt;
  late final DateTime updatedAt;

  Expense({
    required this.id,
    required this.userId,
    required this.account,
    required this.expenseCategory,
    required this.amount,
    required this.remarks,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  Expense.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    userId = json['user_id'] as String;
    account = json['account'] as int;
    expenseCategory = json['expense_category'] as int;
    amount = json['amount'] as double;
    remarks = json['remarks'] as String;
    fileUrl = json['file_url'] as String?;
    createdAt = DateTime.parse(json['created_at'] as String);
    updatedAt = DateTime.parse(json['updated_at'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['account'] = account;
    data['expense_category'] = expenseCategory;
    data['amount'] = amount;
    data['remarks'] = remarks;
    data['file_url'] = fileUrl;
    data['created_at'] = createdAt.toIso8601String();
    data['updated_at'] = updatedAt.toIso8601String();
    return data;
  }
}
