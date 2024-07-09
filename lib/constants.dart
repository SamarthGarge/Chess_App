class Constants {
  static const String homeScreen = '/homeScreen';
  static const String gameScreen = '/gameScreen';
  static const String landingScreen = '/landingScreen';
  static const String settingScreen = '/settingScreen';
  static const String aboutScreen = '/aboutScreen';
  static const String gameStartupScreen = '/gameStartupScreen';
  static const String gameTimeScreen = '/gameTimeScreen';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String userInformationScreen = '/userInformationScreen';

  static const custom = 'Custom';

  static const uid = 'uid';
  static const name = 'name';
  static const image = 'image';
  static const email = 'email';
  static const createdAt = 'createdAt';

  static const String userImages = 'userImages';

  static const String users = 'users';
}

enum PlayerColor {
  white,
  black,
}

enum GameDifficulty {
  easy,
  medium,
  hard,
}

enum SignType {
  emailAndPassword,
  guest,
  google,
  facebook,
}
