import 'package:flutter/material.dart';

class DrawerAndPersonIcon extends StatelessWidget {
  const DrawerAndPersonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/drawer_user_image1.png'),
                  ),
                ),
                // child: Image.asset('assets/images/burger_cola_frenchfries.png'),
              ),
            );
          },
        ),
        const CircleAvatar(
          radius: 28.5,
          backgroundColor: Colors.grey,
          child: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.black,
            child: Icon(
              Icons.person,
              size: 52,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
