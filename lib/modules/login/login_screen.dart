import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing/layout/home_layout.dart';
import 'package:marketing/modules/login/cubit/cubit.dart';
import 'package:marketing/modules/login/cubit/states.dart';
import 'package:marketing/modules/register/register_screen.dart';
import 'package:marketing/shared/components/components.dart';
import 'package:marketing/shared/components/constants.dart';
import 'package:marketing/shared/network/local/cache_helper.dart';
import 'package:marketing/shared/style/colors.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state)
        {
          if(state is LoginSuccessState)
          {
            if(state.loginModel.status)
            {
              showToast(msg: state.loginModel.message, state: ToastState.SUCCESS);
              CacheHelper.saveData(key: 'token', value: state.loginModel.data.token).then((value)
              {

                token = state.loginModel.data.token;
                navigateAndFinish(context,HomeLayoutScreen());
              }
              );
            }else
            {
              showToast(msg: state.loginModel.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (context,state)
        {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                            image: AssetImage('assets/images/log.jpeg')
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          children: [
                            defaultFormField(
                                controller: emailController,
                                inputType: TextInputType.emailAddress,
                                labelText: 'Email Address',
                                prefixIcon: Icons.email,
                                validation: (String value)
                                {
                                  if (value.isEmpty)
                                  {
                                    return 'email is required';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                                controller: passwordController,
                                inputType: TextInputType.visiblePassword,
                                labelText: 'Password',
                                obscureText: LoginCubit.get(context).isShow,
                                onSubmit: (value)
                                {
                                  if(formKey.currentState.validate())
                                  {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text
                                    );
                                  }
                                },
                                suffixFunction: ()
                                {
                                  LoginCubit.get(context).passwordVisibility();
                                },
                                prefixIcon: Icons.lock_outline,
                                suffixIcon: LoginCubit.get(context).visibility    ,
                                validation: (String value)
                                {
                                  if (value.isEmpty)
                                  {
                                    return 'password is required';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 25.0,
                            ),

                            ConditionalBuilder(
                              condition: state is !LoginLoadingState,
                              builder: (context)=>defaultButton(
                                function: ()
                                {
                                  if(formKey.currentState.validate())
                                  {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text
                                    );
                                  }
                                },
                                text: 'login',
                                backgroundColor: defaultColor,
                                radius: 20.0,
                              ),
                              fallback: (context)=>Center(child: CircularProgressIndicator()),
                            ),
                            SizedBox(
                              height: 35.0,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Don\'t have account?'
                                ),
                                defaultTextButton(
                                    onPressed: ()
                                    {
                                      navigateTo(context, RegisterScreen());
                                    },
                                    text: 'Register now',
                                ),

                              ],
                            ),
                          ],
                        ),
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
}
