class Data {
  late int id;
  late String email;
  late String firstName;
  late String lastName;
  late String avatar;

  Data(this.id, this.email, this.firstName, this.lastName, this.avatar);

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];

  }
}