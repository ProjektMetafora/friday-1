import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:friday/models/transactions.dart';
import 'package:friday/models/transactions_list.dart';
import 'package:friday/providers/providers.dart';
import 'package:friday/services/respository.dart';
import 'package:friday/views/transactions/transactions.view.dart';
import 'package:hooks_riverpod/all.dart';
part 'transaction.vm.freezed.dart';

@freezed
abstract class TransactionState with _$TransactionState{
  const factory TransactionState.loading() = _Loading;
  const factory TransactionState.loaded({List<FridayTransaction> transactions}) = _Loaded;
  const factory TransactionState.empty() = _Error;
}

class TransactionVM extends StateNotifier<TransactionState> {
  AppRepository repo;
  TransactionVM(ProviderReference ref) :  repo = ref.read(appRepositoryProvider), super(TransactionState.loading()) {
    // call method in constructor

    fetchTransactions();
  }

  // add method to api call
  Future<void> fetchTransactions() async {

    final result = await  repo.getTransactions();
    // state = result of api cal
    state = TransactionState.loaded(transactions: result);
  }
}
