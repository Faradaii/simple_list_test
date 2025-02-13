import 'package:bloc/bloc.dart';

import '../../domain/usecases/check_palindrome_usecase.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  final CheckPalindromeUseCase checkPalindromeUseCase;
  SharedBloc({
    required this.checkPalindromeUseCase,
  }) : super(SharedInitial()) {
    on<SharedNameChangedEvent>((event, emit) {
      emit(SharedLoading());
      emit(
          SharedLoaded(name: event.name, textPalindrome: state.textPalindrome));
    });
    on<SharedPalindromeChangedEvent>((event, emit) {
      final isPalindrome = checkPalindromeUseCase.execute(event.textPalindrome);
      emit(SharedLoaded(
          textPalindrome: event.textPalindrome,
          name: state.name,
          isPalindrome: isPalindrome));
    });
  }
}
