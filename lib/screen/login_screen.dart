
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controller/login_screen_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCon=TextEditingController();
  TextEditingController passwardCon=TextEditingController();
  LoginController loginController=Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF5F9FA),
        leading: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(10)
              ),
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                   // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network("https://img.freepik.com/free-vector/privacy-policy-concept-illustration_114360-7853.jpg?w=740&t=st=1708704004~exp=1708704604~hmac=f81a4d76ed9418e8f58028782d5cf7758cb1876fe74b6e39b1e0b4936d6caf46",height: 100,width: 100,fit: BoxFit.cover,))
                     , SizedBox(height: 10,),
                      const Text("Log in",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.normal),),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Email",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.normal),),
                          SizedBox(height: 5,),
                          buildContainerTextfield(emailCon,Icons.email_outlined,"Email",false),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Password",style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.normal),),
                          SizedBox(height: 5,),
                          buildContainerTextfield(passwardCon,Icons.lock_open,"Passward",true),
                        ],
                      ),
                      SizedBox(height: 10,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Forget Password?",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.normal),),
                        ],
                      ),

                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){

                          if (_formKey.currentState!.validate()) {
                            bool emailValid = emailCon.text.contains("@");
                           print(emailValid);
                            if(emailValid){
                              loginController.registerUser(emailCon.text, passwardCon.text);
                            }
                            else{
                              Fluttertoast.showToast(
                                  msg: "Please valid email",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }


                          }
                        },
                        child: GetBuilder(
                          init: LoginController(),
                          builder: (con) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 14),
                              decoration: BoxDecoration(
                                color: Color(0xffEC5252),
                                borderRadius: BorderRadius.circular(10),

                              ),
                              child: Center(child:

                           loginController.isloading==false?
                           Text("Log In",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.normal),


                              ):CircularProgressIndicator(color: Colors.white,)

                              ),
                            );
                          }
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Do not Have an account?'),
                Text('Sign up',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildContainerTextfield(TextEditingController textEditingController,IconData icons,String hint,bool ishow) {
    LoginController loginController=Get.put(LoginController());
    return Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF5F9FA),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: GetBuilder(
                    init: LoginController(),
                    builder: (con) {
                      return TextFormField(
                        // The validator receives the text that the user has entered.
                        controller: textEditingController,
                        obscureText:ishow==false?false: loginController.isvisible,
                        decoration:  InputDecoration(
                          prefixIcon: Icon(icons),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          hintText: "${hint}",
                          suffixIcon:ishow==false?SizedBox.shrink():loginController.isvisible? InkWell(
                              onTap: (){
                                loginController.updatevisible();
                              },
                              child: Icon(Icons.visibility)): InkWell(
                              onTap: (){
                                loginController.updatevisible();
                              },

                              child: Icon(Icons.visibility_off))
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field Is Required!';
                          }
                          return null;
                        },
                      );
                    }
                  ),
                );
  }
}
