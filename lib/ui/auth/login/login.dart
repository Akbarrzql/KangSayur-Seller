import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/bloc/login_bloc.dart';
import 'package:kangsayur_seller/bloc/state/login_state.dart';
import 'package:kangsayur_seller/common/color_value.dart';
import 'package:kangsayur_seller/model/login_model.dart';
import 'package:kangsayur_seller/ui/auth/login/otp.dart';
import '../../../bloc/event/login_event.dart';
import '../../../repository/login_repository.dart';
import '../../bottom_navigation/bottom_navigation.dart';
import '../../widget/dialog_alret.dart';
import 'package:http/http.dart' as http;
import 'package:kangsayur_seller/ui/auth/login/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {

  bool isPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailHasError = false;


  postDataLogin() async {
    var url = Uri.parse('https://kangsayur.nitipaja.online/api/auth/login');
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
        },body: {
      'email': _emailController.text,
      'password': _passwordController.text,
    });

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      LoginModel login = loginModelFromJson(response.body);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', login.accesToken);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil Mendaftar!'),
        ),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavigation()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email atau password salah'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginPageBloc(loginRepository: LoginRepository()),
      child: Scaffold(
        body: BlocConsumer<LoginPageBloc, LoginPageState>(
          listener: (context, state) {},
          builder: (context, state){
            if(state is InitialLoginPageState){
              return buildInitalLayout(context);
            }else if(state is LoginPageLoading){
              return const Center(child: CircularProgressIndicator());
            }else if(state is LoginPageLoaded){
              return buildLoadedLayout();
            }else if(state is LoginPageError){
              return const Center(child: Text('Error'),);
            }else{
              return buildInitalLayout(context);
            }
          },
        )
      ),
    );
  }

  Widget buildInitalLayout(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              'Masuk',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorValue.secondaryColor,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 200,
              child: Text(
                "Selamat datang kembali! Anda telah dirindukan",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xff1E1E1E),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ColorValue.hintColor,
                  width: 0.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: ColorValue.hintColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: ColorValue.hintColor,
                  width: 0.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: isPasswordVisible,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: ColorValue.hintColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: ColorValue.hintColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Lupa Password?',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: ColorValue.secondaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  if(_emailController.text.isEmpty) {
                    setState(() {
                      _emailHasError = true;
                    });
                    showErrorDialog(context, "Perhatian" ,'Email tidak boleh kosong');
                  } else if(!_isValidEmail(_emailController.text)) {
                    setState(() {
                      _emailHasError = true;
                    });
                    showErrorDialog(context, "Perhatian" ,'Email tidak valid');
                  } else if(_passwordController.text.isEmpty) {
                    showErrorDialog(context, 'Perhatian', 'Password tidak boleh kosong');
                  } else if(_passwordController.text.length < 6) {
                    showErrorDialog(context, 'perhatian', 'Password minimal 6 karakter');
                  } else {
                    BlocProvider.of<LoginPageBloc>(context).add(LoginButtonPressed(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: ColorValue.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Masuk',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildLoadedLayout() => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Selamat Datang',
            style: Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorValue.secondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Anda telah berhasil masuk',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xff1E1E1E),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavigation()));
              },
              style: ElevatedButton.styleFrom(
                primary: ColorValue.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              child: Text(
                'Lanjutkan',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  bool _isValidEmail(String email) {
    // Validasi input email menggunakan Regular Expression
    RegExp emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        caseSensitive: false,
        multiLine: false);

    return emailRegex.hasMatch(email);
  }
}
