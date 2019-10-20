import 'package:cipher2/cipher2.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

String _recieved_message = ' ';
String _sender_no = ' ';

void main(){
  runApp(MyApp());

  SmsReceiver receiver = new SmsReceiver();
  receiver.onSmsReceived.listen((SmsMessage msg) {
    _recieved_message = msg.body;
    _sender_no = msg.address;
    } 
  );
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encrypted SMS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Encrypted SMS System'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

 
  final String title;

  @override
  //_MyHomePageState createState() => _MyHomePageState();
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}
enum FormType{inbox,send}
class _MyHomePageState extends State<MyHomePage> {
  
  FormType _formType = FormType.send;
  
  String _recipient_no;
  String _message = ' ';
  String _messageR = '';
  String _decrypted_message = ' ';
  String _decrypted_messageR = '';
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  

  void dispose() {
    //Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  void send(){
    setState(() {
      _formType = FormType.send;
    });
  }

  void inbox(){
    setState(() {
      _formType = FormType.inbox;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_formType == FormType.send){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      ListView(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(onPressed:  (){
                  
                    },
                  child: Text("Send"),
                ),
                ),
                Expanded(
                  child: RaisedButton(onPressed: () {
                    inbox();
                  },
                  child: Text("Inbox"),  
                ),
                )
                
              ],
            ),
          ),
          SizedBox(height: 15.0,),
          TextFormField(
            controller: myController3,
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.email),
                        hintText: 'Enter Recipient\'s number',
                        labelText: 'Number',
                        hasFloatingPlaceholder: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        border: UnderlineInputBorder(),
                      ),
                      cursorColor: Colors.white,
                      onSaved: (value) => _recipient_no = value,
                      validator: (value) => value.length != 10 ? "Enter a valid number" : null,
                    ),
                    SizedBox(height: 15.0,),
          TextFormField(
                      controller: myController,
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.email),
                        //contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                        hintText: 'Enter message',
                        labelText: 'Message',
                        hasFloatingPlaceholder: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        border: UnderlineInputBorder(),
                      ),
                      cursorColor: Colors.white,
                      onSaved: (value) => _recipient_no = value,
                      validator: (value) => value.length != 10 ? "Enter a valid number" : null,
                    ),
                    SizedBox(height: 15.0,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                        obscureText: true,
                        controller: myController2,
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.email),
                        hintText: 'Enter Encryption Key',
                        labelText: 'Key (16 characters)',
                        hasFloatingPlaceholder: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        border: UnderlineInputBorder(),
                      ),
                      cursorColor: Colors.white,
                      onSaved: (value) => _recipient_no = value,
                      validator: (value) => value.length != 16 ? "Enter a key with 16 characters." : null,
                    ),
                        ),
                      Expanded(
                        child: Container(
                          padding : EdgeInsets.all(5.0),
                          child: RaisedButton(
                          onPressed: () async {
                            String plainText = myController.text;
                            String key = myController2.text;                         
                            //String iv = 'xxxxxxxxxxxxxxxx';
                            //String nonce = await Cipher2.generateNonce();
                            String nonce = '+QVNyK7dTosxe8QU';
                            _message = await Cipher2.encryptAesCbc128Padding7(plainText, key, nonce);
                            setState(() {
                              _messageR = _message;
                            });
                            
                            print(_message);
                            //String decryptedString = await Cipher2.decryptAesCbc128Padding7(_message, key, nonce);
                            //print(decryptedString);
                            //print(nonce);
                            //print(key);
                          },
                          child: Text("Encrypt"),
                        )
                          )
                        
                      )
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Text(
                      'Encrypted Message:',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
                      child: Text(
                        _messageR,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(100, 50, 100, 100),
                      child: RaisedButton(
                        child: Text('Send'), onPressed: () {
                          _recipient_no = myController3.text;
                          SmsSender sender = new SmsSender();
                          sender.sendSms(new SmsMessage(_recipient_no, _message));
                        },
                      ),
                    )
                    
        ],
      ),  //  This trailing comma makes auto-formatting nicer for build methods.
    );
    
  }else{

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
      ListView(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(onPressed:  (){
                      send();
                    },
                  child: Text("Send"),
                ),
                ),
                Expanded(
                  child: RaisedButton(onPressed: () {
                    
                  },
                  child: Text("Inbox"),  
                ),
                )
                
              ],
            ),
          ),
          SizedBox(height: 15.0,),
          Text(
            'Sender: ' +_sender_no,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 15.0,),
          Container(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 20),
            child: Text(
              _recieved_message,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
                    SizedBox(height: 15.0,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                        obscureText: true,
                        controller: myController4,
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.email),
                        hintText: 'Enter Decryption Key',
                        labelText: 'Key (16 characters)',
                        hasFloatingPlaceholder: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.lightBlueAccent,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 4,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        border: UnderlineInputBorder(),
                      ),
                      cursorColor: Colors.white,
                      onSaved: (value) => _recipient_no = value,
                      validator: (value) => value.length != 16 ? "Enter a valid key" : null,
                    ),
                        ),
                      Expanded(
                        child: Container(
                          padding : EdgeInsets.all(5.0),
                          child: RaisedButton(
                          onPressed: () async {
                            String key = myController2.text;
                            //String nonce = await Cipher2.generateNonce();
                            String nonce = '+QVNyK7dTosxe8QU';
                            String enteredPassword = myController4.text; //The password user enters. Should be used for decryption.
                            _decrypted_message = await Cipher2.decryptAesCbc128Padding7(_recieved_message, enteredPassword, nonce);
                            setState(() {
                              _decrypted_messageR = _decrypted_message;
                            });
                            print(_decrypted_message);
                            print(nonce);
                            print(key);
                          },
                          child: Text("Decrypt"),
                        )
                          )
                        
                      )
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Text(
                      'Decrypted Message:',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
                      child: Text(
                        _decrypted_messageR,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
        ],
      ),  //  This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
}

