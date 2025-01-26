

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop/views/shared/export.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCart();

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close, color: Colors.black),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "My Cart",
                  style: appStyle(26, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      itemCount: cartProvider.cart.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final data = cartProvider.cart[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 1,
                                      onPressed: (context) {
                                        cartProvider.deleteCart(data['key']);
                                      },
                                      // onPressed: null,
                                      backgroundColor: const Color(0xFF000000),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade500,
                                        spreadRadius: 5,
                                        blurRadius: 0.3,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //---- Image and title row------------------------//

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: CachedNetworkImage(
                                                imageUrl: data['imageUrl'],
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),

                                          //--------title and category column------------------------//

                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data['name'],
                                                  style: appStyle(
                                                      20,
                                                      Colors.black,
                                                      FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  data['category'],
                                                  style: appStyle(
                                                      14,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),

                                                //--------- price row------------------------//
                                                PriceRow(data: data),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),

                                      //---- Add/Subtract buttons row------------------------//

                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16)),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      cartProvider.increment();
                                                      // print(data['qty']);
                                                    },
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 20,
                                                      color: Colors.grey,
                                                    ),
                                                  ), // Icon // InkWell

                                                  Text(
                                                    data['qty'].toString(),
                                                    style: appStyle(
                                                      16,
                                                      Colors.black,
                                                      FontWeight.w600,
                                                    ),
                                                  ), // Text

                                                  InkWell(
                                                      onTap: () {
                                                        cartProvider
                                                            .decrement();
                                                        // print(data['qty']);
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }),
                ),
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: CheckoutButtonWidget(label: "Proceed to Checkout")),
          ],
        ),
      ),
    );
  }
}

class PriceRow extends StatelessWidget {
  const PriceRow({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Rs.${data['price']}', 
          style: appStyle(16, Colors.black, FontWeight.w600),
        ),
        const SizedBox(
          width: 35,
        ),
       
        Text(
          "Size-",
          style: appStyle(18, Colors.black, FontWeight.w600),
        ),
        // const SizedBox(
          // width: 8,
        // ),
        Text(
          data['sizes'].toString(),
          style: appStyle(15, Colors.black, FontWeight.w600),
        ),
      ],
    );
  }
}
