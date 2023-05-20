import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipely/src/common_widgets/common_widgets.dart';
import 'package:recipely/src/extensions/extensions.dart';
import 'package:recipely/src/features/login/models/login_request.dart';
import 'package:recipely/src/features/login/provider/login_provider.dart';

import '../../../constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const RecipelyAppBarWidget(
        appBarText: loginText,
        backgroundColor: Colors.white,
      ),
      body: Consumer<LoginProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapH40,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: RecipelyTextWidget(
                    text: emailText,
                    color: HexColor("#3a3b35"),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                ),
                gapH8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: RecipelyTextFieldWidget(
                    textEditingController: provider.emailController,
                    focusNode: provider.emailFocusNode,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (value) {
                      FocusScope.of(context)
                          .requestFocus(provider.passwordFocusNode);
                    },
                    prefixWidget: Icon(
                      Icons.email_outlined,
                      color: HexColor("#3a3b35").withOpacity(0.3),
                    ),
                    suffixWidget: const SizedBox.shrink(),
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return emailRequiredText;
                      }
                      return null;
                    },
                  ),
                ),
                gapH24,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: RecipelyTextWidget(
                    text: passswordText,
                    color: HexColor("#3a3b35"),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                ),
                gapH8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: RecipelyTextFieldWidget(
                    textEditingController: provider.passwordController,
                    focusNode: provider.passwordFocusNode,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    prefixWidget: Icon(
                      Icons.lock_outline,
                      color: HexColor("#3a3b35").withOpacity(0.3),
                    ),
                    suffixWidget: InkWell(
                      onTap: () {
                        setState(() {
                          provider.obscurePassword = !provider.obscurePassword;
                        });
                      },
                      child: Icon(
                        provider.obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: HexColor("#3a3b35").withOpacity(0.3),
                      ),
                    ),
                    obscureText: provider.obscurePassword,
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return passwordRequiredText;
                      }
                      return null;
                    },
                  ),
                ),
                gapH28,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: RecipelyButtonWidget(
                    buttonText: loginText,
                    buttonBackgroundColor: HexColor("#000000"),
                    onPressed: () {
                      if (provider.formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        LoginRequest loginRequest = LoginRequest(
                          email: provider.emailController.text.trim(),
                          password: provider.passwordController.text.trim(),
                        );
                        provider.doLogin(context, loginRequest);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
