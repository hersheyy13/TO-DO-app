import 'package:calendar/home.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  final int _pageCount = 3; // Number of pages in your PageView
 bool isLastPage = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_pageController.page! < _pageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn,
      );
    }
  }

  void _skipToEnd() {
    _pageController.jumpToPage(_pageCount - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:// Color.fromARGB(255, 94, 72, 40),
              Color.fromARGB(235, 76, 142, 75),
            //  Color.fromARGB(255, 177, 142, 90),
      body: Stack(
        
        children: [
          PageView(
            onPageChanged: (index)=> setState(()=> isLastPage = _pageCount -1 == index),
            controller: _pageController,
            children: [
              _buildPage('assets/cal.1.png', 'CALENDER  ^-^', 'This calculator makes you happy',),
              _buildPage('assets/cal.2.png', 'SAVE YOUR DATES', 'This calculator makes you happy'),
              _buildPage('assets/cal.3.png', 'WELCOME BUDDIES!!', ''),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Padding for the buttons
              child:isLastPage? getStarted(context): Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _skipToEnd, // Skip to the last page
                    child: Text('Skip'),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pageCount,
                    effect: WormEffect(
                      activeDotColor: const Color.fromARGB(255, 100, 98, 96),
                      dotColor: const Color.fromARGB(255, 255, 255, 255),
                      dotHeight: 8.0,
                      dotWidth: 8.0,
                      spacing: 16.0,
                    ),
                  ),
                  TextButton(
                    onPressed: _nextPage, // Move to the next page
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String imagePath, String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 300),
        SizedBox(height: 15),
        Text(
          title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 148, 151, 221),),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }
}
Widget getStarted(BuildContext context){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(235, 250, 252, 251),
    ),
    width: MediaQuery.of(context).size.width* .9,
    height: 55,
    // onboarding one get started
    child: TextButton(onPressed: ()  {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    },
   child: Text('Get Started',style: TextStyle(color: Colors.black) ,),)
   
   );
}