class DatabaseHelper {
  String address;
  String phone;
  String pinCode;

  DatabaseHelper({this.address ,this.phone, this.pinCode});

  DatabaseHelper.fromJson(Map<String, dynamic> json) {
    address = json['name'];
    phone = json['phone'];
    pinCode = json['pinCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['pinCode'] = this.pinCode;
    return data;
  }
}
