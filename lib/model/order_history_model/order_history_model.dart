class Address {
  final String name;
  final String address;
  final String street;
  final String post;
  final String city;
  final int pin;
  final String state;
  final String mobile;
  final bool status;

  Address({
    required this.name,
    required this.address,
    required this.street,
    required this.post,
    required this.city,
    required this.pin,
    required this.state,
    required this.mobile,
    required this.status,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      name: json['name'],
      address: json['address'],
      street: json['street'],
      post: json['post'],
      city: json['city'],
      pin: json['pin'],
      state: json['state'],
      mobile: json['mobile'],
      status: json['status'],
    );
  }
}

class Image {
  final String imageUrl;
  final String imageId;

  Image({
    required this.imageUrl,
    required this.imageId,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      imageUrl: json['imageUrl'],
      imageId: json['imageId'],
    );
  }
}

class Product {
  final String productId;
  final String name;
  final Image image;
  final int price;
  final int quantity;

  Product({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      name: json['name'],
      image: Image.fromJson(json['image']),
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}

class User {
  final String id;
  final String mobile;
  final bool status;
  final List<Address> address;

  User({
    required this.id,
    required this.mobile,
    required this.status,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      mobile: json['mobile'],
      status: json['status'],
      address: (json['address'] as List)
          .map((item) => Address.fromJson(item))
          .toList(),
    );
  }
}

class OrderData {
  final String id;
  final User userId;
  final Address address;
  final List<Product> product;
  final int totalAmount;
  final String payment;
  final String paymentStatus;
  final String orderStatus;
  final DateTime orderDate;

  OrderData({
    required this.id,
    required this.userId,
    required this.address,
    required this.product,
    required this.totalAmount,
    required this.payment,
    required this.paymentStatus,
    required this.orderStatus,
    required this.orderDate,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['_id'],
      userId: User.fromJson(json['userId']),
      address: Address.fromJson(json['address']),
      product: (json['product'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
      totalAmount: json['totalAmount'],
      payment: json['payment'],
      paymentStatus: json['paymentStatus'],
      orderStatus: json['orderStatus'],
      orderDate: DateTime.parse(json['orderDate']),
    );
  }
}
