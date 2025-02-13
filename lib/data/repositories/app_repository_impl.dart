import '../../domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  @override
  bool checkPalindrome(String text) {
    String reverseText = text.toLowerCase().split('').reversed.join('');
    return text == reverseText;
  }
}
