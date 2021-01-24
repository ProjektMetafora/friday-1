import 'package:freezed_annotation/freezed_annotation.dart';
part 'transactions.freezed.dart';
part 'transactions.g.dart';

@freezed
abstract class FridayTransaction with _$FridayTransaction {
  const factory FridayTransaction({
    @JsonKey (name: '_id') String transactionId,
    @JsonKey(name: 'merchant_name') String merchantStatus,
    @JsonKey(name: 'amount') double amount,
    @JsonKey(name: 'customer_id') String customerId,
    @JsonKey(name: 'status') String transactionStatus ,
    @JsonKey (name: 'transaction_status') DateTime date,
    @JsonKey(name: 'type') String transactionType,
    @JsonKey(name: 'card_id') String cardId

  }) = _FridayTransaction;

  factory FridayTransaction.fromJson(Map<String, dynamic> json) => _$FridayTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$_$_FridayTransactionToJson(this);
}
