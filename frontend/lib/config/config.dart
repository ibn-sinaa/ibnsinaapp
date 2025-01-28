class Config {
  final String languageCode;
  final String deviceToken;
  final String pushToken;

  Config({
    required this.languageCode,
    required this.deviceToken,
    required this.pushToken,
  });

  Config copyWith({
    String? languageCode,
    String? deviceToken,
    String? pushToken,
  }) {
    return Config(
      languageCode: languageCode ?? this.languageCode,
      deviceToken: deviceToken ?? this.deviceToken,
      pushToken: pushToken ?? this.pushToken,
    );
  }
}
