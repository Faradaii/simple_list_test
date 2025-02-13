part of 'shared_bloc.dart';

sealed class SharedState extends Equatable {
  final String message;

  const SharedState({this.message = ""});
  @override
  List<Object> get props => [message];
}

final class SharedInitial extends SharedState {}

final class SharedLoaded extends SharedState {
  final String name;
  final String textPalindrome;
  final bool isPalindrome;
  final String selectedUser;
  final List<UserEntity> users;
  final int? page;

  const SharedLoaded({
    this.name = "",
    this.textPalindrome = "",
    this.isPalindrome = false,
    this.selectedUser = "",
    this.users = const [],
    this.page = 1,
    super.message,
  });

  SharedLoaded copyWith({
    String? name,
    String? textPalindrome,
    bool? isPalindrome,
    String? selectedUser,
    List<UserEntity>? users,
    int? page,
    String? message,
  }) {
    return SharedLoaded(
      name: name ?? this.name,
      textPalindrome: textPalindrome ?? this.textPalindrome,
      isPalindrome: isPalindrome ?? this.isPalindrome,
      selectedUser: selectedUser ?? this.selectedUser,
      users: users ?? this.users,
      page: page ?? this.page,
      message: message ?? super.message,
    );
  }

  @override
  List<Object> get props =>
      [name, textPalindrome, isPalindrome, selectedUser, users];
}

final class SharedLoading extends SharedState {}
