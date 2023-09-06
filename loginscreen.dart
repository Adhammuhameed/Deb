import 'package:camera/camera.dart';
import 'package:deb/modules/login/login_navigator.dart';
import 'package:deb/modules/login/login_screen_vm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../base.dart';
import '../page_two/page_two.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginScreenViewModel>
    implements LoginNavigator {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // bool isButtonActive=true;
  //bool accepted = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _email = "";
TextEditingController _password = TextEditingController();
// late TextEditingController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    // controller = TextEditingController();
    // controller.addListener(() {
    //   final isButtonActive = controller.text.isNotEmpty;
    //   setState(() => this.isButtonActive=isButtonActive);
    // });
  }
  // @override
  // void dispose(){
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => viewModel,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/image.1.jpg',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            //backgroundColor: Colors.white70,
            appBar: AppBar(
              elevation: 0,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              title: Text(
                'Login',
                style: TextStyle(fontSize: 21),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formkey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // TextFormField(
                      //   //textInputAction: TextInputAction.next,
                      //   controller: emailController,
                      //   decoration: InputDecoration(
                      //       hintText: "Email",
                      //       labelText: 'Email Address',
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: BorderSide(color: Colors.orange),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //           borderSide: BorderSide(
                      //             color: Colors.orange,
                      //           ))),
                      //   validator: (value) {
                      //     if (value == null ) {
                      //       final bool emailValid = RegExp(
                      //               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      //           .hasMatch(value!);
                      //       if (!emailValid) {
                      //         return "Please Enter Valid Email";
                      //       }else if(value.isEmpty){
                      //         return "Please Enter Email";
                      //       }
                      //       print(value);
                      //       return null;
                      //     }
                      //   },
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),

                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Please Enter Email';
                        }
                        // if(RegExp(
                        // r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        //     .hasMatch(value)){
                        //   return "Please Enter Valid Email";
                        // }
                        return null;
                      },
                      onSaved: (email) => _email = email!,
                    ),
                    SizedBox(height:10 ),
                    TextFormField(
                      controller: _password,
                      decoration: InputDecoration(labelText: "Password",
                      helperStyle: TextStyle(color: Colors.orange),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.orange)
                          ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange)
                        )
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          //_password.length>6;
                          return "Please Enter Password";
                        }else
                        return null;
                      },
                    ),

                    // TextFormField(
                      //   textInputAction: TextInputAction.next,
                      //   controller: passwordController,
                      //   obscureText: accepted,
                      //   decoration: InputDecoration(
                      //     hintText: "Password",
                      //     labelText: 'Password',
                      //     helperStyle: TextStyle(color: Colors.orange),
                      //     suffixIcon: IconButton(
                      //         icon: Icon(accepted
                      //             ? Icons.visibility_off
                      //             : Icons.visibility),
                      //         onPressed: () {
                      //           setState(() {
                      //             accepted = !accepted;
                      //           });
                      //         }),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: BorderSide(color: Colors.orange),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: BorderSide(color: Colors.orange),
                      //     ),
                      //   ),
                      //   validator: (text) {
                      //     if (text == null || text == "") {
                      //       //if(text!.length<6){
                      //       return "Please enter your Password";
                      //     } else
                      //       print(text);
                      //     return null;
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text(
                      //     'Forgot Password',
                      //     style: TextStyle(color: Colors.orange, fontSize: 15),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      ElevatedButton(
                        onPressed:  () {
                          // setState(() => isButtonActive = false );
                          // controller.clear();
                          // Email
                          // login(_email , _password, page_Two);
                          // if(formkey.currentState!.validate()){
                          //   return;
                          // }else{
                          //   print('Retry');
                          // }
                          if (_email.isEmpty|| _email==null) {
                            //validateAndSave();
                            login(_email, _password,page_Two);
                           }
                            else {
                            print("Please Enter Email And Password");
                          }
      Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const page_Two()),
    );
  } ,

                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login(String email,password, Object push) async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
    }
    final auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (formkey.currentState!.validate() == true) {
      viewModel.login(emailController.text, passwordController.text);
    }
  }

  @override
  LoginScreenViewModel initViewModel() {
    return LoginScreenViewModel();
  }

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading({String message = "Loading..."}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Row(
              children: [CircularProgressIndicator(), Text(message)],
            ),
          ),
        );
      },
    );
  }

  @override
  void showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
  }

  @override
  void goToAdmin(myUser) {
    Navigator.pushReplacementNamed(context, '');
  }
}

