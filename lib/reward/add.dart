import 'package:flutter/material.dart';

class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  List<bool> isCardEnabled = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10
          ),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index){
            isCardEnabled.add(false);
            return GestureDetector(
                onTap: (){
                  isCardEnabled.replaceRange(0, isCardEnabled.length, [for(int i = 0; i < isCardEnabled.length; i++)false]);
                  isCardEnabled[index]=true;
                  setState(() {});
                },
                child: SizedBox(
                  height: 20,
                  width: 30,
                  child: Card(
                    color: isCardEnabled[index]?Colors.cyan:Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: Text('20',
                        style: TextStyle(
                            color: isCardEnabled[index]?Colors.white:Colors.grey,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                )
            );
          }),
    );
  }

  }
