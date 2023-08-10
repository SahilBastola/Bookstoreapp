import 'package:ebuy/model/order.dart';
import 'package:ebuy/repository/order_repo.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool _isVerified = false;
  Future<String> adduserid(String Productid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('_id', Productid);
    return "";
    // await pref.setString('login', token);
  }

  _DeleteOrder() async {
    setState(() async {
      int islogin = await OrderRepositoryImpl().deleteorder();
      if (islogin == 1) {
        MotionToast.success(description: const Text("Success"), onClose: () {})
            .show(context);
      } else {
        MotionToast.success(description: const Text("Success"), onClose: () {})
            .show(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Page'),
          backgroundColor: Color.fromARGB(255, 7, 64, 164),
        ),
        body: FutureBuilder<List<Orders>>(
          future: OrderRepositoryImpl().getOrderByUserid(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Hero(
                                      tag: 123,
                                      child: Image.network(
                                        snapshot.data?[index].Products?.img ??
                                            "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(snapshot
                                              .data?[index].Products!.title ??
                                          ""),
                                      Text(snapshot
                                              .data?[index].Products!.Author ??
                                          ""),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await adduserid(
                                          "${snapshot.data![index].orderid}");
                                      setState(() {
                                        _DeleteOrder();
                                      });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text('UserName:  '),
                                  Text(snapshot.data?[index].userr!.name ?? ""),
                                  const Spacer(),
                                  const Text('Quantity'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('Price:  '),
                                  Text(
                                      "Rs ${snapshot.data?[index].Products?.price}  "),
                                  Icon(
                                    _isVerified ? Icons.check : Icons.close,
                                    color:
                                        _isVerified ? Colors.green : Colors.red,
                                  ),
                                ],
                              ),
                              Center(
                                child: ElevatedButton(
                                  child: const Text(
                                    'Verify Order',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showDialog(context);
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  // Add dialog box to verify order
  _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Verify your order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Please enter your location'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Location',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Please enter your Email'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Please enter your Phone number'),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Phone',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text('Verify'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isVerified = true;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
