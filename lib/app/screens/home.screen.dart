import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../meta/component/sheets/car.sheet.dart';
import '../const/global.const.dart';
import '../const/route.const.dart';
import '../notifiers/auth.notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _nameController;
  late FocusNode _nameFocusNode;
  @override
  void initState() {
    _nameController = TextEditingController(text: authService.name);
    _nameFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.97),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Tooltip(
            message: 'Add new car',
            child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => const CarSheet(),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () async {
              await GoogleSignInProvider().logout();
              await Navigator.pushReplacementNamed(context, RouteNames.login);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                  image: NetworkImage('https://source.unsplash.com/random'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Welcome',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            EditableText(
              controller: _nameController,
              focusNode: _nameFocusNode,
              backgroundCursorColor: Colors.transparent,
              cursorColor: Theme.of(context).primaryColor,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              onEditingComplete: () async {
                _nameFocusNode.unfocus();
                await db.setUserName(_nameController.text);
              },
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: db.firestore
              .collection('Users')
              .doc(authService.auth.currentUser!.uid)
              .collection('Cars')
              // .orderBy('creation', descending: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs =
                snapshot.data?.docs;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error while fetching data'),
              );
            }
            for (QueryDocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data?.docs ?? []) {
              print(doc.data());
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                    itemCount: docs?.length ?? 0,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.withOpacity(0.2),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: Image.asset(
                                      'assets/car1.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        docs?[i].data()['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                        ),
                                      ),
                                      Text(
                                        docs?[i].data()['number'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        docs?[i].data()['color'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        docs?[i].data()['model'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            );
          }),
    );
  }
}
