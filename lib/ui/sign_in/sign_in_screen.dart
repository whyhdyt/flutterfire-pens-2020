import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/ui/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  static const String routeName = 'sign-in-screen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _Label('Email'),
          TextField(
            decoration: InputDecoration(hintText: 'example: john@doe.com'),
            autocorrect: false,
            autofocus: true,
            controller: _emailController,
            focusNode: _emailFocusNode,
          ),
          SizedBox(height: 16.0),
          _Label('Password'),
          TextField(
            decoration: InputDecoration(hintText: 'Input your password here'),
            obscureText: true,
            controller: _passwordController,
            focusNode: _passwordFocusNode,
          ),
          SizedBox(height: 16.0),
          FlatButton(
            onPressed: () {},
            color: Colors.blue,
            child: Text(
              'SIGN IN',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    // TODO(lucky): do validate forms
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      setState(() {
        _isLoading = true;
      });

      final UserCredential credential = await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        ChatScreen.routeName,
        (_) => false,
      );
    } on Exception catch (e) {
      // show something, e.g alert dialog
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class _Label extends StatelessWidget {
  const _Label(this.data, {Key key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 18.0,
        color: Color(0xFF444444),
        fontWeight: FontWeight.w600,
      ),
      child: Text(data),
    );
  }
}
