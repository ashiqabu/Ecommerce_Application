// ignore_for_file: use_build_context_synchronously, void_checks, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:test_cyra/core/alert_message.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameCntrl = TextEditingController();
  final TextEditingController phoneCntrl = TextEditingController();
  final TextEditingController addressCntrl = TextEditingController();
  final TextEditingController usernameCntrl = TextEditingController();
  final TextEditingController passwordCntrl = TextEditingController();

  bool _isPasswordVisible = false;

  void _resetFields() {
    nameCntrl.clear();
    phoneCntrl.clear();
    addressCntrl.clear();
    usernameCntrl.clear();
    passwordCntrl.clear();
    setState(() {
      _isPasswordVisible = false;
    });
  }

  void _checkFields() {
    List<String> missingFields = [];

    if (nameCntrl.text.isEmpty) {
      missingFields.add('Name');
    }

    if (phoneCntrl.text.isEmpty) {
      missingFields.add('Phone Number');
    }
    if (addressCntrl.text.isEmpty) {
      missingFields.add('Address');
    }
    if (usernameCntrl.text.isEmpty) {
      missingFields.add('Email');
    }
    if (passwordCntrl.text.isEmpty) {
      missingFields.add('Password');
    }

    if (missingFields.isEmpty) {
      registration(
          nameCntrl, phoneCntrl, addressCntrl, usernameCntrl, passwordCntrl);
    } else {
      showCustomSnackBar(
          context,
          'Please fill the following fields: ${missingFields.join(', ')}',
          Colors.red);
    }
  }

  void registration(
      TextEditingController name,
      TextEditingController phone,
      TextEditingController address,
      TextEditingController username,
      TextEditingController password) async {
    var result;
    final Map<String, dynamic> data = {
      'name': name.text,
      'phone': phone.text,
      'address': address.text,
      'username': username.text,
      'password': password.text
    };
    final response = await http.post(
        Uri.parse("http://bootcamp.cyralearnings.com/registration.php"),
        body: data);
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      if (response.body.contains('success')) {
        log(username.text);
        log(password.text);

        showCustomSnackBar(
            context, 'Registration successfully completed', Colors.green);
        
        Navigator.pushReplacementNamed(context, '/login');
        _resetFields();
      } else {
         showCustomSnackBar(
            context, 'Registration failed', Colors.red);
      }
    } else {
      result = {log(json.decode(response.body)['error'].toString())};
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 24),
              ),
              const Text(
                'Create a New Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.man),
                  hintText: 'Name',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color.fromARGB(255, 173, 198, 173),
                ),
                controller: nameCntrl,
              ),
              const SizedBox(height: 20),
              IntlPhoneField(
                initialCountryCode: 'IN',
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color.fromARGB(255, 173, 198, 173),
                ),
                controller: phoneCntrl,
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 120,
                child: TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Address',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Color.fromARGB(255, 173, 198, 173),
                  ),
                  controller: addressCntrl,
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Username',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color.fromARGB(255, 173, 198, 173),
                ),
                controller: usernameCntrl,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: const Color.fromARGB(255, 173, 198, 173),
                  prefixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                controller: passwordCntrl,
                obscureText: !_isPasswordVisible,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 67, 76, 90)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: _checkFields,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
