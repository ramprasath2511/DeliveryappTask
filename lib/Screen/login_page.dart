import 'package:deliveryapp/Screen/create_order_page.dart';
import 'package:deliveryapp/Services/userController.dart';
import 'package:deliveryapp/Widgets/AnimationRoute.dart';
import 'package:deliveryapp/Widgets/buttonDapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/Auth/auth_bloc.dart';
import '../Bloc/Auth/auth_bloc.dart';
import '../Models/message_model.dart';
import '../Widgets/colorsDapp.dart';
import '../Widgets/formFieldDapp.dart';
import '../Widgets/modal_loading.dart';
import '../Widgets/textDapp.dart';
import '../Widgets/validate_form.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if( state is LoadingAuthState ){
            modalLoading(context);
          } else if ( state is FailureAuthState ){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: TextDapp(text: state.error, color: Colors.white),
                    backgroundColor: Colors.red
                )
            );
          } else if ( state is SuccessAuthState ) {
            Navigator.pushAndRemoveUntil(
                context, routeDapp(page: CreatOrder("")), (route) => false);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: TextDapp(text: "Login Successfully", color: Colors.white),
                    backgroundColor: Colors.green
                )
            );
          }
          },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsDapp.primaryColor,
          elevation: 0,
          leadingWidth: 80,
          title: Image.asset('Assests/logo.png', height: 25 ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: ListView(
              //physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              children: [

                const SizedBox(height: 40.0),
                Container(
                  alignment: Alignment.center,
                  child:  TextDapp(text: 'Login', fontSize: 35, fontWeight: FontWeight.bold, color: ColorsDapp.primaryColor ),
                ),
                const SizedBox(height: 60.0),
                FormFieldDapp(
                  controller: _emailController,
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  validator: validatedEmail,
                ),
                const SizedBox(height: 25.0),
                FormFieldDapp(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  validator: passwordValidator,
                ),
                const SizedBox(height: 10.0),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {},
                        child: TextDapp(text: 'Forgot Password?', fontSize: 17, fontWeight: FontWeight.bold, color: ColorsDapp.primaryColor )
                    )
                ),
                const SizedBox(height: 40.0),
                ButtonDapp(
                  text: 'Login',
                  fontSize: 21,
                  height: 50,
                  fontWeight: FontWeight.w500, color: ColorsDapp.primaryColor,
                  onPressed: () {
                    if( _keyForm.currentState!.validate() ){

                      authBloc.add( LoginEvent(_emailController.text, _passwordController.text));

                    }
                  },
                ),
                const SizedBox(height: 30.0),
                Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextDapp(text: 'New here? ', color: Colors.black87 , fontWeight: FontWeight.w500 ),
                    InkWell(
                      onTap: () {},
                      child: Text( 'Create an account', style: TextStyle( color:ColorsDapp.primaryColor, fontSize:18, fontWeight: FontWeight.w500, decoration: TextDecoration.underline, ),),
                    ),],
                    ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_back, color: Colors.grey, size: 20),
                    TextDapp(text: ' Back to user type screen', color: Colors.grey , fontWeight: FontWeight.w500 ),
                    ]
                ),

              ],
            ),
          ),
        ),
            ),
            );
  }
}