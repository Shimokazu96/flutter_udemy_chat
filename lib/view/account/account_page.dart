import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/model/account.dart';
import 'package:my_app/model/post.dart';
import 'package:my_app/view/account/edit_account_page.dart';

import '../../utils/authentication.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Account myAccount = Authentication.myAccount!;

  List<Post> postList = [
    Post(
        id: '1',
        content: '初めまして',
        postAccountId:'1',
        createdTime: DateTime.now()
    ),
    Post(
        id: '2',
        content: '初めまして二回目',
        postAccountId:'2',
        createdTime: DateTime.now()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right:15, left:15, top:20),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                               radius: 32,
                               foregroundImage: NetworkImage(myAccount.imagePath),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(myAccount.name, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  Text('@${myAccount.userId}', style: TextStyle(color: Colors.grey),),
                                ]
                              )
                            ]
                          ),
                          OutlinedButton(
                              onPressed: () async {
                                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditAccountPage()));
                                if(result == true) {
                                  setState(() {
                                    myAccount = Authentication.myAccount!;
                                  });
                                }
                              },
                              child: Text('編集')
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(myAccount.selfIntroduction)
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      color: Colors.blue, width: 3
                    ))
                  ),
                  child: Text('投稿', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                ),
                Expanded(child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          border: index == 0 ? Border(
                            top: BorderSide(color: Colors.grey,width:0),
                            bottom: BorderSide(color: Colors.grey, width:0),
                          ) : Border(bottom: BorderSide(color: Colors.grey, width:0),)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            foregroundImage: NetworkImage(myAccount.imagePath),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(myAccount.name, style: TextStyle(fontWeight: FontWeight.bold),),
                                        Text('@${myAccount.userId}',style: TextStyle(color: Colors.grey),),
                                      ],
                                    ),
                                    Text(DateFormat('M/d/yy').format(postList[index].createdTime!)),
                                  ],
                                ),
                                Text(postList[index].content)
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
