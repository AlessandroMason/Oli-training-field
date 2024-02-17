import 'package:flutter/material.dart';
import 'package:oli_training_field/old_possible_pages/AddPannelPolling.dart';
import 'package:oli_training_field/old_possible_pages/intro_page1.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoardingScreens extends StatefulWidget {
  OnBoardingScreens({Key? key, required this.uid}) : super(key: key);
  String uid;
  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  bool isLastPage = false;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              index == 2
               ? isLastPage = true : isLastPage = false;
            });
          },
          children: [
            IntroPage1(
              message: 'Welcome to Kayros',
            ),
            /* Prioriry_page(), */
            Container(
              child: AddPannelpollingPeople(
                      questionnum: 7,
                      uid: widget.uid,
                      onboarding: true
                      ),
            ),
            
           /*  SafeArea(
              
              child: Container(
                color: kMainPageColor,
                child: Column(
                children: [
                  Expanded(child: Goal_page(uid: widget.uid)),
                  SizedBox(height: 150,),
                ],
                          ),
              )), */
            
             IntroPage1(
              message: 'Step 3: choose your account features, (don\'t worry if you select a profile image and dosn\'t show immediately)',
            ), 
            //! here if you want we can insert a profile page
             /* Profile_page(
              uid: widget.uid, isonboarding: true
            ), */
             
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //skip
              GestureDetector(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text('skip'),
                ),
                onTap: () {
                  _pageController.jumpToPage(2);
                },
              ),
              //dot indicator
              const SizedBox(
                width: 50,
              ),
              SmoothPageIndicator(controller: _pageController, count: 3),
              const SizedBox(
                width: 50,
              ),
              //next or done

              !isLastPage
                  ? GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text('next'),
                      ),
                      onTap: () {
                        _pageController.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeIn);
                      },
                    )
                  : GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text('done'),
                      ),
                      onTap: () async {
                        //! lol here there are some logic
                        
                      },
                    ),
            ],
          ),
        ),
      ],
    ));
  }
}
