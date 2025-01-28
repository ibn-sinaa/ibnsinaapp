class SettingsModel {
  final String phone;
  final String email;
  final num tax;
  final num shippingCost;
  final SocialModel social;
  final String googlePlay;
  final String appStore;
  final int? inReview;

  const SettingsModel({
    required this.phone,
    required this.email,
    required this.tax,
    required this.shippingCost,
    required this.social,
    required this.googlePlay,
    required this.appStore,
    required this.inReview,
  });

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      tax: num.parse(map['vat']?.toString() ?? '0'),
      shippingCost: num.parse(map['shipping_cost']?.toString() ?? '0'),
      social: SocialModel.fromMap(map['social']),
      googlePlay: map['app_url']['google_play'],
      appStore: map['app_url']['app_store'],
      inReview: map['in_review'] as int?,
    );
  }
}

class SocialModel {
  final String whatsapp;
  final String facebook;
  final String twitter;
  final String instagram;

  const SocialModel({
    required this.whatsapp,
    required this.facebook,
    required this.twitter,
    required this.instagram,
  });

  factory SocialModel.fromMap(Map<String, dynamic> map) {
    return SocialModel(
      whatsapp: map['whatsapp']?.toString() ?? '',
      facebook: map['facebook'] ?? '',
      twitter: map['twitter'] ?? '',
      instagram: map['instagram'] ?? '',
    );
  }
}
