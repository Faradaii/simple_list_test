part of 'shared_bloc.dart';

sealed class SharedState extends Equatable {
  final String message;

  const SharedState({this.message = ""});
  @override
  List<Object> get props => [message];
}

final class SharedLoaded extends SharedState {
  final String name;
  final String textPalindrome;
  final bool isPalindrome;
  final String selectedUser;
  final List<UserEntity> users;
  final bool isLoading;
  final int? page;

  const SharedLoaded({
    this.name = "",
    this.textPalindrome = "",
    this.isPalindrome = false,
    this.selectedUser = "",
    this.users = const [],
    this.page,
    this.isLoading = false,
    super.message,
  });

  SharedLoaded copyWith({
    String? name,
    String? textPalindrome,
    bool? isPalindrome,
    String? selectedUser,
    List<UserEntity>? users,
    int? page,
    bool? isLoading,
    String? message,
  }) {
    return SharedLoaded(
      name: name ?? this.name,
      textPalindrome: textPalindrome ?? this.textPalindrome,
      isPalindrome: isPalindrome ?? this.isPalindrome,
      selectedUser: selectedUser ?? this.selectedUser,
      users: users ?? this.users,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? super.message,
    );
  }

  @override
  List<Object> get props => [
        name,
        textPalindrome,
        isPalindrome,
        selectedUser,
        users,
        isLoading,
        message
      ];
}

class SharedLoading extends SharedState {}