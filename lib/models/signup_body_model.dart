class SignUpBody {
  String name;
  String email;
  String password;
  String phone;

  SignUpBody({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['f_name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;

    return data;
  }
}

// var emailController = TextEditingController();
// var passwordController = TextEditingController();
// var nameController = TextEditingController();
// var phoneController = TextEditingController();
