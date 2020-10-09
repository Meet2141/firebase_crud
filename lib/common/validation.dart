class Validation{
  String validateName(String value) {
    if (value.isEmpty)
      return 'Enter name';
    else
      return null;
  }
  String validatePassword(String value) {
    if (value.isEmpty)
      return 'Enter atleast 6 charater password';
    else
      return null;
  }
  String validateMobile(String value) {
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
  String validateAddress(String value) {
    if (value.isEmpty)
      return 'Enter Address';
    else
      return null;
  }
  String validatePincode(String value) {
    if (value.isEmpty)
      return 'Enter PinCode';
    else
      return null;
  }


  String validateCode(String value) {
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }
}