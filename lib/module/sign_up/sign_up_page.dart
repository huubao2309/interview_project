import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_project/data/repository/sign_up_repository.dart';
import 'package:interview_project/data/service/sign_up_service/sign_up_service.dart';
import 'package:interview_project/event/sign_up/sign_up_fail_event.dart';
import 'package:interview_project/event/sign_up/sign_up_success_event.dart';
import 'package:interview_project/shared_code/model/login_model/request_login_model.dart';
import 'package:provider/provider.dart';
import 'package:interview_project/base/base_event.dart';
import 'package:interview_project/base/base_widget.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';
import 'package:interview_project/shared_code/widgets/appbar_widget/app_bar_widget.dart';
import 'package:interview_project/shared_code/widgets/base_widget/bloc_listener.dart';
import 'package:interview_project/shared_code/widgets/button_widget/normal_button.dart';
import 'package:interview_project/shared_code/widgets/loading_widget/loading_task.dart';

import 'sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: SignUpService(),
        ),
        ProxyProvider<SignUpService, SignUpRepository>(
          update: (context, signUpService, previous) => SignUpRepository(signUpService: signUpService),
        ),
      ],
      bloc: const [],
      child: SignUpWidget(),
    );
  }
}

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _txtUserNameController = TextEditingController();
  final TextEditingController _txtNewPasswordController = TextEditingController();
  final TextEditingController _txtReInputNewPasswordController = TextEditingController();

  // Initially new password is obscure
  bool _obscureTextNewPassword = true;

  // Initially re-new password is obscure
  bool _obscureTextReNewPassword = true;

  @override
  void dispose() {
    super.dispose();
    _txtUserNameController.clear();
    _txtNewPasswordController.clear();
    _txtReInputNewPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpBloc(signUpRepository: Provider.of(context)),
      child: Consumer<SignUpBloc>(
        builder: (context, bloc, child) {
          return BlocListener<SignUpBloc>(
            listener: _handleRegisterAccountEvent,
            child: LoadingTask(
              bloc: bloc,
              child: Scaffold(
                appBar: AppBarWidget(
                  title: tr('register_account'),
                  onBack: () {
                    Navigator.pop(context);
                  },
                ),
                body: Container(
                  padding: const EdgeInsets.only(left: 24, top: 28, right: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _buildUserNameField(bloc),
                        const SizedBox(height: 16),
                        _buildNewPasswordField(bloc),
                        const SizedBox(height: 16),
                        _buildReNewPasswordField(bloc),
                        const SizedBox(height: 24),
                        _buildRegisterButton(bloc),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserNameField(SignUpBloc bloc) {
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloc.inputUserNameStream,
      child: Consumer<String?>(
        builder: (context, msg, child) => Container(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: TextField(
            controller: _txtUserNameController,
            onChanged: (text) {
              bloc.inputUserNameSink.add(text);
            },
            style: const TextStyle(color: Color(0xFF222223)),
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE7E7E7)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE7E7E7)),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE7E7E7)),
              ),
              errorText: msg,
              labelText: tr('first_name'),
              labelStyle: const TextStyle(
                color: Color(0xFF848485),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewPasswordField(SignUpBloc bloc) {
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloc.newInputPasswordStream,
      child: Consumer<String?>(
        builder: (context, msg, child) => Container(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: TextField(
            controller: _txtNewPasswordController,
            onChanged: (text) {
              bloc.newInputPasswordSink.add(text);
            },
            obscureText: _obscureTextNewPassword,
            style: const TextStyle(color: Color(0xFF222223)),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE7E7E7)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE7E7E7)),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE7E7E7)),
              ),
              errorText: msg,
              suffixIcon: GestureDetector(
                onTap: () => _toggle('NewPassword'),
                child: Icon(
                  _obscureTextNewPassword ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF6B6B6D),
                ),
              ),
              labelText: tr('NewPassword'),
              labelStyle: const TextStyle(
                color: Color(0xFF848485),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReNewPasswordField(SignUpBloc bloc) {
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloc.reNewInputPasswordStream,
      child: Consumer<String?>(
        builder: (context, msg, child) => Container(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: TextField(
            controller: _txtReInputNewPasswordController,
            onChanged: (text) {
              bloc.reNewInputPasswordSink.add(text);
            },
            obscureText: _obscureTextReNewPassword,
            style: const TextStyle(color: Color(0xFF222223)),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE7E7E7)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE7E7E7)),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE7E7E7)),
              ),
              errorText: msg,
              suffixIcon: GestureDetector(
                onTap: () => _toggle('RenewPassword'),
                child: Icon(
                  _obscureTextReNewPassword ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF6B6B6D),
                ),
              ),
              labelText: tr('RenewPassword'),
              labelStyle: const TextStyle(
                color: Color(0xFF848485),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(SignUpBloc bloc) {
    return StreamProvider<bool>.value(
      initialData: false,
      value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, isEnable, child) {
          return NormalButton(
            title: tr('register_account').toUpperCase(),
            color: AppColor.primaryColor,
            onPressed: isEnable
                ? () {
                    bloc.handleRegisterAccount(
                      userName: _txtUserNameController.text,
                      password: _txtNewPasswordController.text,
                    );
                  }
                : null,
          );
        },
      ),
    );
  }

  void _toggle(String nameField) {
    setState(() {
      switch (nameField) {
        case 'NewPassword':
          _obscureTextNewPassword = !_obscureTextNewPassword;
          break;
        case 'RenewPassword':
          _obscureTextReNewPassword = !_obscureTextReNewPassword;
          break;
        default:
          break;
      }
    });
  }

  Future<void> _handleRegisterAccountEvent(BaseEvent event) async {
    if (event is SignUpSuccessEvent) {
      final requestLoginModel = RequestAccountModel(
        username: event.username,
        password: event.password,
      );
      // Return Login Page
      Navigator.pop(context, requestLoginModel);
      return;
    }

    if (event is SignUpFailEvent) {
      final snackBar = SnackBar(
        content: Text(event.errMessage),
        backgroundColor: AppColor.colorRed,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Clear Text
      _txtNewPasswordController.clear();
      _txtReInputNewPasswordController.clear();
    }
  }
}
