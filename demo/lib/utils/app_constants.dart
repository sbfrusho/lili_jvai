
	  
class AppConstants {
  static String Google_Api_Key = "AIzaSyDEOhUOUDVMYiBOHqEtCnyrztCrlOqZ6bo";
  static String APP_NAME = "Uber App";

  // share preference Key
  static String THEME = "theme";

  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';

  static RegExp emailValidator = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+",
  );
}
