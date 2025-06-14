class ProfileResponse {
  ProfileResponse({
    this.message,
    this.data,
    this.status,});

  ProfileResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  bool? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    this.id,
    this.email,
    this.password,
    this.name,
    this.phone,
    this.avaterId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.watchListCount,
    this.historyCount,
  });

  Data.fromJson(dynamic json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    avaterId = json['avaterId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    watchListCount = json['watchListCount'];
    historyCount = json['historyCount'];
  }
  String? id;
  String? email;
  String? password;
  String? name;
  String? phone;
  int? avaterId;
  String? createdAt;
  String? updatedAt;
  int? v;
  int? watchListCount;
  int? historyCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['phone'] = phone;
    map['avaterId'] = avaterId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['watchListCount'] = watchListCount;
    map['historyCount'] = historyCount;
    return map;
  }

  Data copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    String? phone,
    int? avaterId,
    String? createdAt,
    String? updatedAt,
    int? v,
    int? watchListCount,
    int? historyCount,
  }) {
    return Data(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      avaterId: avaterId ?? this.avaterId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      watchListCount: watchListCount ?? this.watchListCount,
      historyCount: historyCount ?? this.historyCount,
    );
  }

}