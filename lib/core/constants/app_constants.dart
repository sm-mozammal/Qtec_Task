class AppRegExpText {
  AppRegExpText._();
// Regular Expression
  static String kRegExpEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String kRegExpPhone =
      // ignore: prefer_adjacent_string_concatenation
      "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?" +
          "([0-9][0-9\\- \\.]+[0-9])";

  static String patternMail =
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
}

const String kImageUrl = 'imageUrl';
const String kKeyIsFirstTime = 'is_first_time';
// Keys

const String kKeyUserName = 'user_name';
const String kKeyMessage = 'message';
const String kKeyIsLoggedIn = 'is_logged_in';
const String kKeyAccessToken = 'access_token';
const String kPhone = 'phone_number';
const String kKeyCurrency = 'currency';
const String kKeyTokenType = 'token_type';
const String kKeyDeviceToken = 'device_token';

const String kApple = 'apple';
const String kGoogle = 'google';
const String kKeyDeviceID = 'device_id';
const String kKeyUserID = 'user_id';
const String kKeyIsExploring = 'exploring';
const String kKeyTheam = 'theam';

const String kEmail = 'kMail';
const String kKeyRole = 'role';

class DefaultValue {
  static const bool kDefaultBoolean = false;
  static const int kDefaultInt = 0;
  static const double kDefaultDouble = 0.0;
  static const String kDefaultString = '';
}
