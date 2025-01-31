import 'package:flipkart/data/cart_data/product_model.dart';
import 'package:flipkart/ui/constants/app_colors.dart';
import 'package:flipkart/ui/screens/cart/bloc/cart_bloc.dart';
import 'package:flipkart/ui/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:flipkart/ui/screens/dashboard/dashboard_view.dart';
import 'package:flipkart/ui/screens/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    Product product = context
        .read<ProductBloc>()
        .product;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.blue.withOpacity(0.2),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: (){
                  context.read<ProductBloc>().add(GoToCartEvent());
                },
                icon: const Icon(Icons.shopping_cart_outlined)),
          )
        ],
      ),
      body: ListView(
        children: [
          _carouselSlider(context
              .read<ProductBloc>()
              .product),
          const SizedBox(height: 20,),
          Divider(
            height: 10, color: Colors.grey.shade300,
            thickness: 10,
          ),
          const SizedBox(height: 20,),
          _productDetail(product),
          const SizedBox(height: 100,),

        ],
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        children: [
          Expanded(
              child:
              BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) async {
                  debugPrint("Listener $state");

                  if(state is AddedToCartState){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added to Cart")));
                  }else if(state is GoToCartActionState){
                    context.read<DashboardBloc>().currentIndex=4;
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const DashboardView()));
                    context.read<ProductBloc>().add(ProductCheckIfAddedToCartEvent(product));
                  } else if(state is ProductLoadedState){
                    context.read<ProductBloc>().add(ProductCheckIfAddedToCartEvent(product));
                  }
                } ,
                listenWhen: (previous, current) {
                  debugPrint("ListenWhen $previous $current");
                  return
                    current is ProductActionState||
                    current is ProductLoadedState;
                }

                ,
                buildWhen: (previous, current)=>current is !ProductActionState,
                builder: (context, state){
                  return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        debugPrint("State $state");
                        if(state is ProductAddedToCartState){
                          context.read<ProductBloc>().add(GoToCartEvent());
                        }else {
                          context.read<ProductBloc>().add(AddProductToCartEvent(product));
                        }
                      }, child: Text(
                      state is ProductAddedToCartState?"Go to cart":
                      "Add to cart",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)
                  ));
                },
              ),),
          Expanded(
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: const RoundedRectangleBorder(),
                  ),
                  onPressed: () {},
                  child: const Text(
                      "Buy now",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)
                  ))),
        ],
      ),
    );
  }

  Widget _carouselSlider(Product product) {
    return FlutterCarousel(
      options: FlutterCarouselOptions(
          height: 500,
          viewportFraction: 1,
          autoPlay: true,
          showIndicator: true,
          slideIndicator: CircularSlideIndicator(
              slideIndicatorOptions: SlideIndicatorOptions(
                  currentIndicatorColor: Colors.black,
                  indicatorBackgroundColor: Colors.grey.shade300)),
          floatingIndicator: true,
          indicatorMargin: 0),
      items: (product.imagesUrl!).map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              // color: Colors.red,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                margin: const EdgeInsets.only(bottom: 20, top: 5),
                alignment: Alignment.bottomCenter,
                child: Image.network(
                  i,
                  fit: BoxFit.contain,
                  errorBuilder: (context, a, b) {
                    return const Center(child: Icon(Icons
                        .image_not_supported_outlined));
                  },
                ));
          },
        );
      }).toList(),
    );
  }

  Widget _productDetail(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "View more from ${product.brand}",
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: AppColors.blue),
          ),
          const SizedBox(height: 10,),
          RichText(text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(text: product.description ?? "",),
              ])),
          const SizedBox(height: 10,),
          Row(
            children: [
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: product.rating!,
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
              Text("${product.rating ?? ""}",
                style: TextStyle(color: Colors.green.shade700,),),

            ],
          ),
          const SizedBox(height: 20,),
          RichText(text: TextSpan(
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
              children: [
                const WidgetSpan(
                    child: Icon(Icons.arrow_downward, color: Colors.green,)),
                TextSpan(text:
                "${(((product.originalPrice! -
                    product.discountedPrice!) /
                    product.originalPrice!) * 100).toInt()}%"
                    , style: const TextStyle(color: Colors.green)),
                const WidgetSpan(child: SizedBox(width: 5,)),
                TextSpan(text: "₹${product.originalPrice}",
                    style: const TextStyle(color: Colors.grey,
                        decoration: TextDecoration.lineThrough)),
                const WidgetSpan(child: SizedBox(width: 10,)),
                TextSpan(text: "₹${product.discountedPrice}"),
              ]))
        ],
      ),
    );
  }
}
