import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing/layout/shop_cubit/cubit.dart';
import 'package:marketing/layout/shop_cubit/states.dart';
import 'package:marketing/shared/components/components.dart';
import 'package:marketing/shared/components/constants.dart';
import 'package:marketing/shared/style/colors.dart';

class SettingsScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {
        if(state is ShopGetUserDataSuccessState)
        {
            nameController.text=state.userModel.data.name;
            emailController.text=state.userModel.data.email;
            phoneController.text=state.userModel.data.phone;

        }
      },
      builder: (context,state)
      {
        var model = ShopCubit.get(context).userModel;
        nameController.text=model.data.name;
        emailController.text=model.data.email;
        phoneController.text=model.data.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopUpdateUserDataLoadingState)
                  LinearProgressIndicator(),


                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      inputType: TextInputType.name,
                      labelText: 'User Name',
                      prefixIcon: Icons.person,
                      validation: (String value)
                      {
                        if (value.isEmpty)
                        {
                          return 'is required';
                        }
                        return null;
                      }
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  defaultFormField(
                      controller: emailController,
                      inputType: TextInputType.emailAddress,
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                      validation: (String value)
                      {
                        if (value.isEmpty)
                        {
                          return 'is required';
                        }
                        return null;
                      }
                  ),

                  SizedBox(
                    height: 20.0,
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
                          return 'is required';
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  defaultButton(
                    function: ()
                    {
                      if (formKey.currentState.validate())
                      {
                        ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,

                        );
                      }
                    },
                    text: 'update',
                    radius: 20.0,
                    backgroundColor: defaultColor,

                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  defaultButton(
                    function: ()
                    {
                      signOut(context);
                    },
                    text: 'log out',
                    radius: 20.0,
                    backgroundColor: defaultColor,

                  ),
                ],
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()) ,

        );
      },

    );
  }
  
}
