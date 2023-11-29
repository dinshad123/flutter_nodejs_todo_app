import 'package:fluter_nodejs_todo_app/avatars.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Widget child;
  const Body({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -18,
              left: -40,
              child: Image.asset(lefttopLogin),
            ),
            Positioned(
                bottom: -50,
                child: Center(
                  child: Image.asset(bottomCenterLogin),
                )),
            SafeArea(maintainBottomViewPadding: true, child: child),
          ],
        ),
      ),
    );
  }
}
