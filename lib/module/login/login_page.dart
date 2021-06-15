import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_project/common/define_image.dart';
import 'package:interview_project/data/service/login_service/login_service.dart';
import 'package:provider/provider.dart';
import 'package:interview_project/base/base_event.dart';
import 'package:interview_project/base/base_widget.dart';
import 'package:interview_project/common/common.dart';
import 'package:interview_project/data/repository/login_repository.dart';
import 'package:interview_project/event/login/login_event.dart';
import 'package:interview_project/event/login/login_fail_event.dart';
import 'package:interview_project/event/login/login_success_event.dart';
import 'package:interview_project/shared_code/style/text_style/txt_style.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';
import 'package:interview_project/shared_code/utils/materials/system.dart';
import 'package:interview_project/shared_code/widgets/base_widget/bloc_listener.dart';
import 'package:interview_project/shared_code/widgets/button_widget/normal_button.dart';
import 'package:interview_project/shared_code/widgets/loading_widget/loading_task.dart';

import '../../shared_code/utils/materials/app_color.dart';
import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: LoginService(),
        ),
        ProxyProvider<LoginService, LoginRepository>(
          update: (context, loginService, previous) => LoginRepository(
            loginService: loginService,
          ),
        ),
      ],
      bloc: const [],
      child: Scaffold(
        body: LoginInFormWidget(),
      ),
    );
  }
}

class LoginInFormWidget extends StatefulWidget {
  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginInFormWidget> {
  final TextEditingController _txtUserNameController = TextEditingController();

  final TextEditingController _txtPasswordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();

  // Initially password is obscure
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginBloc(loginRepository: Provider.of(context)),
      child: Consumer<LoginBloc>(
        builder: (context, bloc, child) {
          return BlocListener<LoginBloc>(
            listener: handleEvent,
            child: LoadingTask(
              bloc: bloc,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: ExactAssetImage(
                        BACKGROUND_WELCOME_IMAGE,
                      ),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 80),
                      _buildLogoLogin(),
                      const SizedBox(height: 47),
                      _buildUsernameLogin(bloc),
                      const SizedBox(height: 18),
                      _buildPasswordLogin(bloc),
                      const SizedBox(height: 18),
                      _buildSignInButton(bloc),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: _buildVersionApp(bloc),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogoLogin() {
    return Container(
      width: sizeDevice.width,
      child: Image.asset(
        IC_SPLASH_APP_IMAGE,
        width: 96,
        height: 96,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  Widget _buildUsernameLogin(LoginBloc bloc) {
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloc.userNameStream,
      child: Consumer<String?>(
        builder: (context, msg, child) => Container(
          height: 50,
          padding: const EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            color: AppColor.primaryBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor,
                blurRadius: 10,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: TextField(
            controller: _txtUserNameController,
            onChanged: (text) {
              //bloc.passwordSink.add(text);
            },
            onSubmitted: (tern) {
              FocusScope.of(context).requestFocus(_passwordFocus);
            },
            // obscureText: _obscureText,
            style: InputTextFormFieldStyle.inputText(),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              hintText: tr('username'),
              hintStyle: InputTextFormFieldStyle.hintText(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordLogin(LoginBloc bloc) {
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloc.passwordStream,
      child: Consumer<String?>(
        builder: (context, msg, child) => Container(
          height: 50,
          padding: const EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            color: AppColor.primaryBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColor.shadowColor,
                blurRadius: 10,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: TextField(
            controller: _txtPasswordController,
            focusNode: _passwordFocus,
            onChanged: (text) {
              //bloc.passwordSink.add(text);
            },
            onSubmitted: (tern) {
              bloc.event.add(
                LoginEvent(
                  username: _txtUserNameController.text,
                  password: _txtPasswordController.text,
                ),
              );
            },
            obscureText: _obscureText,
            style: InputTextFormFieldStyle.inputText(),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              suffixIcon: GestureDetector(
                onTap: _toggle,
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColor.textPrimaryColor.withOpacity(0.4),
                ),
              ),
              errorText: msg,
              hintText: tr('password'),
              hintStyle: InputTextFormFieldStyle.hintText(),
            ),
          ),
        ),
      ),
    );
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildSignInButton(LoginBloc bloc) {
    return StreamProvider<bool>.value(
      initialData: true,
      value: bloc.btnLoginStream,
      child: Consumer<bool>(
        builder: (context, enable, child) => NormalButton(
          title: tr('next').toUpperCase(),
          onPressed: () {
            bloc.event.add(
              LoginEvent(
                username: _txtUserNameController.text,
                password: _txtPasswordController.text,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVersionApp(LoginBloc bloc) {
    return StreamProvider<String>.value(
      initialData: '',
      value: bloc.strVersionStream,
      child: Consumer<String>(
        builder: (context, version, child) {
          if (version.isEmpty) {
            return Container();
          }
          return Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr('version'),
                  style: TextStyle(
                    color: AppColor.textSecondColor.withOpacity(0.6),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  version,
                  style: TextStyle(
                    color: AppColor.textSecondColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void handleEvent(BaseEvent event) {
    if (event is LoginSuccessEvent) {
      // Navigate to Home Page
      Navigator.pushReplacementNamed(context, Route_Named_NavigatePage);
      return;
    }

    if (event is LoginFailEvent) {
      final snackBar = SnackBar(
        content: Text(event.errMessage),
        backgroundColor: AppColor.errorColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
