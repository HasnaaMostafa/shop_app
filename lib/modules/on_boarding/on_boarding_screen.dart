import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/BoardingModel.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/login_screen.dart';




class OnBoardingScreen extends StatefulWidget {
   const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   var boardController=PageController();

  List <BoardingModel> boarding=[
    BoardingModel(
        image: "assets/images/E.png",
        fit: BoxFit.cover,
        title: "Explore",
        body:  "Choose What ever the Product you wish for with the easiest way possible",),
     BoardingModel(
        image: "assets/images/EE.png",
        fit: BoxFit.cover,
        title: "Shipping",
        body:  "Yor Order will be shipped to you as fast as possible by our carrier"),
     BoardingModel(
        image: "assets/images/EEE.png",
        title: "Make the Payment",
        body: "Pay with the safest way possible either by cash or credit cards")
  ];
   bool isLast = false;
   void submit(){
     CacheHelper.saveData(key:"OnBoarding", value:true)
         .then((value){
           if(value){
             Navigator.pushAndRemoveUntil(context,
                 MaterialPageRoute(builder:(BuildContext context)=>LoginScreen()),
                     (route) => false);
           }
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit();
          },
              child: const Text("Skip"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if (index==boarding.length-1){
                    setState(() {
                      isLast = true;
                    });
                    debugPrint("last");
                  }
                  else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context,index)=>buildBoardItem(boarding[index]),
                itemCount:boarding.length),
            ),
            const SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.purple,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if (isLast){
                        submit();
                      }
                      else{
                        boardController.nextPage(
                            duration: const Duration(
                                milliseconds: 750
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                   child:const Icon(
                  Icons.arrow_forward_ios,
                ) ,),
              ],
            ),
          ],
        ),
      )

    );
  }

  Widget buildBoardItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage(model.image),
             fit: model.fit,),
      ),
      Text(
        model.title,style: const TextStyle(
        fontSize: 25.0,
      ),
      ),
      const SizedBox(
        height: 15.0,),
      Text(
        model.body,style: const TextStyle(
        fontSize: 15.0,
      ),
      ),
      const SizedBox(
        height: 15.0,),

    ],
  );
}