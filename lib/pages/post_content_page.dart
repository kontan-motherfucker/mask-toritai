import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masktoritai/model/post.dart';

class PostContentPage extends StatefulWidget {
  final Post post;
  const PostContentPage(this.post, {Key? key}) : super(key: key);

  @override
  State<PostContentPage> createState() => _PostContentPageState();
}

class _PostContentPageState extends State<PostContentPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<void> createComment() async{
    await FirebaseFirestore.instance.collection('post').doc(widget.post!.id).collection('comment').add({
      'name': nameController.text,
      'content': contentController.text,
      'time': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: 1200,
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  Container(
                    width: 1100,
                    height: 900,
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
                        SizedBox(height: 250,),
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
                        SizedBox(height: 23,),
                        ElevatedButton(
                          child: const Text('送信'),
                          onPressed: () async{
                            if(nameController.text.isNotEmpty && contentController.text.isNotEmpty){
                              await createComment();
                              nameController.clear();
                              contentController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
