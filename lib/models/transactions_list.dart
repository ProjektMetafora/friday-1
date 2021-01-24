import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:friday/models/transactions.dart';
part 'transactions_list.freezed.dart';
part 'transactions_list.g.dart';

@freezed
abstract class TransactionsList  with _$TransactionsList {
  const factory TransactionsList({
    @JsonKey(name: 'transaction_history') List<FridayTransaction> transactions,
  }) = _TransactionsList;

  factory TransactionsList.fromJson(Map<String, dynamic> json) => _$TransactionsListFromJson(json);

  Map<String, dynamic> toJson() => _$_$_TransactionsListToJson(this);
}
