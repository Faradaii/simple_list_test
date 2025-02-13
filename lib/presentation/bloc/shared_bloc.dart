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
      emit(
          (state as SharedLoaded).copyWith(name: event.name, isLoading: false));
    });
    on<SharedPalindromeChangedEvent>((event, emit) {
      emit((state as SharedLoaded).copyWith(isLoading: true));
      final isPalindrome = checkPalindromeUseCase.execute(event.textPalindrome);
      emit((state as SharedLoaded).copyWith(
          textPalindrome: event.textPalindrome,
          isPalindrome: isPalindrome,
          isLoading: false));
    });
    on<SharedSelectedUserChangedEvent>((event, emit) {
      emit((state as SharedLoaded).copyWith(isLoading: true));
      emit((state as SharedLoaded)
          .copyWith(selectedUser: event.user, isLoading: false));
    });
    on<SharedLoadUsersEvent>((event, emit) async {
      final prevState = state as SharedLoaded;

      emit(SharedLoading());
      final resetPage = 1;

      final result = await fetchUsersUseCase.execute(
          event.forceRefresh ? resetPage : prevState.page, event.perPage);

      result.fold(
          (fail) => emit((prevState)
              .copyWith(message: fail.message, isLoading: false)), (success) {

        emit(
          (prevState).copyWith(
            users: event.forceRefresh ? success.data : [...prevState.users, ...?success.data],
            page: success.data!.length < event.perPage ? 0 : prevState.page ?? 1 + 1,
            message: "",
            isLoading: false,
          ),
        );
      });
    });
  }
}
