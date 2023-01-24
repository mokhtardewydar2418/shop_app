import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing/models/search_model.dart';
import 'package:marketing/modules/search_screen/cubit/cubit.dart';
import 'package:marketing/modules/search_screen/cubit/states.dart';
import 'package:marketing/shared/components/components.dart';

import '../../layout/shop_cubit/cubit.dart';
import '../../shared/style/colors.dart';

class SearchScreen extends StatelessWidget {


  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        inputType: TextInputType.text,
                        labelText: 'Search',
                        onChange: (text)
                        {
                          SearchCubit.get(context).search(text);
                        },
                        prefixIcon: Icons.search,
                        validation: (String value)
                        {
                          if(value.isEmpty)
                          {
                            return 'enter text to search';
                          }
                          return null;
                        }
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)

                      LinearProgressIndicator(),

                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index)=>buildSearchItem(SearchCubit.get(context).searchModel.data.data[index],context,isOldPrice: false),
                          separatorBuilder: (context,index)=>Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey,
                          ),
                          itemCount:SearchCubit.get(context).searchModel.data.data.length,
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }

  Widget buildSearchItem(Product model,context,{bool isOldPrice = true}) =>Padding(
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
                image: NetworkImage('${model.image}'),
                height: 120.0,
                width: 120.0,
              ),
              if(model.discount != 0 && isOldPrice)
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
                Spacer(),
                Row(
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
                    if(model.discount != 0 && isOldPrice)
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough
                        ),

                      ),
                    Spacer(),
                    // IconButton(
                    //     onPressed: ()
                    //     {
                    //       ShopCubit.get(context).changeFavorites(model.id);
                    //     },
                    //     icon: CircleAvatar(
                    //       radius: 15.0,
                    //       backgroundColor:.get(context).favorites[model.id]?defaultColor:Colors.grey ,
                    //       child: Icon(
                    //         Icons.favorite_border_rounded,
                    //         color: Colors.white,
                    //       ),
                    //     )
                    //),

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
