import 'dart:async';
import 'package:fintrack/core/application/resource/app_assets.dart';
import 'package:fintrack/core/application/resource/app_colors.dart';
import 'package:fintrack/core/application/resource/app_size.dart';
import 'package:fintrack/core/application/resource/app_styles.dart';
import 'package:fintrack/core/utils/app_context.dart';
import 'package:fintrack/features/main/routes/main_pathe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScale;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
    );

    _textSlideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _controller.forward();

    Timer(const Duration(milliseconds: 2000), () {
      context.pushReplacement(mainPathe);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppContext appContext = AppContext.of(context);
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          ScaleTransition(
            scale: _logoScale,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                width: getResponsiveSize(context: context, fontSize: AppSize.s150),
                height: getResponsiveSize(context: context, fontSize: AppSize.s150),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.splashcon,
                    width: getResponsiveSize(context: context, fontSize: AppSize.s75),
                    height: getResponsiveSize(context: context, fontSize: AppSize.s75),
                  ),
                ),
              ),
            ),
          ),

          const Gap(AppSize.s24),

          SlideTransition(
            position: _textSlideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Text(
                    appContext.localText.fin_track,
                    style: AppStyles.getBoldSens36(context: context),
                  ),
                  const Gap(AppSize.s12),
                  Text(
                    appContext.localText.org_mony_smart,
                    style: AppStyles.getMeduimSens14(
                      context: context,
                      fontSize: AppSize.s16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          FadeTransition(
            opacity: _fadeAnimation,
            child: const SpinKitThreeBounce(
              color: Colors.white,
              size: 25,
            ),
          ),
          const Gap(AppSize.s80),
        ],
      ),
    );
  }
}
