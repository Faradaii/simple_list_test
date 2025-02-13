part of 'shared_bloc.dart';

sealed class SharedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SharedNameChangedEvent extends SharedEvent {
  final String name;
  SharedNameChangedEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

class SharedPalindromeChangedEvent extends SharedEvent {
  final String textPalindrome;
  SharedPalindromeChangedEvent({required this.textPalindrome});

  @override
  List<Object?> get props => [textPalindrome];
}

class SharedSelectedUserChangedEvent extends SharedEvent {
  final String user;
  SharedSelectedUserChangedEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class SharedLoadUsersEvent extends SharedEvent {
  final bool forceRefresh;
  final int? page;
  final int perPage;

  SharedLoadUsersEvent(
      {this.forceRefresh = false, this.page, this.perPage = 10});

  @override
  List<Object?> get props => [forceRefresh, page, perPage];
}
