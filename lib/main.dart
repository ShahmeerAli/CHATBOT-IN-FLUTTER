import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI CHATBOT',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      home: const MyHomePage(title: 'AI ChatBot'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    final _textController=TextEditingController();
    final List<Map<String,String>> messages=[];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SizedBox(width: double.infinity,height: 10,),
          Text("Chatbot",style:TextStyle(fontSize: 30,color: Colors.amber,fontWeight: FontWeight.w700)),
          Expanded(child:
          ListView.builder(itemCount: messages.length,
              itemBuilder: (context,index){
                final message=messages[index];
                final isUser=message['role']=='user';
                return Align(
                  alignment: isUser ? Alignment.centerRight :Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.greenAccent,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Text(message['text']!,style: TextStyle(color: isUser ? Colors.white : Colors.black),),
                  ),
                );
          })),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                      decoration: InputDecoration(
                        hintText: "What's on your mind?",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.lightGreen
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.blue
                          ),
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Image.asset("assets/images/fastforward.png",width: 40,height: 40,),
                )
              ],
            ),
          )
        ]
      )
    );
  }
}
