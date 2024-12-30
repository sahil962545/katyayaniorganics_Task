import 'package:bloc_clean_coding/utils/extensions/general_ectensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../configs/components/round_button.dart';
import '../../configs/routes/routes_name.dart';
import '../../utils/component.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _HomeViewState();
}

class _HomeViewState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    var height = context.mediaQueryHeight;
    var width = context.mediaQueryWidth;
    return Scaffold(
        appBar: appBar(context, 'Users'),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                  child: Text(
                                snapshot.data!.docs[index]['name'][0]
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              )),
                              title: Text(snapshot.data!.docs[index]['name']
                                  .toString()), // Title of the movie
                              subtitle: Text(snapshot
                                  .data!.docs[index]['email']
                                  .toString()), // Network of the movie
                            ),
                            SizedBox(
                                height: height * 0.04,
                                width: width * 0.9,
                                child: NormalButton(
                                  text: 'Invite user',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.inviteUser,
                                        arguments:
                                            snapshot.data!.docs[index]);
                                  },
                                ))
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Text('No data found');
                }
              } else {
                return const Text('Something Wrong!');
              }
            }));
  }
}
