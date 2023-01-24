import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing/layout/home_layout.dart';
import 'package:marketing/modules/register/cubit/cubit.dart';
import 'package:marketing/modules/register/cubit/states.dart';
import 'package:marketing/shared/components/constants.dart';
import 'package:marketing/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';
import '../../shared/style/colors.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if (state is RegisterSuccessState)
          {
            if (state.registerModel.status)
            {
              showToast(msg: state.registerModel.message, state: ToastState.SUCCESS);
              CacheHelper.saveData(key: 'token', value: state.registerModel.data.token).then((value)
              {
                token = state.registerModel.data.token;
                navigateAndFinish(context, HomeLayoutScreen());
              }
              );
            }else
            {
              showToast(msg: state.registerModel.message, state: ToastState.ERROR);
            }
            
          }  
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
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
                            image: AssetImage('assets/images/onBoarding2.jpg')
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          children: [
                            defaultFormField(
                                controller: nameController,
                                inputType: TextInputType.name,
                                labelText: 'User Name',
                                prefixIcon: Icons.person,
                                validation: (String value)
                                {
                                  if (value.isEmpty)
                                  {
                                    return 'user name is required';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                                controller: phoneController,
                                inputType: TextInputType.phone,
                                labelText: 'Phone',
                                prefixIcon: Icons.phone_android,
                                validation: (String value)
                                {
                                  if (value.isEmpty)
                                  {
                                    return 'phone is required';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
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
                                obscureText: RegisterCubit.get(context).isShow,
                                onSubmit: (value)
                                {
                                  if(formKey.currentState.validate())
                                  {
                                    RegisterCubit.get(context).getRegisterData(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text
                                    );
                                  }
                                },
                                suffixFunction: ()
                                {
                                  RegisterCubit.get(context).passwordVisibility();
                                },
                                prefixIcon: Icons.lock_outline,
                                suffixIcon: RegisterCubit.get(context).visibility    ,
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
                              condition: state is! RegisterLoadingState,
                              builder: (context)=>defaultButton(
                                function: ()
                                {
                                  if(formKey.currentState.validate())
                                  {
                                    RegisterCubit.get(context).getRegisterData(
                                        name: nameController.text,
                                        phone: phoneController.text,
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
