import 'package:flipkart/ui/screens/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CartView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(FetchCartItemsEvent());
    return Scaffold(
      appBar: AppBar(title: Text("My Cart", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return state is CartLoadedState || state is RemovedFromCartState|| state is AddedToCartState
          ? ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            separatorBuilder: (context, index) =>const Divider(height: 50, thickness: 5,),
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
              var item = state.cartItems[index];
                return

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                  height: 80,
                                  width: 80,
                                  color: Colors.grey.shade300,
                                  child: Image.network(item.imageUrl??"",
                                    errorBuilder: (context, a, b){
                                      return const Icon(Icons.image_not_supported_outlined);
                                    },
                                  ))),
                          const SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${item.name}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: item.rating!,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 15,
                                      unratedColor: Colors.grey.shade300,
                                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) =>
                                          Icon(
                                            Icons.star_rounded,
                                            color: Colors.green.shade700,
                                          ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    const SizedBox(width: 10,),
                                    Text("${item.rating ?? ""}",
                                      style: TextStyle(color: Colors.green.shade700,),),

                                  ],
                                ),
                                const SizedBox(height: 5,),
                                RichText(text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    ),
                                    children: [
                                      const WidgetSpan(
                                          child: Icon(Icons.arrow_downward, color: Colors.green,)),
                                      TextSpan(text:
                                      "${(((item.originalPrice! -
                                          item.discountedPrice!) /
                                          (item.originalPrice!)) * 100).toInt()}%"
                                          , style: const TextStyle(color: Colors.green)),
                                      const WidgetSpan(child: SizedBox(width: 5,)),
                                      TextSpan(text: "₹${item.originalPrice}",
                                          style: const TextStyle(color: Colors.grey,
                                              decoration: TextDecoration.lineThrough)),
                                      const WidgetSpan(child: SizedBox(width: 10,)),
                                      TextSpan(text: "₹${item.discountedPrice}"),
                                    ]))
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 10,),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.grey, width: 2)),
                  ),
                          onPressed: (){
                        context.read<CartBloc>().add(RemoveFromCartItemsEvent(item));
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Remove", style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600, fontSize: 16),),
                          SizedBox(width: 20,),
                          Icon(Icons.delete_outline, color: Colors.grey.shade700, size: 20,),
                        ],
                      ))
                    ],
                  ),
                );
              })
          :const Center(child: Text("Not loaded"))
          ;
        },
      ),
    );
  }


}
