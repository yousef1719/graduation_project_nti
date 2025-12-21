import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/helpers/validators.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/Header.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/Text_Fieldes.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8),
              Header(
                title: 'Create new password',
                subtitle:
                    'Your new password must be unique from those previsoly used.',
              ),
              SizedBox(height: 32),
              TextFieldes(
                label: 'New Password',
                hint: 'Enter your password',
                obscureText: isVisible,
                validator: (pass) {
                  return Validator.validatePassword(pass!);
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                controller: newPassword,
              ),
              SizedBox(height: 18),
              TextFieldes(
                label: 'Confirm Password',
                hint: 'Re-enter your new password',
                obscureText: isVisible,
                validator: (pass) {
                  return Validator.validatePassword(pass!);
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                controller: confirmPassword,
              ),
              Card(),
              SizedBox(height: 76),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Color(0xffEC3713),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                child: Text(
                  ('Reset Password'),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
