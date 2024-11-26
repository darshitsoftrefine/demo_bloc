class UserModel {
  late int page;
  late int perPage;
  late int total;
  late int totalPages;
  late List<Data> data;
  late Support support;

  UserModel(this.page, this.perPage, this.total, this.totalPages, this.data, this.support);

  UserModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    total = json['total'];
    totalPages = json['totalPages'];
    data = json['data'];
    support = json['support'];
  }
}



class Data {
  late int id;
  late String email;
  late String firstName;
  late String lastName;
  late String avatar;

  Data(this.id, this.email, this.firstName, this.lastName, this.avatar);

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'] ?? "";
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    avatar = json['avatar'] ?? "";
  }
}

class Support {
  late String url;
  late String text;

  Support(this.text, this.url);

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }
}