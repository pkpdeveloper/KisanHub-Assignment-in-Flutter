import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisan_hub/bloc/user_login_bloc.dart';
import 'package:kisan_hub/config/app_config.dart';
import 'package:kisan_hub/config/app_routes.dart';
import 'package:kisan_hub/model/login_status.dart';
import 'package:kisan_hub/model/status.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';
import 'package:kisan_hub/widget/custom_navigation.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserLoginBloc userLoginBloc = BlocProvider.of<UserLoginBloc>(context);

    final _userNameWidget = TextFormField(
      controller: _usernameController,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Please enter your username',
        labelText: 'Username *',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter username';
        }
        return null;
      },
    );

    final _passwordWidget = TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        icon: Icon(Icons.vpn_key),
        hintText: 'Please enter your password',
        labelText: 'Password *',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
    );

    final _loginCardWidget = Card(
      elevation: 5,
      margin: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppConfig.primarySwatch, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _userNameWidget,
              _passwordWidget,
              Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      highlightElevation: 2,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // Process data.
                          FocusScope.of(context).requestFocus(FocusNode());
                          userLoginBloc.login(_usernameController.text,
                              _passwordController.text);
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(AppConfig.loginScreenTitle),
        ),
        body: Builder(
          builder: (context) => StreamBuilder<LoginStatus>(
            stream: userLoginBloc.loginStream,
            builder: (context, snapshot) {
              if (snapshot.data != null &&
                  snapshot.data.status == Status.started) {
                _isLoading = true;
              }
              if (snapshot.data != null &&
                  snapshot.data.status == Status.completed &&
                  snapshot.data.userToken != null) {
                _isLoading = false;
                AppConfig.userAuthToken = snapshot.data.userToken;
                CustomNavigationWidget.of(context).route(AppRoutes.main);
              }
              return ModalProgressHUD(
                inAsyncCall: _isLoading,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[_loginCardWidget],
                ),
              );
            },
          ),
        ));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
