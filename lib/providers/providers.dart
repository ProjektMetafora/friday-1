import 'package:friday/services/respository.dart';
import 'package:friday/views/auth/auth.vm.dart';
import 'package:friday/views/onboarding/onboarding.vm.dart';
import 'package:friday/views/transactions/transaction.vm.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:friday/models/transactions.dart';


// import '../views/auth/auth.vm.dart';

/// Repository provider to access repoistory methods.
final appRepositoryProvider = Provider<AppRepository>((ref) => AppRepository());

final onBoardProvider =  StateNotifierProvider<OnBoardingVM>((ref) => OnBoardingVM(ref));

/// Auth provider to acess authentication state.
final authProvider = StateNotifierProvider<AuthVM>((ref) => AuthVM(ref));

final transactionProvider = StateNotifierProvider<TransactionVM>((ref) => TransactionVM(ref));


final creditProvider = Provider<List<FridayTransaction>>((ref) {
  final transaction = ref.watch(transactionProvider.state);
  return transaction.when(loading: null, loaded: (transaction) {
    return transaction.where((t) => t.transactionType=='credit').toList();
  }, empty: (){ return [];});
});

final debitProvider = Provider<List<FridayTransaction>>((ref) {
  final trans = ref.watch(transactionProvider.state);
  return trans.when(loading: null, loaded: (transaction){
    return transaction.where((t) => t.transactionType=='debit').toList();
  }, empty: () {
    return [];
  });
});