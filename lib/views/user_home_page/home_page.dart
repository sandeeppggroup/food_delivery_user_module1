import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image:
                      AssetImage('assets/images/burger_cola_frenchfries.png'),
                )),
                // child: Image.asset('assets/images/burger_cola_frenchfries.png'),
              ),
            );
          }),
        ),
        drawer: Drawer(),
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_downward))
                  ],
                ),
                const Text('Choose Your Taste'),
                const Text('Food You Love'),
                Container(
                  decoration: const BoxDecoration(),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Search Food Here Foody',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
