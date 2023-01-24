import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing/layout/shop_cubit/cubit.dart';
import 'package:marketing/layout/shop_cubit/states.dart';
import 'package:marketing/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoriesModel.data.data.length > 0,
          builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildCategoriesItem(cubit.categoriesModel.data.data[index]),
              separatorBuilder: (context,index)=>Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
              itemCount: cubit.categoriesModel.data.data.length
          ),
          fallback:(context)=>Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border_rounded,
                  size: 30.0,
                  color: Colors.grey,
                ),
                Text(
                  'There isn\'t categories...',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ) ,
        );
      },
    );
  }

  Widget buildCategoriesItem(DataModel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          width: 150.0,
          height: 150.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.arrow_forward_ios_outlined)
        ),
      ],
    ),
  );
}
