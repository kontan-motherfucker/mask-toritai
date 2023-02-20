import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masktoritai/model/post.dart';
import 'package:masktoritai/pages/post_content_page.dart';
import 'package:masktoritai/pages/posts.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  final postCollection = FirebaseFirestore.instance.collection('post');
  TextEditingController usernameController = TextEditingController();
  TextEditingController facilityController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  var _groupValue = 0;
  late String maskRequirement = '';

  String? selectedPrefecture;
  final japan = <String>[
    "",
    "北海道",
    "青森県",
    "岩手県",
    "宮城県",
    "秋田県",
    "山形県",
    "福島県",
    "茨城県",
    "栃木県",
    "群馬県",
    "埼玉県",
    "千葉県",
    "東京都",
    "神奈川県",
    "新潟県",
    "富山県",
    "石川県",
    "福井県",
    "山梨県",
    "長野県",
    "岐阜県",
    "静岡県",
    "愛知県",
    "三重県",
    "滋賀県",
    "京都府",
    "大阪府",
    "兵庫県",
    "奈良県",
    "和歌山県",
    "鳥取県",
    "島根県",
    "岡山県",
    "広島県",
    "山口県",
    "徳島県",
    "香川県",
    "愛媛県",
    "高知県",
    "福岡県",
    "佐賀県",
    "長崎県",
    "熊本県",
    "大分県",
    "宮崎県",
    "鹿児島県",
    "沖縄県"
  ];

  Future<void> createThread() async{
    final postCollection = FirebaseFirestore.instance.collection('post');
    await postCollection.add({
      'maskRequirement': maskRequirement,
      'visitDate' : dateController.text,
      'username': usernameController.text,
      'prefecture' :selectedPrefecture,
      'facility': facilityController.text,
      'detail': detailController.text,
      'createdDate': Timestamp.now(),
    });
  }

  Future<void> InputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              width: 720,
              child: StatefulBuilder(
                builder:
                    (BuildContext context, StateSetter setState) =>
                    Container(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Icon(Icons.masks,color:Colors.blue),
                              SizedBox(width: 15,),
                              Text('マスク要否')
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 170,
                                child: RadioListTile(
                                  value: 1,
                                  groupValue: _groupValue,
                                  title: Text('マスク要'),
                                  onChanged: (int? value) {
                                    setState(() {
                                      maskRequirement = 'マスク要';
                                      _groupValue = value!;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 170,
                                child: RadioListTile(
                                  value: 2,
                                  groupValue: _groupValue,
                                  title: Text('マスク不要'),
                                  onChanged: (int? value) {
                                    setState(() {
                                      maskRequirement = 'マスク不要';
                                      _groupValue = value!;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 170,
                                child: RadioListTile(
                                  value: 3,
                                  groupValue: _groupValue,
                                  title: Text('不明'),
                                  onChanged: (int? value) {
                                    setState(() {
                                      maskRequirement = 'マスク要否　不明';
                                      _groupValue = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Container(
                                width: 315,
                                child: TextFormField(
                                  onTap: () async{
                                    DateTime initDate = DateTime.now();
                                    try {
                                      initDate =
                                          DateFormat('yyyy/MM/dd').parse(dateController.text);
                                    } catch (_) {}
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: initDate,
                                      firstDate: DateTime(2016),
                                      lastDate: DateTime.now().add(
                                        Duration(days: 360),
                                      ),
                                    );
                                    String? formatedDate;
                                    try {
                                      formatedDate =
                                          DateFormat('yyyy/MM/dd').format(picked!);
                                    } catch (_) {}
                                    if (formatedDate != null) {
                                      dateController.text = formatedDate;
                                    }                                  },
                                  readOnly: true,
                                  controller: dateController,
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
                                    hintText: '訪問日',
                                    suffixIcon: Icon(
                                      Icons.calendar_today,
                                    ),
                                    // labelText: 'Password',
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                width: 315,
                                child: TextFormField(
                                  maxLines: 1,
                                  minLines: 1,
                                  controller: usernameController,
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
                                    hintText: 'ニックネーム',
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text('都道府県'),
                              SizedBox(width: 20,),
                              DropdownButton(
                                  value: selectedPrefecture,
                                  items: japan
                                      .map((String list) => DropdownMenuItem(
                                      value: list, child: Text(list)))
                                      .toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedPrefecture = value!;
                                    });
                                  }),
                              SizedBox(width: 20,),
                              Expanded(
                                child: TextFormField(
                                  maxLines: 1,
                                  minLines: 1,
                                  controller: facilityController,
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
                                    hintText: '施設名',
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            maxLines: null,
                            minLines: 7,
                            controller: detailController,
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
                              hintText: '口コミ感想',
                              alignLabelWithHint: true,
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  child: Text('投稿する'),
                  onPressed: () async{
                    if(maskRequirement.isNotEmpty &&
                        facilityController.text.isNotEmpty &&
                        detailController.text.isNotEmpty &&
                        usernameController.text.isNotEmpty &&
                        selectedPrefecture!.isNotEmpty){
                      await createThread();
                      Navigator.pop(context);
                      usernameController.clear();
                      dateController.clear();
                      selectedPrefecture = '';
                      facilityController.clear();
                      detailController.clear();
                      _groupValue = 0;
                    }
                  },
                ),
              ),
            ],
          );
        }).then((value) => setState(() {}));
  }

  Future<void> InputDialogMobile(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            content: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: StatefulBuilder(
                    builder:
                        (BuildContext context, StateSetter setState) =>
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                Divider(
                                  height: 3,
                                  thickness: 1,
                                  color: Color.fromRGBO(243,243,243,1),
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Icon(Icons.masks,color:Colors.blue),
                                    SizedBox(width: 15,),
                                    Text('マスク要否')
                                  ],
                                ),
                                Container(
                                  width: 170,
                                  child: RadioListTile(
                                    value: 1,
                                    groupValue: _groupValue,
                                    title: Text('マスク要'),
                                    onChanged: (int? value) {
                                      setState(() {
                                        maskRequirement = 'マスク要';
                                        _groupValue = value!;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: 170,
                                  child: RadioListTile(
                                    value: 2,
                                    groupValue: _groupValue,
                                    title: Text('マスク不要'),
                                    onChanged: (int? value) {
                                      setState(() {
                                        maskRequirement = 'マスク不要';
                                        _groupValue = value!;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: 170,
                                  child: RadioListTile(
                                    value: 3,
                                    groupValue: _groupValue,
                                    title: Text('不明'),
                                    onChanged: (int? value) {
                                      setState(() {
                                        maskRequirement = 'マスク要否　不明';
                                        _groupValue = value!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  onTap: () async{
                                    DateTime initDate = DateTime.now();
                                    try {
                                      initDate =
                                          DateFormat('yyyy/MM/dd').parse(dateController.text);
                                    } catch (_) {}
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: initDate,
                                      firstDate: DateTime(2016),
                                      lastDate: DateTime.now().add(
                                        Duration(days: 360),
                                      ),
                                    );
                                    String? formatedDate;
                                    try {
                                      formatedDate =
                                          DateFormat('yyyy/MM/dd').format(picked!);
                                    } catch (_) {}
                                    if (formatedDate != null) {
                                      dateController.text = formatedDate;
                                    }                                  },
                                  readOnly: true,
                                  controller: dateController,
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
                                    hintText: '訪問日',
                                    suffixIcon: Icon(
                                        Icons.calendar_today,
                                    ),
                                    // labelText: 'Password',
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  maxLines: 1,
                                  minLines: 1,
                                  controller: usernameController,
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
                                    hintText: 'ニックネーム',
                                    alignLabelWithHint: true,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: DropdownButton(
                                      hint: Text("都道府県"),
                                      value: selectedPrefecture,
                                      items: japan
                                          .map((String list) => DropdownMenuItem(
                                          value: list, child: Text(list)))
                                          .toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedPrefecture = value!;
                                        });
                                      }),
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  minLines: 1,
                                  controller: facilityController,
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
                                    hintText: '施設名',
                                    alignLabelWithHint: true,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  maxLines: null,
                                  minLines: 7,
                                  controller: detailController,
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
                                    hintText: '口コミ感想',
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  child: Text('投稿する'),
                  onPressed: () async{
                    if(maskRequirement.isNotEmpty &&
                        facilityController.text.isNotEmpty &&
                        detailController.text.isNotEmpty &&
                        usernameController.text.isNotEmpty &&
                        selectedPrefecture!.isNotEmpty){
                      await createThread();
                      Navigator.pop(context);
                      usernameController.clear();
                      dateController.clear();
                      selectedPrefecture = '';
                      facilityController.clear();
                      detailController.clear();
                      _groupValue = 0;
                    }
                  },
                ),
              ),
            ],
          );
        }).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) {
      // Check the sizing information here and return your UI
      if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                      height: 738.9,
                      decoration:
                      BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://user-images.githubusercontent.com/67884859/213607142-41b26b19-17bf-4ea4-b202-668e9ecf8bec.jpeg'
                            ),
                            fit: BoxFit.cover,
                          ))),
                  Container(
                    height: 2600,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Color.fromRGBO(21,51,189, 0.8),
                          height: 738.9,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 250,
                              ),
                              Center(child: Column(
                                children: [
                                  Text(
                                    'マスク',
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color:  Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'トリタイ',
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color:  Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              Container(
                                width: 500,
                                color:  Colors.white,
                                child: TextField(
                                  decoration: InputDecoration(
                                    suffixIcon: Container(
                                      width: 120,
                                      height: 60,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromRGBO(239,13,12,1),
                                        ),
                                        child: Text(
                                          "検索",
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
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
                                    hintText: '施設名',
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Container(
                            width: 1130,
                            height: 23.09,
                            child: Row(
                              children: [
                                Text('2023.01.10',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),),
                                SizedBox(width: 15,),
                                Text('おでかけを振り返ろう',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(0,81,224, 1),
                                  ),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            width: 1100,
                            height: 51,
                            child: Row(
                              children: [
                                Text('新着',
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                SizedBox(width: 20,),
                                Text('マスク情報を記録して気持ちよく生活しよう',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                Expanded(child: SizedBox()),
                                Container(
                                  width: 120,
                                  height: 30,
                                  child: ElevatedButton.icon(
                                    label: Text('投稿する'),
                                    icon: Icon(Icons.create),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromRGBO(51,51,51,1),
                                    ),
                                    onPressed: () {
                                      InputDialog(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 783.65,
                              width: 348,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  Text('使い方',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(0, 81, 224, 1)
                                    ),),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: EdgeInsets.only(right: 30, left: 30,),
                                    child: Text('あのお店、マスクはいるの？いらないの？事前に知ることができるサイトです。'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 28,),
                            Column(
                              children: [
                                Container(
                                  child: StreamBuilder<QuerySnapshot>(
                                      stream: postCollection.orderBy('createdDate', descending: true).snapshots(),
                                      builder: (context, snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        }
                                        if(!snapshot.hasData) {
                                          return Center(child: Text('データがありません'));
                                        }
                                        final docs = snapshot.data!.docs;
                                        return Container(
                                          width: 724,
                                          height: 900,
                                          child: ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              itemExtent: 300,
                                              // physics: NeverScrollableScrollPhysics(),
                                              itemCount: 3,
                                              itemBuilder: (context, index) {
                                                Map<String, dynamic> data = docs[index].data() as Map<String, dynamic>;
                                                final Post fetchPost = Post(
                                                  id: docs[index].id,
                                                  maskRequirement: data['maskRequirement'],
                                                  visitDate: data['visitDate'],
                                                  username: data['username'],
                                                  prefecture: data['prefecture'],
                                                  facility: data['facility'],
                                                  detail: data['detail'],
                                                  createdDate: data['createdDate'],
                                                  updatedDate: data['updatedDate'],
                                                );
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(color: Color.fromRGBO(243,243,243,1),),
                                                    ),
                                                  ),
                                                  child: ListTile(
                                                    tileColor: Colors.white,
                                                    title: Container(
                                                      alignment: Alignment.centerLeft,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          SizedBox(height: 14.3,),
                                                          Container(
                                                              child: Text(fetchPost.username,
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w700,
                                                                ),)
                                                          ),
                                                          Container(
                                                              child: Text(fetchPost.visitDate,
                                                                style: TextStyle(
                                                                    fontSize: 12,
                                                                    color: Color.fromRGBO(136, 136, 136, 1)
                                                                ),)
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child: Text(fetchPost.facility,
                                                                  style: TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w700,
                                                                      color: Color.fromRGBO(0, 81, 224, 1)
                                                                  ),),
                                                              ),
                                                              SizedBox(width: 5,),
                                                              Container(
                                                                child: Text('[${fetchPost.prefecture}]',
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Color.fromRGBO(136, 136, 136, 1)
                                                                  ),),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Container(
                                                            child: Text(fetchPost.maskRequirement,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ),),
                                                          ),
                                                          SizedBox(height: 20,),
                                                          Container(
                                                            child: Text(fetchPost.detail,
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
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) => PostContentPage(fetchPost)));
                                                    },
                                                  ),
                                                );
                                              }),
                                        );
                                      }
                                  ),
                                ),
                                Container(
                                  width: 724,height: 134.4,color: Colors.white,
                                  child: Center(
                                    child: Container(
                                      width: 188,
                                      height: 54.4,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromRGBO(0, 82, 224, 1), //ボタンの背景色
                                        ),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => PostsPage(title: '',)));
                                        },
                                        child: Text(
                                          "もっと見る",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 85,),
                        Center(
                          child: Container(
                            width: 1100,
                            height: 51,
                            child: Row(
                              children: [
                                Text('お知らせ',
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                SizedBox(width: 20,),
                                Text('マスクトリタイからのお知らせ。Twitterでも情報発信中。',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(width: 1100,height: 370,color: Colors.white,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                      height: 738.9,
                      decoration:
                      BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://user-images.githubusercontent.com/67884859/213607142-41b26b19-17bf-4ea4-b202-668e9ecf8bec.jpeg'
                            ),
                            fit: BoxFit.cover,
                          ))),
                  Container(
                    height: 2500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: Color.fromRGBO(21,51,189, 0.9),
                          height: 738.9,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 250,
                              ),
                              Center(child: Column(
                                children: [
                                  Text(
                                    'マスク',
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color:  Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'トリタイ',
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color:  Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              Container(
                                width: 500,
                                color:  Colors.white,
                                child: TextField(
                                  decoration: InputDecoration(
                                    suffixIcon: Container(
                                      width: 120,
                                      height: 60,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromRGBO(239,13,12,1),
                                        ),
                                        child: Text(
                                          "検索",
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
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
                                    hintText: '施設名',
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Container(
                            width: 1130,
                            height: 23.09,
                            child: Row(
                              children: [
                                Text('2023.01.10',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),),
                                SizedBox(width: 15,),
                                Text('おでかけを振り返ろう',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(0,81,224, 1),
                                  ),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            width: 1100,
                            height: 51,
                            child: Row(
                              children: [
                                Text('新着',
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                SizedBox(width: 20,),
                                Text('マスク情報を記録して気持ちよく生活しよう',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                Expanded(child: SizedBox()),
                                Container(
                                  width: 120,
                                  height: 30,
                                  child: ElevatedButton.icon(
                                    label: Text('投稿する'),
                                    icon: Icon(Icons.create),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromRGBO(51,51,51,1),
                                    ),
                                    onPressed: () {
                                      InputDialog(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 783.65,
                              width: 348,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  Text('使い方',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(0, 81, 224, 1)
                                    ),),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: EdgeInsets.only(right: 30, left: 30,),
                                    child: Text('あのお店、マスクはいるの？いらないの？事前に知ることができるサイトです。'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 28,),
                            Container(
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: postCollection.orderBy('createdDate', descending: true).snapshots(),
                                  builder: (context, snapshot) {
                                    if(snapshot.connectionState == ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    if(!snapshot.hasData) {
                                      return Center(child: Text('データがありません'));
                                    }
                                    final docs = snapshot.data!.docs;
                                    return Container(
                                      width: 724,
                                      height: 900,
                                      child: ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          itemExtent: 300,
                                          // physics: NeverScrollableScrollPhysics(),
                                          itemCount: 3,
                                          itemBuilder: (context, index) {
                                            Map<String, dynamic> data = docs[index].data() as Map<String, dynamic>;
                                            final Post fetchPost = Post(
                                              id: docs[index].id,
                                              maskRequirement: data['maskRequirement'],
                                              visitDate: data['visitDate'],
                                              username: data['username'],
                                              prefecture: data['prefecture'],
                                              facility: data['facility'],
                                              detail: data['detail'],
                                              createdDate: data['createdDate'],
                                              updatedDate: data['updatedDate'],
                                            );
                                            return Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(color: Color.fromRGBO(243,243,243,1),),
                                                ),
                                              ),
                                              child: ListTile(
                                                tileColor: Colors.white,
                                                title: Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 14.3,),
                                                      Container(
                                                          child: Text(fetchPost.username,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w700,
                                                            ),)
                                                      ),
                                                      Container(
                                                          child: Text(fetchPost.visitDate,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Color.fromRGBO(136, 136, 136, 1)
                                                            ),)
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            child: Text(fetchPost.facility,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: Color.fromRGBO(0, 81, 224, 1)
                                                              ),),
                                                          ),
                                                          SizedBox(width: 5,),
                                                          Container(
                                                            child: Text('[${fetchPost.prefecture}]',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color.fromRGBO(136, 136, 136, 1)
                                                              ),),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Container(
                                                        child: Text(fetchPost.maskRequirement,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),),
                                                      ),
                                                      SizedBox(height: 20,),
                                                      Container(
                                                        child: Text(fetchPost.detail,
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
                                                onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) => PostContentPage(fetchPost)));
                                                },
                                              ),
                                            );
                                          }),
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 85,),
                        Center(
                          child: Container(
                            width: 1100,
                            height: 51,
                            child: Row(
                              children: [
                                Text('お知らせ',
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                SizedBox(width: 20,),
                                Text('マスクトリタイからのお知らせ。Twitterでも情報発信中。',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(width: 1100,height: 370,color: Colors.white,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
        return Container(color:Colors.blue);
      }

      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                    height: 580,
                    decoration:
                    BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://user-images.githubusercontent.com/67884859/213607142-41b26b19-17bf-4ea4-b202-668e9ecf8bec.jpeg'
                          ),
                          fit: BoxFit.cover,
                        ))),
                Container(
                  height: 2350,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Color.fromRGBO(21,51,189, 0.9),
                        height: 580,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                            ),
                            Center(child: Column(
                              children: [
                                Text(
                                  'マスク',
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color:  Colors.white,
                                  ),
                                ),
                                Text(
                                  'トリタイ',
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color:  Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            ),
                            SizedBox(
                              height: 68,
                            ),
                            Container(
                              width: 360,
                              color:  Colors.white,
                              child: TextField(
                                decoration: InputDecoration(
                                  suffixIcon: Container(
                                    width: 100,
                                    height: 65,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromRGBO(239,13,12,1),
                                      ),
                                      child: Text(
                                        "検索",
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
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
                                  hintText: '施設名',
                                  alignLabelWithHint: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: Container(
                          width: 400,
                          height: 23.09,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text('2023.01.10',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),),
                                SizedBox(width: 15,),
                                Text('おでかけを振り返ろう',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(0,81,224, 1),
                                  ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      Center(
                        child: Container(
                          width: 400,
                          height: 51,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: Row(
                              children: [
                                Text('新着',
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                SizedBox(width: 20,),
                                Expanded(child: SizedBox()),
                                Container(
                                  width: 120,
                                  height: 30,
                                  child: ElevatedButton.icon(
                                    label: Text('投稿する'),
                                    icon: Icon(Icons.create),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromRGBO(51,51,51,1),
                                    ),
                                    onPressed: () {
                                      InputDialogMobile(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: postCollection.orderBy('createdDate', descending: true).snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if(!snapshot.hasData) {
                                return Center(child: Text('データがありません'));
                              }
                              final docs = snapshot.data!.docs;
                              return Container(
                                width: 400,
                                height: 900,
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemExtent: 300,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> data = docs[index].data() as Map<String, dynamic>;
                                      final Post fetchPost = Post(
                                        id: docs[index].id,
                                        maskRequirement: data['maskRequirement'],
                                        visitDate: data['visitDate'],
                                        username: data['username'],
                                        prefecture: data['prefecture'],
                                        facility: data['facility'],
                                        detail: data['detail'],
                                        createdDate: data['createdDate'],
                                        updatedDate: data['updatedDate'],
                                      );
                                      return Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(color: Color.fromRGBO(243,243,243,1),),
                                          ),
                                        ),
                                        child: ListTile(
                                          tileColor: Colors.white,
                                          title: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 14.3,),
                                                Container(
                                                    child: Text(fetchPost.username,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700,
                                                      ),)
                                                ),
                                                Container(
                                                    child: Text(fetchPost.visitDate,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Color.fromRGBO(136, 136, 136, 1)
                                                      ),)
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: Text(fetchPost.facility,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w700,
                                                            color: Color.fromRGBO(0, 81, 224, 1)
                                                        ),),
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Container(
                                                      child: Text('[${fetchPost.prefecture}]',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Color.fromRGBO(136, 136, 136, 1)
                                                        ),),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Container(
                                                  child: Text(fetchPost.maskRequirement,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),),
                                                ),
                                                SizedBox(height: 20,),
                                                Container(
                                                  child: Text(fetchPost.detail,
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
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => PostContentPage(fetchPost)));
                                          },
                                        ),
                                      );
                                    }),
                              );
                            }
                        ),
                      ),
                      SizedBox(height: 20,),
                      Center(
                        child: Container(
                          width: 360,
                          height: 51.09,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(0, 82, 224, 1), //ボタンの背景色
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => PostsPage(title: '',)));
                            },
                            child: Text(
                              "もっと見る",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 85,),
                      Center(
                        child: Container(
                          width: 400,
                          height: 51,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: Row(
                              children: [
                                Text('お知らせ',
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                SizedBox(width: 20,),
                                Text('Twitterでも情報発信中。',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(width: 1100,height: 370,color: Colors.white,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  }
}

