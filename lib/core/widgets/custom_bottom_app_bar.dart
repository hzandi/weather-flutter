import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  PageController pageController;

  CustomBottomAppBar({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    Color color = Theme.of(context).primaryColor;
    return BottomAppBar(
      color: color,
      shape: const CircularNotchedRectangle(),
      notchMargin: 4,
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () {
              pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);
            }, icon: const Icon(Icons.home, color: Colors.white,)),
            IconButton(onPressed: () {
              pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.linear);
            }, icon: const Icon(Icons.bookmark, color: Colors.white,))
          ],
        ),
      ),
    );
  }
}
