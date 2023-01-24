import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing/layout/shop_cubit/states.dart';
import 'package:marketing/models/favorites_model.dart';
import 'package:marketing/models/home_model.dart';

import '../../layout/shop_cubit/cubit.dart';
import '../../shared/style/colors.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.getFavoritesModel.data.data.length > 0,
          builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildFavoritesItem(ShopCubit.get(context).getFavoritesModel.data.data[index],context),
              separatorBuilder: (context,index)=>Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
              itemCount:cubit.getFavoritesModel.data.data.length
          ),
          fallback: (context)=>Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border_rounded,
                  size: 30.0,
                  color: Colors.grey,
                ),
                Text(
                  'There isn\'t favorites...',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                ),
              ],
            ),
          ),

        );
      },
    );
  }

  Widget buildFavoritesItem(DataFav model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage('${model.product.image}'),
                height: 120.0,
                width: 120.0,
              ),
              if(model.product.discount != 0)
                Container(
                  color: Colors.red,
                  child: Text(
                    'OFFER',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.product.name}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  //textAlign: TextAlign.center,

                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.product.price}',
                      style: TextStyle(
                        color: defaultColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                        width: 15.0
                    ),
                    if(model.product.discount != 0)
                      Text(
                        '${model.product.oldPrice}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough
                        ),

                      ),
                    Spacer(),
                    IconButton(
                        onPressed: ()
                        {
                          ShopCubit.get(context).changeFavorites(model.product.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:ShopCubit.get(context).favorites[model.product.id]?defaultColor:Colors.grey ,
                          child: Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.white,
                          ),
                        )
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

}
