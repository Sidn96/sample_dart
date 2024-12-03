class AppErrors {
  static final AppErrors _instance = AppErrors._internal();

  factory AppErrors() => _instance;
  AppErrors._internal();

  static String mSomethingWentWrong = 'Something went wrong.';

}