import 'package:flutter/material.dart';
import 'package:marketing/modules/login/login_screen.dart';
import 'package:marketing/shared/components/components.dart';
import 'package:marketing/shared/network/local/cache_helper.dart';
import 'package:marketing/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel
{
  final String image;
  final String title;
  final String body;

  OnBoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onBoardingController = PageController();
  bool isLast = false;
  List<OnBoardingModel> onBoardingList =
  [
    OnBoardingModel(
      image: 'assets/images/onBoarding1.jpg',
      title: 'Shopping Online',
      body: 'Start with what you eat and know your body needs to have a balanced diet'
    ),
    OnBoardingModel(
      image: 'assets/images/onBoarding2.jpg',
      title: 'Track Your Order',
      body: '(BMI) is being calculated according to your information and a menu with all food calories is provided'
    ),
    OnBoardingModel(
      image: 'assets/images/onBoarding3.jpg',
      title: 'Get Your Order',
      body: 'Tracker to calculate the steps needed to burn extra calories'
    )
  ];

  void submit()
  {
    CacheHelper.saveData(key: 'onBoard', value: true).then((value)
    {
      if(value)
      {
        navigateAndFinish(context, LoginScreen());
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: onBoardingController,
                onPageChanged: (int index)
                {
                  if(index==onBoardingList.length-1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }else
                  {
                    isLast = false;
                  }
                },
                itemBuilder: (context,index)=> buildOnBoardingItem(onBoardingList[index]),
                itemCount: onBoardingList.length,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                TextButton(
                    onPressed: submit,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: defaultColor,
                        fontFamily: 'Carpet2'
                      ),
                    )
                ),
                Spacer(),
                SmoothPageIndicator(
                  controller: onBoardingController,
                  count: onBoardingList.length,
                  effect: ExpandingDotsEffect(
                    spacing: 5.0,
                    expansionFactor:1.1 ,
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if (isLast) {
                      submit();
                    }else
                    {
                      onBoardingController.nextPage(
                          duration: Duration(
                              milliseconds: 750
                          ),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child: Icon(
                      Icons.arrow_forward_ios_outlined
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(OnBoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Image(
            image: AssetImage('${model.image}')
        ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: defaultColor
        ),
      ),
      SizedBox(
        height: 25.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
        maxLines: 3,
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 20.0,
      ),
    ],
  );
}
