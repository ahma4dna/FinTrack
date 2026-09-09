import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fintrack/core/data/dao/transactions_daos.dart';
import 'package:fintrack/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late TransactionsDaos dao;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dao = TransactionsDaos(database);
  });

  tearDown(() async {
    await database.close();
  });

  // insertTransaction

  test('insertTransaction should insert expense and decrease wallet balance', () async {
    // Arrange

    final walletId = await database
        .into(database.walletsTable)
        .insert(
          WalletsTableCompanion.insert(
            name: 'Cash',
            balance: const Value(1000),
          ),
        );

    final categoryId = await database
        .into(database.categoriesTable)
        .insert(
          CategoriesTableCompanion.insert(
            name: 'Food',
            type: 'expense',
            iconName: 'food',
            categoryColor: '#FF0000',
          ),
        );

    final transaction = TransactionsTableCompanion.insert(
      walletId: walletId,
      categoryId: categoryId,
      amount: 200,
      type: 'expense',
      date: DateTime.now(),
      title: 'Salary',
    );

    // Act

    final transactionId = await dao.insertTransaction(transaction);

    // Assert

    expect(transactionId, greaterThan(0));

    final transactions = await database.select(database.transactionsTable).get();

    expect(transactions.length, 1);
    expect(transactions.first.amount, 200);
    expect(transactions.first.type, 'expense');

    final wallet = await (database.select(database.walletsTable)..where((w) => w.id.equals(walletId))).getSingle();

    expect(wallet.balance, 800);
  });

  test('insertTransaction should insert income and increase wallet balance', () async {
    // Arrange

    final walletId = await database
        .into(database.walletsTable)
        .insert(
          WalletsTableCompanion.insert(
            name: 'Bank',
            balance: const Value(1000),
          ),
        );

    final categoryId = await database
        .into(database.categoriesTable)
        .insert(
          CategoriesTableCompanion.insert(
            name: 'Salary',
            type: 'income',
            iconName: 'salary',
            categoryColor: '#00FF00',
          ),
        );

    final transaction = TransactionsTableCompanion.insert(
      walletId: walletId,
      categoryId: categoryId,
      amount: 500,
      type: 'income',
      date: DateTime.now(),
      title: 'Salary',
    );

    // Act

    final transactionId = await dao.insertTransaction(transaction);

    // Assert

    expect(transactionId, greaterThan(0));

    final wallet = await (database.select(database.walletsTable)..where((w) => w.id.equals(walletId))).getSingle();

    expect(wallet.balance, 1500);
  });

  // watchByWallet

  test('watchByWallet should return transactions with details', () async {
    // Arrange

    final walletId = await database
        .into(database.walletsTable)
        .insert(
          WalletsTableCompanion.insert(
            name: 'Cash',
            balance: const Value(1000),
          ),
        );

    final categoryId = await database
        .into(database.categoriesTable)
        .insert(
          CategoriesTableCompanion.insert(
            name: 'Food',
            type: 'expense',
            iconName: 'food',
            categoryColor: '#FF0000',
          ),
        );

    final transaction = TransactionsTableCompanion.insert(
      walletId: walletId,
      categoryId: categoryId,
      amount: 200,
      type: 'expense',
      date: DateTime(2026, 9, 5),
      title: 'Salary',
    );

    await dao.insertTransaction(transaction);

    // Act

    final result = await dao.watchByWallet(walletId).first;

    // Assert

    expect(result.length, 1);

    final item = result.first;

    expect(item.transaction.amount, 200);
    expect(item.transaction.type, 'expense');

    expect(item.walletName, 'Cash');
    expect(item.categoryName, 'Food');
    expect(item.categoryIcon, 'food');
    expect(item.categoryColor, '#FF0000');
  });

  test('watchByWallet should return empty list when wallet has no transactions', () async {
    // Arrange

    final walletId = await database
        .into(database.walletsTable)
        .insert(
          WalletsTableCompanion.insert(
            name: 'Cash',
            balance: const Value(1000),
          ),
        );

    // Act

    final result = await dao.watchByWallet(walletId).first;

    // Assert

    expect(result, isEmpty);
  });

  test('watchByWallet should return transactions ordered by date descending', () async {
    // Arrange

    final walletId = await database
        .into(database.walletsTable)
        .insert(
          WalletsTableCompanion.insert(
            name: 'Cash',
            balance: const Value(1000),
          ),
        );

    final categoryId = await database
        .into(database.categoriesTable)
        .insert(
          CategoriesTableCompanion.insert(
            name: 'Food',
            type: 'expense',
            iconName: 'food',
            categoryColor: '#FF0000',
          ),
        );

    await dao.insertTransaction(
      TransactionsTableCompanion.insert(
        walletId: walletId,
        categoryId: categoryId,
        amount: 100,
        type: 'expense',
        date: DateTime(2026, 9, 1),
        title: 'Salary',
      ),
    );

    await dao.insertTransaction(
      TransactionsTableCompanion.insert(
        walletId: walletId,
        categoryId: categoryId,
        amount: 300,
        type: 'expense',
        date: DateTime(2026, 9, 5),
        title: 'Salary',
      ),
    );

    // Act

    final result = await dao.watchByWallet(walletId).first;

    // Assert

    expect(result.length, 2);

    expect(result[0].transaction.amount, 300);
    expect(result[1].transaction.amount, 100);
  });

  // deleteTransaction

  test('deleteTransaction should delete expense and restore wallet balance', () async {
    // Arrange

    final walletId = await database
        .into(database.walletsTable)
        .insert(
          WalletsTableCompanion.insert(
            name: 'Cash',
            balance: const Value(1000),
          ),
        );

    final categoryId = await database
        .into(database.categoriesTable)
        .insert(
          CategoriesTableCompanion.insert(
            name: 'Food',
            type: 'expense',
            iconName: 'food',
            categoryColor: '#FF0000',
          ),
        );

    final transactionId = await dao.insertTransaction(
      TransactionsTableCompanion.insert(
        walletId: walletId,
        categoryId: categoryId,
        amount: 200,
        type: 'expense',
        date: DateTime.now(),
        title: 'Salary',
      ),
    );

    // تأكد أن الرصيد أصبح 800
    var wallet = await (database.select(database.walletsTable)..where((w) => w.id.equals(walletId))).getSingle();

    expect(wallet.balance, 800);

    // Act

    await dao.deleteTransaction(transactionId);

    // Assert

    wallet = await (database.select(database.walletsTable)..where((w) => w.id.equals(walletId))).getSingle();

    expect(wallet.balance, 1000);

    final transactions = await database.select(database.transactionsTable).get();

    expect(transactions, isEmpty);
  });

  test('deleteTransaction should delete income and restore wallet balance', () async {
    // Arrange

    final walletId = await database
        .into(database.walletsTable)
        .insert(
          WalletsTableCompanion.insert(
            name: 'Bank',
            balance: const Value(1000),
          ),
        );

    final categoryId = await database
        .into(database.categoriesTable)
        .insert(
          CategoriesTableCompanion.insert(
            name: 'Salary',
            type: 'income',
            iconName: 'salary',
            categoryColor: '#00FF00',
          ),
        );

    final transactionId = await dao.insertTransaction(
      TransactionsTableCompanion.insert(
        walletId: walletId,
        categoryId: categoryId,
        amount: 500,
        type: 'income',
        date: DateTime.now(),
        title: 'Salary',
      ),
    );

    // الرصيد أصبح 1500

    var wallet = await (database.select(database.walletsTable)..where((w) => w.id.equals(walletId))).getSingle();

    expect(wallet.balance, 1500);

    // Act

    await dao.deleteTransaction(transactionId);

    // Assert

    wallet = await (database.select(database.walletsTable)..where((w) => w.id.equals(walletId))).getSingle();

    expect(wallet.balance, 1000);

    final transactions = await database.select(database.transactionsTable).get();

    expect(transactions, isEmpty);
  });

  test(
    "4 cat conts",
    () async {
      final cat = await dao.getCategory();
      expect(cat.length, 4);
    },
  );
}
