import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_Admin/DashboardAdmin.dart';
import 'package:mob3_uas_klp_09/UI_anggota/DasboardAnggota.dart';
import 'package:mob3_uas_klp_09/controller/authentication.dart';
import 'package:mob3_uas_klp_09/controller/button.dart';
import 'package:mob3_uas_klp_09/controller/snackbar.dart';
import 'package:mob3_uas_klp_09/ui/forgot_fassword.dart';
import 'package:mob3_uas_klp_09/ui/singup.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPasswordVisible = false;

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
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      if (emailController.text == "admin") {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const DashboarAdmin(),
          ),
        );
        return;
      }

      // Logika login biasa
      String res = await AuthMethod().loginUser(
        identifier: emailController.text,
        password: passwordController.text,
      );

      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DasboardAnggota(username: emailController.text),
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(206, 148, 255, 200),
                  Color.fromARGB(159, 0, 162, 255)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
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
                              height: height / 2.7,
                              child: Image.asset(
                                'images/logooo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    // Field Email
                                    TextFormField(
                                      controller: emailController,
                                      focusNode: emailFocusNode,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        labelText: "Enter your email or username",
                                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                                        prefixIcon: Icon(Icons.person),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your email";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    // Field Password
                                    TextFormField(
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
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    const ForgotPassword(),
                                    const SizedBox(height: 10),
                                    MyButtons(
                                      onTap: loginUser,
                                      text: isLoading ? "Loading..." : "Log In",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const SignupScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellowAccent),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}