// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:marketing/layout/shop_cubit/cubit.dart';
// import 'package:marketing/layout/shop_cubit/states.dart';
// import 'package:marketing/models/home_model.dart';
//
// class ProductsScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ShopCubit,ShopStates>(
//       listener: (context,state){},
//       builder: (context,state)
//       {
//         var cubit = ShopCubit.get(context);
//         return ConditionalBuilder(
//             condition: cubit.homeModel != null,
//             builder: (context)=> builderWidget(cubit.homeModel),
//             fallback: (context)=>Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
//
//   Widget builderWidget(HomeModel model)=> Column(
//     children: [
//       CarouselSlider(
//           items: model.data.banners.map((e)=>Image(
//               image: NetworkImage('${e.image}'),
//               width: double.infinity,
//               fit: BoxFit.cover,
//           )).toList(),
//           options: CarouselOptions(
//             height: 250.0,
//             scrollDirection: Axis.horizontal,
//             autoPlayInterval: Duration(seconds: 3),
//             autoPlayAnimationDuration: Duration(seconds: 1),
//             autoPlayCurve: Curves.fastLinearToSlowEaseIn,
//             reverse: false,
//             viewportFraction: 1.0,
//             enableInfiniteScroll: true,
//             initialPage: 0,
//             autoPlay: true,
//
//           )
//       ),
//     ],
//   );
// }


import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing/layout/shop_cubit/cubit.dart';
import 'package:marketing/layout/shop_cubit/states.dart';
import 'package:marketing/models/categories_model.dart';
import 'package:marketing/models/home_model.dart';
import 'package:marketing/shared/components/components.dart';
import 'package:marketing/shared/style/colors.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {
        if(state is ShopChangeFavoritesSuccessState)
        {
          if(!state.changeFavoritesModel.status)
          {
            showToast(msg: state.changeFavoritesModel.message, state: ToastState.ERROR);
          }
        }
      },
      builder: (context,state)
      {
        var cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context)=> builderWidget(cubit.homeModel,cubit.categoriesModel,context),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },

    );
  }

  Widget builderWidget(HomeModel model,CategoriesModel categories,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model.data.banners.map((e)=>Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 250.0,
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlay: true,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              reverse: false,
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              autoPlayInterval: Duration(seconds: 3),
              scrollDirection: Axis.horizontal,
            )
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>buildCategoriesItem(categories.data.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(
                      width: 15.0,
                    ),
                    itemCount: categories.data.data.length
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Products',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          color: Colors.grey[600],
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 1.0/1.0,
            mainAxisSpacing: 2.5,
            crossAxisSpacing: 2.5,
            children: List.generate(
                model.data.products.length,
                    (index) => buildProductItem(model.data.products[index],context)),

          ),
        ),


      ],
    ),
  );

  Widget buildProductItem(ProductsModel model,context)=>Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 10.0,
              end: 10.0,
              top: 10.0
            ),
            child: Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  height: 200.0,
                  width: double.infinity,
                ),
                if(model.discount != 0)
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
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '${model.name}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              //textAlign: TextAlign.center,

            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Text(
                  '${model.price}',
                  style: TextStyle(
                    color: defaultColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: 15.0
                ),
                if(model.price != model.old_price)
                  Text(
                    '${model.old_price}',
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
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:ShopCubit.get(context).favorites[model.id]?defaultColor:Colors.grey ,
                      child: Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                      ),
                    )
                ),

              ],
            ),
          ),
        ],
      )
  );

  Widget buildCategoriesItem(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(
        image: NetworkImage('${model.image}'),
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.6),
        width: 100.0,
        child: Text(
          '${model.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ],
  );


}

