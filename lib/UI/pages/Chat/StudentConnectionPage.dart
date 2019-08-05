import 'package:ourESchool/imports.dart';

class StudentConnectionPage extends StatefulWidget {
  StudentConnectionPage(
      {this.model, this.studentDocumenetSnapshotKey, this.color});

  final StudentListPageModel model;
  final String studentDocumenetSnapshotKey;
  final Color color;

  @override
  _StudentConnectionPageState createState() => _StudentConnectionPageState();
}

class _StudentConnectionPageState extends State<StudentConnectionPage> {
  User student = User();
  List<User> parent = [];

  @override
  void initState() {
    super.initState();
    student = widget.model.studentListMap[widget.studentDocumenetSnapshotKey];
    parent =
        widget.model.studentsParentListMap[widget.studentDocumenetSnapshotKey];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: widget.color,
      // appBar: TopBar(
      //   child: kBackBtn,
      //   onPressed: () {
      //     kbackBtn(context);
      //   },
      //   title: student.displayName,
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: widget.color,
        onPressed: () {
          kbackBtn(context);
        },
        child: Icon(Icons.close),
      ),
      body: Hero(
        transitionOnUserGestures: true,
        tag: widget.studentDocumenetSnapshotKey,
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _buildStudentProfileImageViewer(
                              context, student.photoUrl),
                          Card(
                            elevation: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 20,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                student.displayName,
                                textAlign: TextAlign.center,
                                style: ktitleStyle.copyWith(fontSize: 25),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Card(
                                elevation: 0,
                                margin: EdgeInsets.only(left: 10),
                                child: Container(
                                  // width: MediaQuery.of(context).size.width - 20,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Guardians',
                                    textAlign: TextAlign.left,
                                    style: ktitleStyle.copyWith(fontSize: 25),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              // color: Colors.red,
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 9 / 14,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                ),
                                itemCount: parent.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      _buildStudentProfileImageViewer(
                                          context, parent[index].photoUrl),
                                      Card(
                                        elevation: 0,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          child: Text(parent[index].displayName,
                                              overflow: TextOverflow.ellipsis,
                                              style: ktitleStyle),
                                        ),
                                      ),
                                      Container(
                                        child: FlatButton(
                                          child: Text(
                                            'Chat',
                                            style: ksubtitleStyle.copyWith(
                                                fontSize: 18),
                                          ),
                                          onPressed: () {
                                            kopenPage(
                                                context,
                                                MessagingScreen(
                                                  user: parent[index],
                                                ));
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentProfileImageViewer(BuildContext context, String url) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,r
          image: DecorationImage(
            fit: BoxFit.scaleDown,
            image: url != 'default'
                ? NetworkImage(
                    student.photoUrl,
                  )
                : NetworkImage(
                    "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png",
                  ),
          ),
        ),
      ),
    );
  }
}
