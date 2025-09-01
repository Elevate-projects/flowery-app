class UserDataEntity {
  UserDataEntity({
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.photo,
    this.gender,
    this.role,
    this.createdAt,
    this.wishlist,
    this.addresses,
  });

  final String? userId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? gender;
  final String? photo;
  final String? role;
  final String? createdAt;
  final List<String>? wishlist;
  final List<String>? addresses;
}
