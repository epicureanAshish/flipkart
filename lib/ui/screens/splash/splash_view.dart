import 'package:flipkart/ui/constants/app_assets.dart';
import 'package:flipkart/ui/constants/app_colors.dart';
import 'package:flipkart/ui/screens/dashboard/dashboard_view.dart';
import 'package:flipkart/ui/screens/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(LoadSplashEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DashboardView()));
          }
        },
        child: Container(
          color: AppColors.blue,
          alignment: Alignment.center,
          child: Image.asset(AppAssets.appLogo, height: 80,),
        ),
      ),
    );
  }
}
