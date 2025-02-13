import 'dart:math';

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
      emit(SharedLoading());
      emit(SharedLoaded().copyWith(name: event.name));
    });
    on<SharedPalindromeChangedEvent>((event, emit) {
      final isPalindrome = checkPalindromeUseCase.execute(event.textPalindrome);
      emit(SharedLoading());
      emit(SharedLoaded().copyWith(
          textPalindrome: event.textPalindrome, isPalindrome: isPalindrome));
    });
    on<SharedSelectedUserChangedEvent>((event, emit) {
      emit(SharedLoading());
      emit(SharedLoaded().copyWith(selectedUser: event.user));
    });
    on<SharedLoadUsersEvent>((event, emit) async {
      final previousState = state is SharedLoaded ? state as SharedLoaded : null;

      emit(SharedLoading());
      final resetPage = 1;

      final result = await fetchUsersUseCase.execute(
          event.forceRefresh ? resetPage : event.page, event.perPage);

      result.fold(
          (fail) => emit((state as SharedLoaded).copyWith(message: fail.message)), (success) {
        print(success.data.toString());

        final nextPage = success.data!.length < event.perPage
            ? null
            : (event.page ?? 1) + 1;

        emit(
          (previousState ?? SharedLoaded()).copyWith(
            users: event.forceRefresh
                ? success.data
                : [...?previousState?.users, ...?success.data],
            page: nextPage,
            message: "",
          ),
        );
      });
    });
  }
}
