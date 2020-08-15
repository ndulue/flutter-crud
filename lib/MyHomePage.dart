import 'package:flutter/material.dart';
import 'package:fluttercrud/Service/api.dart';
import 'package:fluttercrud/data/post.dart';
import 'package:fluttercrud/form_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter CRUD"),
        actions: <Widget>[
          GestureDetector( 
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormScreen();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
            future: getPosts(),
            // ignore: missing_return
            builder: (context, snapshot){
              if(snapshot.hasError){
                return Center(
                  child: Text(snapshot.error.toString())
                );
              } else if(snapshot.connectionState == ConnectionState.done) {
                var response = snapshot.data as List<Post>;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: response.length,
                    itemBuilder: (context, position){
                      var postItem = response[position];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  postItem.name,
                                  style: Theme.of(context).textTheme.title,
                                ),
                                Text(
                                  postItem.email,
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                                Text(
                                  postItem.age.toString(),
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context){
                                             return FormScreen(
                                                id: postItem.id,
                                                name: postItem.name,
                                                email: postItem.email,
                                                age: postItem.age,
                                              );
                                            })
                                        );
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      onPressed: (){
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text("Delete Data"),
                                                content: Text(
                                                  "Are you sure want to delete ${postItem.name} ? "
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      onPressed: (){
                                                        deletePost(postItem.id).then((response) {

                                                        });
                                                      },
                                                      child: Text("Yes")
                                                  ),
                                                  FlatButton(
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("No")
                                                  ),
                                                ],
                                              );
                                            }
                                        );
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      onPressed: (){
                                        //TODO
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                );
              } else {
                return Center(
                  child: Text("success"),
                );
              }
            },
          ),
      )
    );
  }
}
