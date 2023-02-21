import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masktoritai/model/comment.dart';
import 'package:masktoritai/model/post.dart';
import 'package:intl/intl.dart' as intl;
import 'package:responsive_builder/responsive_builder.dart';

class PostContentPage extends StatefulWidget {
  final Post post;
  const PostContentPage(this.post, {Key? key}) : super(key: key);

  @override
  State<PostContentPage> createState() => _PostContentPageState();
}

class _PostContentPageState extends State<PostContentPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  static Stream<QuerySnapshot> fetchCommentSnapshot(String id) {
    return FirebaseFirestore.instance.collection('post').doc(id).collection('comment').snapshots();
  }

  Future<void> createComment() async{
    await FirebaseFirestore.instance.collection('post').doc(widget.post!.id).collection('comment').add({
      'name': nameController.text,
      'content': contentController.text,
      'commentDate': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.desktop){
            return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 100,),
                      Container(
                        width: 1100,
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(height: 65,),
                            Container(
                                width: 940,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.post.facility,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    Text(widget.post.prefecture,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromRGBO(136, 136, 136, 1)
                                      ),),
                                  ],
                                )),
                            SizedBox(height: 20,),
                            Divider(
                              height: 3,
                              thickness: 1.5,
                              indent: 80,
                              endIndent: 80,
                              color: Color.fromRGBO(243,243,243,1),
                            ),
                            SizedBox(height: 40,),
                            Container(
                              width: 520,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Color.fromRGBO(248,248,248,1),
                                        child: Icon(Icons.masks,color: Color.fromRGBO(225,225,225,1),),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(widget.post.username,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),),
                                          ),
                                          Container(
                                              child: Text(widget.post.visitDate,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color.fromRGBO(136, 136, 136, 1)
                                                ),)
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    child: Text(widget.post.maskRequirement,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(widget.post.detail,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),),
                                ],
                              ),
                            ),
                            SizedBox(height: 173.99,),
                            StreamBuilder<QuerySnapshot>(
                                stream: fetchCommentSnapshot(widget.post.id),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData) {
                                    return Container(
                                      width: 520,
                                      height: snapshot.data!.docs.length * 132.28,
                                      child: ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          itemExtent: 132.28,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            final doc = snapshot.data!.docs[index];
                                            final Map<String, dynamic> data = doc.data() as Map<String,dynamic>;
                                            Comment comment = Comment(
                                                name: data['name'],
                                                content: data['content'],
                                                commentDate: data['commentDate']);
                                            return Container(
                                              child: ListTile(
                                                tileColor: Colors.white,
                                                title: Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 14.3,),
                                                      Container(
                                                          child: Text(comment.name,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.w700,
                                                            ),)
                                                      ),
                                                      Container(
                                                          child: Text(intl.DateFormat('yyyy/MM/dd').format(comment.commentDate.toDate()),
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Color.fromRGBO(136, 136, 136, 1)
                                                            ),)
                                                      ),
                                                      SizedBox(height: 20,),
                                                      Container(
                                                        child: Text(comment.content,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                leading: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Color.fromRGBO(248,248,248,1),
                                                  child: Icon(Icons.masks,color: Color.fromRGBO(225,225,225,1),),
                                                ),
                                                onTap: () {},
                                              ),
                                            );
                                          }),);
                                  } else {
                                    return Center(child: Text(''),);
                                  }
                                }
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: SizedBox(
                                width: 520,
                                child: TextFormField(
                                  maxLines: 1,
                                  minLines: 1,
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(243,243,243,1),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(243,243,243,1),
                                      ),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '名前',
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: SizedBox(
                                width: 520,
                                child: TextFormField(
                                  maxLines: null,
                                  minLines: 6,
                                  controller: contentController,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(243,243,243,1),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(243,243,243,1),
                                      ),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: '${widget.post.username}さんへのコメント',
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: 360,
                              height: 51.09,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(0, 82, 224, 1), //ボタンの背景色
                                ),
                                onPressed: () async{
                                  if(nameController.text.isNotEmpty && contentController.text.isNotEmpty){
                                    await createComment();
                                    nameController.clear();
                                    contentController.clear();
                                  }
                                },
                                child: Text(
                                  "送信",
                                ),
                              ),
                            ),
                            SizedBox(height: 65,),
                          ],
                        ),
                      ),
                      SizedBox(height: 100,),
                    ],
                  ),
                ),
              ),
            ),
          );}
          if (sizingInformation.deviceScreenType == DeviceScreenType.tablet){
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 100,),
                        Container(
                          width: 1100,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 65,),
                              Container(
                                  width: 940,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.post.facility,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      Text(widget.post.prefecture,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromRGBO(136, 136, 136, 1)
                                        ),),
                                    ],
                                  )),
                              SizedBox(height: 20,),
                              Divider(
                                height: 3,
                                thickness: 1.5,
                                indent: 80,
                                endIndent: 80,
                                color: Color.fromRGBO(243,243,243,1),
                              ),
                              SizedBox(height: 40,),
                              Container(
                                width: 520,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Color.fromRGBO(248,248,248,1),
                                          child: Icon(Icons.masks,color: Color.fromRGBO(225,225,225,1),),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(widget.post.username,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),),
                                            ),
                                            Container(
                                                child: Text(widget.post.visitDate,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color.fromRGBO(136, 136, 136, 1)
                                                  ),)
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      child: Text(widget.post.maskRequirement,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(widget.post.detail,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 173.99,),
                              StreamBuilder<QuerySnapshot>(
                                  stream: fetchCommentSnapshot(widget.post.id),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData) {
                                      return Container(
                                        width: 520,
                                        height: snapshot.data!.docs.length * 132.28,
                                        child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            itemExtent: 132.28,
                                            itemCount: snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              final doc = snapshot.data!.docs[index];
                                              final Map<String, dynamic> data = doc.data() as Map<String,dynamic>;
                                              Comment comment = Comment(
                                                  name: data['name'],
                                                  content: data['content'],
                                                  commentDate: data['commentDate']);
                                              return Container(
                                                child: ListTile(
                                                  tileColor: Colors.white,
                                                  title: Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        SizedBox(height: 14.3,),
                                                        Container(
                                                            child: Text(comment.name,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w700,
                                                              ),)
                                                        ),
                                                        Container(
                                                            child: Text(intl.DateFormat('yyyy/MM/dd').format(comment.commentDate.toDate()),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color.fromRGBO(136, 136, 136, 1)
                                                              ),)
                                                        ),
                                                        SizedBox(height: 20,),
                                                        Container(
                                                          child: Text(comment.content,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  leading: CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor: Color.fromRGBO(248,248,248,1),
                                                    child: Icon(Icons.masks,color: Color.fromRGBO(225,225,225,1),),
                                                  ),
                                                  onTap: () {},
                                                ),
                                              );
                                            }),);
                                    } else {
                                      return Center(child: Text(''),);
                                    }
                                  }
                              ),
                              SizedBox(height: 10,),
                              Center(
                                child: SizedBox(
                                  width: 520,
                                  child: TextFormField(
                                    maxLines: 1,
                                    minLines: 1,
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(243,243,243,1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(243,243,243,1),
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: '名前',
                                      alignLabelWithHint: true,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Center(
                                child: SizedBox(
                                  width: 520,
                                  child: TextFormField(
                                    maxLines: null,
                                    minLines: 6,
                                    controller: contentController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(243,243,243,1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(243,243,243,1),
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: '${widget.post.username}さんへのコメント',
                                      alignLabelWithHint: true,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                width: 360,
                                height: 51.09,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(0, 82, 224, 1), //ボタンの背景色
                                  ),
                                  onPressed: () async{
                                    if(nameController.text.isNotEmpty && contentController.text.isNotEmpty){
                                      await createComment();
                                      nameController.clear();
                                      contentController.clear();
                                    }
                                  },
                                  child: Text(
                                    "送信",
                                  ),
                                ),
                              ),
                              SizedBox(height: 65,),
                            ],
                          ),
                        ),
                        SizedBox(height: 100,),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if (sizingInformation.deviceScreenType == DeviceScreenType.watch){
            return Container(color:Colors.blue);
          }
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 100,),
                      Container(
                        width: 390,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 65,),
                              Container(
                                  width: 390,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.post.facility,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      Text(widget.post.prefecture,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromRGBO(136, 136, 136, 1)
                                        ),),
                                    ],
                                  )),
                              SizedBox(height: 20,),
                              Divider(
                                height: 3,
                                thickness: 1.5,
                                color: Color.fromRGBO(243,243,243,1),
                              ),
                              SizedBox(height: 40,),
                              Container(
                                width: 390,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Color.fromRGBO(248,248,248,1),
                                          child: Icon(Icons.masks,color: Color.fromRGBO(225,225,225,1),),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(widget.post.username,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),),
                                            ),
                                            Container(
                                                child: Text(widget.post.visitDate,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color.fromRGBO(136, 136, 136, 1)
                                                  ),)
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      child: Text(widget.post.maskRequirement,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(widget.post.detail,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 173.99,),
                              StreamBuilder<QuerySnapshot>(
                                  stream: fetchCommentSnapshot(widget.post.id),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData) {
                                      return Container(
                                        height: snapshot.data!.docs.length * 132.28,
                                        child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            itemExtent: 132.28,
                                            itemCount: snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              final doc = snapshot.data!.docs[index];
                                              final Map<String, dynamic> data = doc.data() as Map<String,dynamic>;
                                              Comment comment = Comment(
                                                  name: data['name'],
                                                  content: data['content'],
                                                  commentDate: data['commentDate']);
                                              return Container(
                                                child: ListTile(
                                                  tileColor: Colors.white,
                                                  title: Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        SizedBox(height: 14.3,),
                                                        Container(
                                                            child: Text(comment.name,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w700,
                                                              ),)
                                                        ),
                                                        Container(
                                                            child: Text(intl.DateFormat('yyyy/MM/dd').format(comment.commentDate.toDate()),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color.fromRGBO(136, 136, 136, 1)
                                                              ),)
                                                        ),
                                                        SizedBox(height: 20,),
                                                        Container(
                                                          child: Text(comment.content,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  leading: CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor: Color.fromRGBO(248,248,248,1),
                                                    child: Icon(Icons.masks,color: Color.fromRGBO(225,225,225,1),),
                                                  ),
                                                  onTap: () {},
                                                ),
                                              );
                                            }),);
                                    } else {
                                      return Center(child: Text(''),);
                                    }
                                  }
                              ),
                              SizedBox(height: 10,),
                              Center(
                                child: SizedBox(
                                  width: 390,
                                  child: TextFormField(
                                    maxLines: 1,
                                    minLines: 1,
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(243,243,243,1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(243,243,243,1),
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: '名前',
                                      alignLabelWithHint: true,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Center(
                                child: SizedBox(
                                  width: 390,
                                  child: TextFormField(
                                    maxLines: null,
                                    minLines: 6,
                                    controller: contentController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(243,243,243,1),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromRGBO(243,243,243,1),
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: '${widget.post.username}さんへのコメント',
                                      alignLabelWithHint: true,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                width: 360,
                                height: 51.09,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(0, 82, 224, 1), //ボタンの背景色
                                  ),
                                  onPressed: () async{
                                    if(nameController.text.isNotEmpty && contentController.text.isNotEmpty){
                                      await createComment();
                                      nameController.clear();
                                      contentController.clear();
                                    }
                                  },
                                  child: Text(
                                    "送信",
                                  ),
                                ),
                              ),
                              SizedBox(height: 65,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 100,),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
}