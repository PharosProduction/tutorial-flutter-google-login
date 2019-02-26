import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutorial/blocs/login_provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login screen'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _buildGoogleSignInBt(bloc),
            _buildSignOutBt(bloc),
            _buildUserInfo(bloc),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleSignInBt(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.googleAccount,
      builder: (BuildContext context, AsyncSnapshot<GoogleSignInAccount> snapshot) {
        return RaisedButton(
          child: Text('Login with Google'),
          color: Color(Colors.blueAccent.blue),
          textColor: Colors.white,
          onPressed: !snapshot.hasData
              ? () async {
                  bloc.sigInGoogle();
                }
              : null,
        );
      },
    );
  }

  Widget _buildSignOutBt(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.googleAccount,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Text('Logout'),
            color: Color(Colors.blue.blue),
            textColor: Colors.white,
            onPressed: snapshot.hasData
                ? () async {
                    bloc.signOutGoogle();
                  }
                : null);
      },
    );
  }

  Widget _buildUserInfo(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.googleAccount,
      builder: (BuildContext context, AsyncSnapshot<GoogleSignInAccount> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Text('No info!!!'),
          );
        }

        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[Text('Name: '), Text(snapshot.data.displayName.toString())],
            ),
            Row(
              children: <Widget>[Text('Email: '), Text(snapshot.data.email)],
            ),
            Row(
              children: <Widget>[Text('Id: '), Text(snapshot.data.id)],
            ),
            Image.network(
              snapshot.data.photoUrl.toString(),
              width: 200.0,
              height: 200.0,
            ),
          ],
        );
      },
    );
  }
}
