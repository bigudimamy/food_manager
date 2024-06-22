import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RefrigeratorMenuTile extends StatefulWidget {
  const RefrigeratorMenuTile({
    super.key,
    required this.dishID,
  });

  final String dishID;

  @override
  State<RefrigeratorMenuTile> createState() => _RefrigeratorMenuTileState();
}

class _RefrigeratorMenuTileState extends State<RefrigeratorMenuTile> {

  Map<String, dynamic>? dishData;

  @override
   void initState() {
     super.initState();
     _fetchDishData();
   }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchDishData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('dishes')
        .doc(widget.dishID)
        .get();
    if (snapshot.exists && mounted) {
      setState(() {
        dishData = snapshot.data() as Map<String, dynamic>;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/dish',
          arguments: widget.dishID,
        );
      },
    
      title: Card(
        margin: const EdgeInsets.only(top: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              dishData?['image'] ?? '',
              height: MediaQuery.of(context).size.height * 0.33, 
              width: MediaQuery.of(context).size.width * 0.9,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error); 
              },
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.005),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dishData?['dish_name'] ?? '',
                    style: Theme.of(context).textTheme.bodyLarge
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                  const Divider(
                    thickness: 3, // Толщина линии
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${dishData?['fats']}/${dishData?['proteins']}/${dishData?['carbs']}',
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                          Text(
                            'Ж/Б/У',
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                        ],
                      ),

                      SizedBox(width: MediaQuery.of(context).size.width * 0.1),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${dishData?['calories']}',
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                          Text(
                            'Ккал',
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                        ],
                      ),

                      SizedBox(width: MediaQuery.of(context).size.width * 0.1),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '4 Порции',
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                          Text(
                            'Количество',
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height:  MediaQuery.of(context).size.height * 0.015),
          ],
        ),
      ),
    );
  }
}