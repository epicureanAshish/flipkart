import 'package:flipkart/data/cart_data/product_model.dart';
import 'package:flipkart/data/offline_data/offline_data_provider.dart';
import 'package:flipkart/ui/constants/app_assets.dart';
import 'package:flipkart/ui/constants/app_colors.dart';
import 'package:flipkart/ui/screens/home/bloc/home_bloc.dart';
import 'package:flipkart/ui/screens/home/bloc/home_bloc.dart';
import 'package:flipkart/ui/screens/product/bloc/product_bloc.dart';
import 'package:flipkart/ui/screens/product/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var data = context.read<OfflineDataProvider>().productsData;
    debugPrint("View data $data");

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.blue.withOpacity(0.7),
      ),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              _headerWidgets(),
              const SizedBox(
                height: 10,
              ),
              _carouselSlider(context),
              const SizedBox(
                height: 15,
              ),
              _categories(context),
              const SizedBox(
                height: 5,
              ),
              _suggestedItems(context, data),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerWidgets() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          AppColors.blue.withOpacity(0.7),
          Colors.white,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: Image.asset(
                AppAssets.appLogo,
                height: 50,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Image.asset(
                AppAssets.appLogo,
                height: 50,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Image.asset(
                AppAssets.appLogo,
                height: 50,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Image.asset(
                AppAssets.appLogo,
                height: 50,
              )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          RichText(
              text: TextSpan(children: [
            const WidgetSpan(
                child: Padding(
              padding: EdgeInsets.only(right: 2.0),
              child: Icon(Icons.location_on_rounded,
                  size: 15, color: Colors.black),
            )),
            const TextSpan(
                text: "160059",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500)),
            const WidgetSpan(
                child: SizedBox(
              width: 5,
            )),
            const TextSpan(
                text: "Select delivery location",
                style: TextStyle(
                    color: AppColors.blue, fontWeight: FontWeight.w500)),
            const WidgetSpan(
                child: SizedBox(
              width: 2,
            )),
            WidgetSpan(
                child: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.grey.shade700,
            )),
          ])),
          const SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Brand Mall",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  Switch(value: false, onChanged: (_) {})
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.search,
                      size: 30,
                      color: AppColors.blue,
                    ),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(maxHeight: 30, maxWidth: 30),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.blue.withOpacity(0.7), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.blue.withOpacity(0.7), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.blue.withOpacity(0.7), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget _carouselSlider(context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_context, state) {
        return FlutterCarousel(
          options: FlutterCarouselOptions(
              height: 300.0,
              viewportFraction: 1,
              autoPlay: true,
              showIndicator: true,
              slideIndicator: CircularSlideIndicator(
                  slideIndicatorOptions: SlideIndicatorOptions(
                      currentIndicatorColor: Colors.black,
                      indicatorBackgroundColor: Colors.grey.shade300)),
              floatingIndicator: true,
              indicatorMargin: 0),
          items: _context.read<HomeBloc>().bannersList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        i,
                        fit: BoxFit.cover,
                      ),
                    ));
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _categories(context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (_context, state) {
          return GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _context.read<HomeBloc>().categoriesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.4),
              itemBuilder: (context, index) {
                var category = _context.read<HomeBloc>().categoriesList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      category["image_url"],
                      height: 50,
                    ),
                    Text(
                      category["name"] ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    )
                  ],
                );
              });
        },
      ),
    );
  }

  Widget _suggestedItems(context, data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recommended Items",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Similar to items you viewed",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        fixedSize: const Size(40, 30),
                        minimumSize: const Size(50, 30),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5)),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocListener<HomeBloc, HomeState>(
            listenWhen:  (previous, current)=>current is HomeActionState,
            listener: (context, state) {
              if (state is ProductTappedState) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProductView()));
                context
                    .read<ProductBloc>()
                    .add(LoadProductEvent(state.product));
              }
            },
  child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data?.length ?? 0,
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.6,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                var item = data![index];
                return LayoutBuilder(builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: InkWell(
                      onTap: () {
                        context
                            .read<HomeBloc>()
                            .add(ProductTapEvent(Product.fromJson(item)));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Center(
                                        child: Image.network(
                                          item["image_url"],
                                          errorBuilder: (context, a, b) {
                                            return const Icon(Icons
                                                .image_not_supported_outlined);
                                          },
                                        )),
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black12,
                                                spreadRadius: 0.1,
                                                blurRadius: 0.5)
                                          ]),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "${item["rating"]}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.green.shade900,
                                            size: 13,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          Text(
                            "${item["name"]}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "₹${item["discounted_price"]}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const WidgetSpan(
                                    child: SizedBox(
                                      width: 2,
                                    )),
                                TextSpan(
                                  text: "₹${item["original_price"]}",
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                              ])),
                          const Text(
                            "Free Delivery",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }),
),
        ],
      ),
    );
  }
}
