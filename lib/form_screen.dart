import 'package:flutter/material.dart';
import 'package:fluttercrud/Service/api.dart';
import 'package:fluttercrud/data/post.dart';

var _scaffoldState = GlobalKey<ScaffoldState>();

class FormScreen extends StatefulWidget {
  int id;
  String name;
  String email;
  int age;
  bool _isApiProcess = false;

  FormScreen({this.id, this.name, this.email, this.age});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();

  @override
  void initState() {
    _controllerName.text = widget.name;
    _controllerName.text = widget.email;
    _controllerName.text = widget.age == null ? "0" : widget.age.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: SafeArea(
          child: Stack(
            children: <Widget>[
              (widget._isApiProcess)
                ? Stack(
                  children: <Widget> [
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(child: CircularProgressIndicator()),
                  ]
                ) : Container(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(hintText: "Name"),
                      keyboardType: TextInputType.text,
                      controller: _controllerName,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8)
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      controller: _controllerEmail,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8)
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Age"),
                      keyboardType: TextInputType.number,
                      controller: _controllerAge,
                    ),
                    widget.id == null
                        ? RaisedButton(child: Text("Submit"),
                        onPressed: (){
                          String name = _controllerName.text.toString().trim();
                          String email = _controllerEmail.toString().trim();
                          int age = _controllerAge.text.toString().isEmpty
                              ? 0
                              : int.parse(_controllerAge.text.toString());
                          if (name.isEmpty) {
                            showSnackbarMessage("Name is required");
                          } else if (email.isEmpty) {
                            showSnackbarMessage("Email is required");
                          } else if (age == 0) {
                            showSnackbarMessage("Age is required");
                          } else {
                            setState(() {
                              widget._isApiProcess = true;
                              Post post = Post(name: name, email: email, age: age);
                              createPost(post).then((response) {
                                if (response.statusCode == 201){
                                  Navigator.pop(context);
                                } else {
                                  showSnackbarMessage("Update changes failed");
                                }
                              });
                              widget._isApiProcess = true;
                            });
                          }
                        })
                        : RaisedButton(child: Text("Update Changes"),
                        onPressed: (){

                        })
                  ],
                ),
              ),
            ],
          )
      )
    );
  }

  void showSnackbarMessage(String message) {
    _scaffoldState.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
