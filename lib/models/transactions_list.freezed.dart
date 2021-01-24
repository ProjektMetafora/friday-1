// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'transactions_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
TransactionsList _$TransactionsListFromJson(Map<String, dynamic> json) {
  return _TransactionsList.fromJson(json);
}

/// @nodoc
class _$TransactionsListTearOff {
  const _$TransactionsListTearOff();

// ignore: unused_element
  _TransactionsList call(
      {@JsonKey(name: 'transaction_history')
          List<FridayTransaction> transactions}) {
    return _TransactionsList(
      transactions: transactions,
    );
  }

// ignore: unused_element
  TransactionsList fromJson(Map<String, Object> json) {
    return TransactionsList.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $TransactionsList = _$TransactionsListTearOff();

/// @nodoc
mixin _$TransactionsList {
  @JsonKey(name: 'transaction_history')
  List<FridayTransaction> get transactions;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $TransactionsListCopyWith<TransactionsList> get copyWith;
}

/// @nodoc
abstract class $TransactionsListCopyWith<$Res> {
  factory $TransactionsListCopyWith(
          TransactionsList value, $Res Function(TransactionsList) then) =
      _$TransactionsListCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'transaction_history')
          List<FridayTransaction> transactions});
}

/// @nodoc
class _$TransactionsListCopyWithImpl<$Res>
    implements $TransactionsListCopyWith<$Res> {
  _$TransactionsListCopyWithImpl(this._value, this._then);

  final TransactionsList _value;
  // ignore: unused_field
  final $Res Function(TransactionsList) _then;

  @override
  $Res call({
    Object transactions = freezed,
  }) {
    return _then(_value.copyWith(
      transactions: transactions == freezed
          ? _value.transactions
          : transactions as List<FridayTransaction>,
    ));
  }
}

/// @nodoc
abstract class _$TransactionsListCopyWith<$Res>
    implements $TransactionsListCopyWith<$Res> {
  factory _$TransactionsListCopyWith(
          _TransactionsList value, $Res Function(_TransactionsList) then) =
      __$TransactionsListCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'transaction_history')
          List<FridayTransaction> transactions});
}

/// @nodoc
class __$TransactionsListCopyWithImpl<$Res>
    extends _$TransactionsListCopyWithImpl<$Res>
    implements _$TransactionsListCopyWith<$Res> {
  __$TransactionsListCopyWithImpl(
      _TransactionsList _value, $Res Function(_TransactionsList) _then)
      : super(_value, (v) => _then(v as _TransactionsList));

  @override
  _TransactionsList get _value => super._value as _TransactionsList;

  @override
  $Res call({
    Object transactions = freezed,
  }) {
    return _then(_TransactionsList(
      transactions: transactions == freezed
          ? _value.transactions
          : transactions as List<FridayTransaction>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_TransactionsList implements _TransactionsList {
  const _$_TransactionsList(
      {@JsonKey(name: 'transaction_history') this.transactions});

  factory _$_TransactionsList.fromJson(Map<String, dynamic> json) =>
      _$_$_TransactionsListFromJson(json);

  @override
  @JsonKey(name: 'transaction_history')
  final List<FridayTransaction> transactions;

  @override
  String toString() {
    return 'TransactionsList(transactions: $transactions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TransactionsList &&
            (identical(other.transactions, transactions) ||
                const DeepCollectionEquality()
                    .equals(other.transactions, transactions)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(transactions);

  @JsonKey(ignore: true)
  @override
  _$TransactionsListCopyWith<_TransactionsList> get copyWith =>
      __$TransactionsListCopyWithImpl<_TransactionsList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TransactionsListToJson(this);
  }
}

abstract class _TransactionsList implements TransactionsList {
  const factory _TransactionsList(
      {@JsonKey(name: 'transaction_history')
          List<FridayTransaction> transactions}) = _$_TransactionsList;

  factory _TransactionsList.fromJson(Map<String, dynamic> json) =
      _$_TransactionsList.fromJson;

  @override
  @JsonKey(name: 'transaction_history')
  List<FridayTransaction> get transactions;
  @override
  @JsonKey(ignore: true)
  _$TransactionsListCopyWith<_TransactionsList> get copyWith;
}
