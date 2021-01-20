import 'package:ourESchool/imports.dart';

class StudentConnectionPage extends StatefulWidget {
  StudentConnectionPage({this.model, this.documentSnapshot, this.color});

  final ChatUsersListPageModel model;
  final DocumentSnapshot documentSnapshot;
  final Color color;

  @override
  _StudentConnectionPageState createState() => _StudentConnectionPageState();
}

class _StudentConnectionPageState extends State<StudentConnectionPage> {
  AppUser student = AppUser();
  List<AppUser> parent = [];

  // ChatUsersListPageModel model;

  @override
  void initState() {
    super.initState();
    // model = widget.model;
    student = widget.model.studentListMap[widget.documentSnapshot.id];
    WidgetsBinding.instance.addPostFrameCallback((_) => getParents());
  }

  bool isLoading = true;

  getParents() async {
    isLoading = true;
    setState(() {});
    await widget.model.getParents(widget.documentSnapshot);
    parent =
        await widget.model.studentsParentListMap[widget.documentSnapshot.id];
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // if (isLoading) getParents();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // backgroundColor: widget.color,
        onPressed: () {
          kbackBtn(context);
        },
        child: Icon(Icons.close),
      ),
      body: Hero(
        transitionOnUserGestures: true,
        tag: widget.documentSnapshot.id + '12',
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildStudentProfileImageViewer(
                        context, student.photoUrl, UserType.STUDENT),
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
                        // Card(
                        //   elevation: 0,
                        //   margin: EdgeInsets.only(left: 10),
                        // child:
                        Container(
                          // width: MediaQuery.of(context).size.width - 20,
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Guardians',
                            textAlign: TextAlign.left,
                            style: ktitleStyle.copyWith(fontSize: 25),
                          ),
                        ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    isLoading
                        ? kBuzyPage(color: Theme.of(context).primaryColor)
                        : Flexible(
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
                                  if (parent[index].displayName == '') {
                                    return Container(
                                      child: Center(
                                        child: Text(
                                          'Parent Not Registered Yet',
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          style: ktitleStyle,
                                        ),
                                      ),
                                    );
                                  }
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      _buildStudentProfileImageViewer(
                                          context,
                                          parent[index].photoUrl,
                                          UserType.PARENT),
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
                                                parentORteacher: parent[index],
                                                student: student,
                                              ),
                                            );
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentProfileImageViewer(
      BuildContext context, String url, UserType userType) {
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
                    url,
                  )
                : userType == UserType.STUDENT
                    ? AssetImage(assetsString.student_welcome)
                    : AssetImage(assetsString.parents_welcome),
          ),
        ),
      ),
    );
  }
}
