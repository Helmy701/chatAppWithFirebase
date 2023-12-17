import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/models/users.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static String id = 'HomeScreen';
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  List<Users> usersList = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: users.orderBy('time').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              usersList.add(Users.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                titleSpacing: 15,
                backgroundColor: Colors.white,
                elevation: 0,
                title: const Row(
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512__340.jpg'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Chats',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      )),
                  IconButton(
                    onPressed: () {},
                    icon: const CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[350],
                        ),
                        padding: const EdgeInsets.all(5),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.search,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Search'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 98,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, item) {
                            return buildStatusItem(item);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 7,
                          ),
                          itemCount: usersList.length,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildChatItem(index),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 20,
                              ),
                          itemCount: usersList.length)
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Text('loading...');
          }
        });
  }

  Widget buildChatItem(int i) => Row(
        children: [
          Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset(usersList[i].photo),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.green,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  usersList[i].name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'hello my name is Ahmed Helmy asd;lkjads',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const Text('02:00 pm')
                  ],
                ),
              ],
            ),
          ),
        ],
      );
  Widget buildStatusItem(int i) => SizedBox(
        width: 65,
        child: //Stack(
            // alignment: AlignmentDirectional.bottomCenter,
            // children: [
            Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Image.asset(usersList[i].photo),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 3,
                    right: 3,
                  ),
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              usersList[0].name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        //   ],
      );
}
