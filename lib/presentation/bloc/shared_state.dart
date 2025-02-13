part of 'shared_bloc.dart';

sealed class SharedState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SharedInitial extends SharedState {}

final class SharedLoaded extends SharedState {
  final String name;
  final String textPalindrome;
  final bool isPalindrome;
  final String selectedUser;

  SharedLoaded({
    this.name = "",
    this.textPalindrome = "",
    this.isPalindrome = false,
    this.selectedUser = "",
  });

  SharedLoaded copyWith({
    String? name,
    String? textPalindrome,
    bool? isPalindrome,
    String? selectedUser,
  }) {
    return SharedLoaded(
        name: name ?? this.name,
        textPalindrome: textPalindrome ?? this.textPalindrome,
        isPalindrome: isPalindrome ?? this.isPalindrome,
        selectedUser: selectedUser ?? this.selectedUser);
  }

  @override
  List<Object> get props => [name, textPalindrome, isPalindrome, selectedUser];
}

final class SharedLoading extends SharedState {}
