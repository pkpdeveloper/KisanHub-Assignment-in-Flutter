import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kisan_hub/bloc/user_login_bloc.dart';
import 'package:kisan_hub/config/app_config.dart';
import 'package:kisan_hub/config/app_routes.dart';
import 'package:kisan_hub/model/login_status.dart';
import 'package:kisan_hub/model/status.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';
import 'package:kisan_hub/widget/custom_carousel_widget.dart';
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
      key: Key('username'),
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
      key: Key('password'),
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
      key: Key('login_form'),
      elevation: 5,
      margin: const EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 20),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppConfig.primarySwatch, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            SvgPicture.network(
                'https://static.kisanhub.com/corporate/landing/img/kisanhub_logo.svg',
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(5.0),
                    child: const CircularProgressIndicator())),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _userNameWidget,
                  SizedBox(height: 10),
                  _passwordWidget,
                  SizedBox(height: 10),
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
                      )),
                  SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );

    final _carousalWidgets = <Widget>[
      buildImageWidget(
          'https://images.pexels.com/photos/1112080/pexels-photo-1112080.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
      buildImageWidget(
          'https://images.pexels.com/photos/2284170/pexels-photo-2284170.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
      buildImageWidget(
          'https://images.pexels.com/photos/2255801/pexels-photo-2255801.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260')
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(AppConfig.loginScreenTitle),
        ),
        backgroundColor: Colors.grey,
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
                CustomNavigationWidget.of(context).route(AppRoutes.homeWidget);
              }
              return ModalProgressHUD(
                  inAsyncCall: _isLoading,
                  child: Stack(children: <Widget>[
                    CustomCarouselWidget(
                        children: _carousalWidgets,
                        duration: const Duration(seconds: 30)),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[_loginCardWidget],
                    )
                  ]));
            },
          ),
        ));
  }

  Widget buildImageWidget(String imageUrl) {
    return Image.network(imageUrl,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center);
  }
}
