class ListUser {
  ListUser({
    required this.id,
    required this.name,
    required this.age,
    required this.mark,
    required this.address,
  });

  final int id;
  final String name;
  final int age;
  final double mark;
  final String address;

  factory ListUser.fromJson(Map<String, dynamic> json) {
    return ListUser(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      mark: json['mark'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'mark': mark,
      'address': address,
    };
  }
}
