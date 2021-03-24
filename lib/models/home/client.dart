/// id : 93
/// name : "Dev"
/// mobile : "102030"
/// email : "9127@gmail.com"
/// image : "https://yagot.tejaratek.com/site/assets/images/user.png"
/// type : null
/// country_code : "966"
/// full_mobile : "966102030"
/// client_type : null
/// zone_id : 5
/// country_id : 1
/// passport : null
/// commercial_photo : null
/// identity : null
/// subscription_id : null
/// start_subscription : null
/// end_subscription : null
/// zone_name : "المنطقة الشرقية"
/// country_name : "المملكة العربية السعودية"
/// country_image : "SA"
/// last_login : "2021-02-13 15:15:25"
/// certified : 0

class Client {
  int _id;
  String _name;
  String _mobile;
  String _email;
  String _image;
  int _type;
  String _countryCode;
  String _fullMobile;
  String _clientType;
  int _zoneId;
  int _countryId;
  dynamic _passport;
  dynamic _commercialPhoto;
  dynamic _identity;
  int _subscriptionId;
  String _startSubscription;
  String _endSubscription;
  String _zoneName;
  String _countryName;
  String _countryImage;
  String _lastLogin;
  bool _certified;

  int get id => _id;

  String get name => _name;

  String get mobile => _mobile;

  String get email => _email;

  String get image => _image;

  int get type => _type;

  String get countryCode => _countryCode;

  String get fullMobile => _fullMobile;

  String get clientType => _clientType;

  int get zoneId => _zoneId;

  int get countryId => _countryId;

  dynamic get passport => _passport;

  dynamic get commercialPhoto => _commercialPhoto;

  dynamic get identity => _identity;

  int get subscriptionId => _subscriptionId;

  String get startSubscription => _startSubscription;

  String get endSubscription => _endSubscription;

  String get zoneName => _zoneName;

  String get countryName => _countryName;

  String get countryImage => _countryImage;

  String get lastLogin => _lastLogin;

  bool get certified => _certified;

  Client(
      {int id,
      String name,
      String mobile,
      String email,
      String image,
      int type,
      String countryCode,
      String fullMobile,
      String clientType,
      int zoneId,
      int countryId,
      dynamic passport,
      dynamic commercialPhoto,
      dynamic identity,
      int subscriptionId,
      String startSubscription,
      String endSubscription,
      String zoneName,
      String countryName,
      String countryImage,
      String lastLogin,
        bool certified}) {
    _id = id;
    _name = name;
    _mobile = mobile;
    _email = email;
    _image = image;
    _type = type;
    _countryCode = countryCode;
    _fullMobile = fullMobile;
    _clientType = clientType;
    _zoneId = zoneId;
    _countryId = countryId;
    _passport = passport;
    _commercialPhoto = commercialPhoto;
    _identity = identity;
    _subscriptionId = subscriptionId;
    _startSubscription = startSubscription;
    _endSubscription = endSubscription;
    _zoneName = zoneName;
    _countryName = countryName;
    _countryImage = countryImage;
    _lastLogin = lastLogin;
    _certified = certified;
  }

  Client.fromJson(Map<String,dynamic> json) {
    _id = json["id"];
    _name = json["name"];
    _mobile = json["mobile"];
    _email = json["email"];
    _image = json["image"];
    _type = json["type"];
    _countryCode = json["country_code"];
    _fullMobile = json["full_mobile"];
    _clientType = json["client_type"];
    _zoneId = json["zone_id"];
    _countryId = json["country_id"];
    _passport = json["passport"];
    _commercialPhoto = json["commercial_photo"];
    _identity = json["identity"];
    _subscriptionId = json["subscription_id"];
    _startSubscription = json["start_subscription"];
    _endSubscription = json["end_subscription"];
    _zoneName = json["zone_name"];
    _countryName = json["country_name"];
    _countryImage = json["country_image"];
    _lastLogin = json["last_login"];
    _certified = (json["certified"] == 1);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["mobile"] = _mobile;
    map["email"] = _email;
    map["image"] = _image;
    map["type"] = _type;
    map["country_code"] = _countryCode;
    map["full_mobile"] = _fullMobile;
    map["client_type"] = _clientType;
    map["zone_id"] = _zoneId;
    map["country_id"] = _countryId;
    map["passport"] = _passport;
    map["commercial_photo"] = _commercialPhoto;
    map["identity"] = _identity;
    map["subscription_id"] = _subscriptionId;
    map["start_subscription"] = _startSubscription;
    map["end_subscription"] = _endSubscription;
    map["zone_name"] = _zoneName;
    map["country_name"] = _countryName;
    map["country_image"] = _countryImage;
    map["last_login"] = _lastLogin;
    map["certified"] = _certified;
    return map;
  }
}
