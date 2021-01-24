// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TransactionsList _$_$_TransactionsListFromJson(Map<String, dynamic> json) {
  return _$_TransactionsList(
    transactions: (json['transaction_history'] as List)
        ?.map((e) => e == null
            ? null
            : FridayTransaction.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_TransactionsListToJson(
        _$_TransactionsList instance) =>
    <String, dynamic>{
      'transaction_history': instance.transactions,
    };
