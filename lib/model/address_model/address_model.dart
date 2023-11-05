class AddressModel {
  final String name;
  final String address;
  final String street;
  final String post;
  final String city;
  final int pin;
  final String state;
  final String mobile;
  final bool? status;
  final String? id;

  AddressModel({
    required this.name,
    required this.address,
    required this.street,
    required this.post,
    required this.city,
    required this.pin,
    required this.state,
    required this.mobile,
    this.status,
    this.id,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      name: json['name'],
      address: json['address'],
      street: json['street'],
      post: json['post'],
      city: json['city'],
      pin: json['pin'],
      state: json['state'],
      mobile: json['mobile'],
      status: json['status'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'street': street,
      'post': post,
      'city': city,
      'pin': pin,
      'state': state,
      'mobile': mobile,
      'status': status,
      '_id': id,
    };
  }
}
