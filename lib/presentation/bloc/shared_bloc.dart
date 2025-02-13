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
  }) : super(SharedLoaded()) {
    on<SharedNameChangedEvent>((event, emit) {

      emit((state as SharedLoaded).copyWith(isLoading: true));
      emit((state as SharedLoaded).copyWith(name: event.name, isLoading: false));
    });
    on<SharedPalindromeChangedEvent>((event, emit) {

      emit((state as SharedLoaded).copyWith(isLoading: true));
      final isPalindrome = checkPalindromeUseCase.execute(event.textPalindrome);
      emit((state as SharedLoaded).copyWith(
          textPalindrome: event.textPalindrome, isPalindrome: isPalindrome, isLoading: false));
    });
    on<SharedSelectedUserChangedEvent>((event, emit) {

      emit((state as SharedLoaded).copyWith(isLoading: true));
      emit((state as SharedLoaded).copyWith(selectedUser: event.user, isLoading: false));
    });
    on<SharedLoadUsersEvent>((event, emit) async {



      final resetPage = 1;

      final result = await fetchUsersUseCase.execute(
          event.forceRefresh ? resetPage : event.page, event.perPage);
        print("After result : ${result.toString()}");

      result.fold(
          (fail) => emit((state as SharedLoaded).copyWith(message: fail.message, isLoading: false)), (success) {

        final nextPage = success.data!.length < event.perPage
            ? null
            : (event.page ?? 1) + 1;

        emit(
          (state as SharedLoaded).copyWith(
            users: success.data,
            page: nextPage,
            message: "",
            isLoading: false,
          ),
        );
      });
    });
  }
}
