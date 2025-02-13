part of 'shared_bloc.dart';

sealed class SharedState {
  final String? name;
  final String? textPalindrome;
  final bool? isPalindrome;

  const SharedState({
    this.name,
    this.textPalindrome,
    this.isPalindrome,
  });

  SharedState copyWith({
    String? name,
    String? textPalindrome,
    bool? isPalindrome,
  }) {
    if (this is SharedInitial) {
      return SharedInitial();
    } else if (this is SharedLoading) {
      return SharedLoading();
    } else if (this is SharedLoaded) {
      return SharedLoaded();
    } else {
      return SharedLoaded(
        name: name ?? this.name,
        textPalindrome: textPalindrome ?? this.textPalindrome,
        isPalindrome: isPalindrome ?? this.isPalindrome,
      );
    }
  }
}

final class SharedInitial extends SharedState {}

final class SharedLoaded extends SharedState {
  const SharedLoaded({
    super.name,
    super.textPalindrome,
    super.isPalindrome,
  });
}

final class SharedLoading extends SharedState {}
