// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_stream/services/database.dart';
import 'package:video_stream/view/utils/const.dart';
import 'package:video_stream/view/video4.dart';
import 'package:video_stream/widgets/header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchControl = TextEditingController();
  DataBaseServices dataBaseServices = DataBaseServices();
  QuerySnapshot? videoSnapshot;
  late FocusNode myFocusNode;
  int dayCount = 0;

  @override
  void initState() {
    super.initState();
    dataBaseServices.getCourses();
    dataBaseServices.videoShowData().then((value) {
      videoSnapshot = value;
      setState(() {});
    });
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchControl.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  _setDataStart(String res) {
    var documentReference = dataBaseServices.setTime(res);

    Map<String, dynamic> teams = {
      "day": res,
      "startTime": Timestamp.now(),
      "endTime": "0",
    };
    documentReference
        .set(teams)
        .whenComplete(() => print("ans save succesfully"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Constants.mainPadding,
                    vertical: Constants.mainPadding),
                height: 44,
                width: 44,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    primary: Colors.white.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    debugPrint("Menu pressed");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          const Header(),
          Padding(
            padding: EdgeInsets.all(Constants.mainPadding),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                SizedBox(height: Constants.mainPadding * 2),

                // 1. Welcome User
                const Text(
                  "Welcome back\nStudent!",
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),

                SizedBox(height: Constants.mainPadding),

                // 2. Search Textfield
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: TextField(
                    focusNode: myFocusNode,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Constants.textDark,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: "Search courses",
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Constants.textDark,
                        ),
                        onPressed: () {
                          debugPrint("Search pressed");
                        },
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    maxLines: 1,
                    controller: _searchControl,
                  ),
                ),

                SizedBox(height: Constants.mainPadding),

                // 3. Start Learning Button Section
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: const Color(0xFFFEF3F3),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Start Learning \nNew Stuff!",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Constants.textDark),
                          ),

                          const SizedBox(height: 10.0),

                          // Categories Button
                          Container(
                            width: 150,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(10.0),
                                primary: Constants.salmonMain,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Categories",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward,
                                      color: Colors.white, size: 16),
                                ],
                              ),
                              onPressed: () {
                                // Navigate to Learning

                                debugPrint("Pressed here");
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => CategoryScreen()),
                                // );
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    // Image Researching Girl
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        "assets/images/researching.png",
                        width: 200,
                        height: 104,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20.0),

                Text("Courses in progress",
                    style: TextStyle(
                      color: Constants.textDark,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),

                const SizedBox(height: 20.0),

                // List of courses

                StreamBuilder(
                  stream: dataBaseServices
                      .getCourses(), //FirebaseFirestore.instance.collection("courses").snapshots();
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot course = snapshot.data.docs[index];
                        dayCount = index + 1;

                        return GestureDetector(
                          onTap: () async {
                            await _setDataStart(course["dayId"]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoPlayer(
                                          url: course["video"],
                                          dayId: course["dayId"],
                                          indeX: index,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 250, 21, 90),
                                      Color.fromARGB(255, 246, 167, 164)
                                    ],
                                  ),
                                  border:
                                      Border.all(width: 5, color: Colors.black),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Day ",
                                          style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          (dayCount)
                                              .toString(), //"Day **" " :",
                                          style: const TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          " :-", //"Day **" " :",
                                          style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        course["name"],
                                        style: const TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 25),
                                          child: CircleAvatar(
                                            radius: 40.0,
                                            backgroundColor: Colors.black,
                                            child: CircleAvatar(
                                              radius: 37.0,
                                              backgroundImage:
                                                  NetworkImage(course["img"]),
                                              // child: Image.network(course["img"]),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              course["detail"],
                                              style: const TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: const [
                                                Text(
                                                  "Duration: ",
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 60,
                                                ),
                                                Text(
                                                  "Questions: ",
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // ListTile(
                          //   leading: Image.network(course["img"]),
                          //   title: Text(course["name"]),
                          //   subtitle: Text(course["detail"]),
                          // ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
