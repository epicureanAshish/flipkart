import 'package:flipkart/ui/constants/app_colors.dart';
import 'package:flipkart/ui/screens/cart/cart_view.dart';
import 'package:flipkart/ui/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:flipkart/ui/screens/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(

          extendBody: true,
          extendBodyBehindAppBar: true,
          body: context.read<DashboardBloc>().currentIndex==4?CartView(): HomeView(),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: AppColors.blue,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              currentIndex: state.index,
              onTap: (index){
                context.read<DashboardBloc>().add(ChangeTabEvent(index: index));
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.play_circle), label: "Play"),
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Categories"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),

              ]),
        );
      },
    );
  }
}
