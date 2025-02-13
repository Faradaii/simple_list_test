part of 'shared_bloc.dart';

sealed class SharedEvent {}

class SharedNameChangedEvent extends SharedEvent {
  final String name;
  SharedNameChangedEvent({required this.name});
}

class SharedPalindromeChangedEvent extends SharedEvent {
  final String textPalindrome;
  SharedPalindromeChangedEvent({required this.textPalindrome});
}

class SharedSelectedUserChangedEvent extends SharedEvent {
  final String user;
  SharedSelectedUserChangedEvent({required this.user});
}
