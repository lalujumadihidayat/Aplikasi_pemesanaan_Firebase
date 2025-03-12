import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/controller/authentication.dart';
import 'package:mob3_uas_klp_09/controller/button.dart';
import 'package:mob3_uas_klp_09/controller/snackbar.dart';
import 'package:mob3_uas_klp_09/ui/home.dart';
import 'package:mob3_uas_klp_09/ui/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode alamatFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedCountryCode = "+62";
  final List<String> countryCodes = ["+62", "+1", "+91", "+81"];

  bool isLoading = false;
  bool isPasswordVisible = false;

  String? gender;

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    alamatController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    alamatFocusNode.dispose();
    passwordFocusNode.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  void signupUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String res = await AuthMethod().signupUser(
        email: emailController.text,
        alamat: alamatController.text,
        password: passwordController.text,
        name: nameController.text,
        phone: phoneController.text,
        gender: gender ?? "",
        username: nameController.text,
      );

      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(206, 105, 244, 151),
                    Color.fromARGB(159, 0, 162, 255)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height / 2.8,
                            child: Image.asset('images/logooo.png'),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              controller: nameController,
                              focusNode: nameFocusNode,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Enter your name",
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                prefixIcon: const Icon(Icons.person),
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your name";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              controller: emailController,
                              focusNode: emailFocusNode,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Enter your email",
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                prefixIcon: const Icon(Icons.email),
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              controller: alamatController,
                              focusNode: alamatFocusNode,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Enter your alamat",
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                prefixIcon: const Icon(Icons.home),
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your alamat";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: DropdownButton<String>(
                                    value: selectedCountryCode,
                                    items: countryCodes.map((String code) {
                                      return DropdownMenuItem<String>(
                                        value: code,
                                        child: Text(code),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedCountryCode = newValue!;
                                      });
                                    },
                                    underline: Container(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: phoneController,
                                    focusNode: phoneFocusNode,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                      labelText: "Enter your phone number",
                                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                                      prefixIcon: Icon(Icons.phone),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your phone number";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextFormField(
                              controller: passwordController,
                              focusNode: passwordFocusNode,
                              obscureText: !isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: "Enter your password",
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                } else if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                const Text("Gender: "),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: "Laki-laki",
                                      groupValue: gender,
                                      onChanged: (String? value) {
                                        setState(() {
                                          gender = value;
                                        });
                                      },
                                    ),
                                    const Text("Laki-laki"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: "Perempuan",
                                      groupValue: gender,
                                      onChanged: (String? value) {
                                        setState(() {
                                          gender = value;
                                        });
                                      },
                                    ),
                                    const Text("Perempuan"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          MyButtons(
                            onTap: signupUser,
                            text: isLoading ? "Loading..." : "Sign Up",
                          ),
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  " Login",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
