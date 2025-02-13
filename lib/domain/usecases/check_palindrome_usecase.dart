import '../repositories/app_repository.dart';

class CheckPalindromeUseCase {
  final AppRepository appRepository;

  CheckPalindromeUseCase({required this.appRepository});

  bool execute(String text) => appRepository.checkPalindrome(text);
}
