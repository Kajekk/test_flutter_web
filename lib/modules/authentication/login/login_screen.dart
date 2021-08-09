import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/constants/assets_path.dart';
import 'login.dart';
import 'package:test_flutter_web/routes/app_pages.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AssetsPath.Logo),
              SizedBox(height: defaultPadding * 4),
              LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      constraints: BoxConstraints(
        maxWidth: 500
      ),
      margin: EdgeInsets.symmetric(horizontal: width / 5),
      padding: EdgeInsets.all(defaultPadding * 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Obx(() {
        return Form(
          key: _key,
          autovalidateMode: _controller.autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(
                  color: Color(0xFF999999),
                ),
                decoration: InputDecoration(
                    labelText: 'Email address',
                    labelStyle: TextStyle(
                        color: Color(0xFF999999), fontWeight: FontWeight.bold),
                    // filled: true,
                    // isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF999999)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF999999)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 2, color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 2, color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                cursorColor: Color(0xFF999999),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (val) {
                  if (val == "") {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: defaultPadding,
              ),
              TextFormField(
                style: TextStyle(
                  color: Color(0xFF999999),
                ),
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Color(0xFF999999), fontWeight: FontWeight.bold),
                    // filled: true,
                    // isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF999999)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xFF999999)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.redAccent),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: IconButton(
                      icon: _controller.obscureText
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: _controller.toggleObscureText,
                    )),
                controller: _passwordController,
                cursorColor: Color(0xFF999999),
                obscureText: _controller.obscureText,
                validator: (value) {
                  if (value == "") {
                    return 'Password is required.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Text('Forget password?'),
              SizedBox(
                height: defaultPadding,
              ),
              ElevatedButton(
                onPressed: _controller.state is LoginLoading
                    ? () {}
                    : _onLoginButtonPressed,
                child: (_controller.state is LoginLoading)
                    ? SizedBox(
                        child: CircularProgressIndicator(),
                        height: 20.0,
                        width: 20.0,
                      )
                    : Text('LOG IN'),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: defaultPadding * 2,
                          vertical: defaultPadding)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                ),
              ),
              if (_controller.state is LoginFailure)
                Padding(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  child: Text(
                    (_controller.state as LoginFailure).error,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Get.theme.errorColor // easy way to access theme
                        ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  _onLoginButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.login(_emailController.text, _passwordController.text);
    } else {
      _controller.changeAutoValidate();
    }
  }
}
