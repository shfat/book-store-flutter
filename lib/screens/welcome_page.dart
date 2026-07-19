import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'home_page.dart';

/// Welcome screen that handles user authentication input.
///
/// Provides a login form with username and password validation,
/// displays the application branding, and navigates users to the
/// home page after successful validation.
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // Key used to validate and manage the login form state.
  final _formKey = GlobalKey<FormState>();

  // Controllers for accessing and managing user input values.
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    // Releases controller resources to prevent memory leaks.
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Application logo with a fallback icon when the asset fails to load.
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 120,
                        width: 120,
                        color: Colors.white.withOpacity(0.05),
                        child: const Icon(
                          Icons.menu_book,
                          size: 60,
                          color: kTextColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Application branding section.
                  const Text(
                    'کتاب کده',
                    style: kTitleTextStyle,
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'دنیایی از کتاب ها، در دستان شما',
                    style: TextStyle(fontSize: 14, color: kTextSecondaryColor),
                  ),

                  const SizedBox(height: 30),

                  // Username input field with empty value validation.
                  TextFormField(
                    controller: userController,
                    style: const TextStyle(color: kTextColor),
                    decoration: InputDecoration(
                      hintText: "شماره تلفن، ایمیل یا نام کاربری",
                      hintStyle: const TextStyle(color: kTextSecondaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kRadiusMedium),
                        borderSide: const BorderSide(color: kBorderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kRadiusMedium),
                        borderSide: const BorderSide(color: kBorderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kRadiusMedium),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                      filled: true,
                      fillColor: kSurfaceColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "نام کاربری نمیتواند خالی باشد";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  // Password input field with length validation.
                  TextFormField(
                    controller: passController,
                    obscureText: true,
                    style: const TextStyle(color: kTextColor),
                    decoration: InputDecoration(
                      hintText: "رمز عبور",
                      hintStyle: const TextStyle(color: kTextSecondaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kRadiusMedium),
                        borderSide: const BorderSide(color: kBorderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kRadiusMedium),
                        borderSide: const BorderSide(color: kBorderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kRadiusMedium),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                      filled: true,
                      fillColor: kSurfaceColor,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "رمز عبور نمیتواند خالی باشد";
                      } else if (value.length < 5) {
                        return "رمز عبور باید حداقل 5 کاراکتر باشد";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "فراموشی رمز عبور؟",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: kButtonHeight,

                    // Creates a gradient background for the login button.
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: kPrimaryGradient,
                        borderRadius: BorderRadius.circular(kRadiusMedium),
                      ),
                      child: ElevatedButton(
                        style: kGradientButtonStyle,
                        onPressed: () {
                          // Proceeds only if all form validation rules pass.
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "ورود موفقیت آمیز",
                                  style: TextStyle(fontSize: 16),
                                ),
                                backgroundColor: kPrimaryColor,
                              ),
                            );

                            // Replaces the login screen with the main application page.
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HomePage()),
                            );
                          }
                        },
                        child: const Text(
                          "ورود به برنامه",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}