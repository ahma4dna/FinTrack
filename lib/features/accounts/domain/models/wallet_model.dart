class WalletModel {
  final int? id;
  final String name;
  final String type; // cash, bank, credit_card, savings
  final double balance;
  final String iconName;
  final int sortOrder;
  final bool isArchived;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const WalletModel({
    this.id,
    required this.name,
    this.type = 'cash',
    this.balance = 0.0,
    this.iconName = 'wallet',
    this.sortOrder = 0,
    this.isArchived = false,
    this.createdAt,
    this.updatedAt,
  });

  WalletModel copyWith({
    int? id,
    String? name,
    String? type,
    double? balance,
    String? iconName,
    int? sortOrder,
    bool? isArchived,
  }) {
    return WalletModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      balance: balance ?? this.balance,
      iconName: iconName ?? this.iconName,
      sortOrder: sortOrder ?? this.sortOrder,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
