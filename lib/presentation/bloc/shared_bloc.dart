import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_list_test/domain/entities/user_entity.dart';
import 'package:simple_list_test/domain/usecases/fetch_users_usecase.dart';

import '../../domain/usecases/check_palindrome_usecase.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  final CheckPalindromeUseCase checkPalindromeUseCase;
  final FetchUsersUseCase fetchUsersUseCase;
  SharedBloc({
    required this.checkPalindromeUseCase,
    required this.fetchUsersUseCase,
  }) : super(SharedInitial()) {
    on<SharedNameChangedEvent>((event, emit) {
      emit(SharedLoaded().copyWith(name: event.name));
    });
    on<SharedPalindromeChangedEvent>((event, emit) {
      final isPalindrome = checkPalindromeUseCase.execute(event.textPalindrome);
      emit(SharedLoaded().copyWith(
          textPalindrome: event.textPalindrome, isPalindrome: isPalindrome));
    });
    on<SharedSelectedUserChangedEvent>((event, emit) {
      emit(SharedLoaded().copyWith(selectedUser: event.user));
    });
    on<SharedLoadUsersEvent>((event, emit) async {

      emit(SharedLoaded().copyWith(isFetchingUser: true));
      final resetPage = 1;

      final result = await fetchUsersUseCase.execute(
          event.forceRefresh ? resetPage : event.page, event.perPage);

      result.fold(
          (fail) => emit(SharedLoaded().copyWith(message: fail.message, isFetchingUser: false)), (success) {

        final nextPage = success.data!.length < event.perPage
            ? null
            : (event.page ?? 1) + 1;

        emit(
          SharedLoaded().copyWith(
            users: success.data,
            page: nextPage,
            message: "",
            isFetchingUser: false,
          ),
        );
      });
    });
  }
}
