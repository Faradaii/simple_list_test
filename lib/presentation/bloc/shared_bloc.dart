import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/check_palindrome_usecase.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  final CheckPalindromeUseCase checkPalindromeUseCase;
  SharedBloc({
    required this.checkPalindromeUseCase,
  }) : super(SharedInitial()) {
    on<SharedNameChangedEvent>((event, emit) {
      if (state is SharedLoaded) {
        emit(SharedLoading());
        emit(SharedLoaded().copyWith(name: event.name));
      } else {
        emit(SharedLoaded(name: event.name));
      }
    });
    on<SharedPalindromeChangedEvent>((event, emit) {
      final isPalindrome = checkPalindromeUseCase.execute(event.textPalindrome);
      if (state is SharedLoaded) {
        emit(SharedLoading());
        emit(SharedLoaded().copyWith(
            textPalindrome: event.textPalindrome, isPalindrome: isPalindrome));
      } else {
        emit(SharedLoaded(
            textPalindrome: event.textPalindrome, isPalindrome: isPalindrome));
      }
    });
    on<SharedSelectedUserChangedEvent>((event, emit) {
      if (state is SharedLoaded) {
        emit(SharedLoading());
        emit(SharedLoaded().copyWith(selectedUser: event.user));
      } else {
        emit(SharedLoaded(selectedUser: event.user));
      }
    });
  }
}
