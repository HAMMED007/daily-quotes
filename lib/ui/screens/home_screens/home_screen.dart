import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_call_protection/core/constants/styles.dart';
import 'package:on_call_protection/ui/custom_widgets/custom_linear_background.dart';
import 'package:on_call_protection/ui/screens/home_screens/home_screen_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final formKey = GlobalKey<FormState>();
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: model.isFloadButtonActive
                ? Padding(
                    padding: EdgeInsets.only(bottom: 100.h),
                    child: FloatingActionButton(
                      backgroundColor: Color(0xff2B666B),
                      onPressed: () {
                        model.getRadomQuote();
                      },
                      child: SvgPicture.asset(
                        'assets/images/refresh.svg',
                      ),
                    ),
                  )
                : SizedBox(),
            body: SingleChildScrollView(
              child: CustomLinearBackground(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/backgrounddesign.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 35.w, right: 35, top: 80.h),
                    child: Column(
                      children: [
                        logOut(model),
                        SizedBox(
                          height: 55.h,
                        ),
                        DefaultTabController(
                          length: 2,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(148, 96, 177, 184),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: ButtonsTabBar(
                                  onTap: (value) {
                                    model.updateFloatButton(value);
                                  },
                                  controller: _tabController,
                                  backgroundColor: Color(0xff567275),
                                  radius: 10.r,
                                  buttonMargin: EdgeInsets.only(
                                    left: 15.w,
                                    right: 15.w,
                                  ),
                                  unselectedBackgroundColor: Colors.transparent,
                                  unselectedLabelStyle:
                                      TextStyle(color: Colors.white70),
                                  labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 40.w, vertical: 15.h),
                                  tabs: [
                                    Tab(
                                      text: "Home",
                                    ),
                                    Tab(
                                      text: "Daily Quote",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 1.sh - 290.h,
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _tabController,
                            children: <Widget>[
                              CustomQuoteContainer(
                                  auther: model.author!,
                                  model: model,
                                  text: model.quote!),

                              CustomQuoteContainer(
                                auther: model.authorOfTheDay!,
                                model: model,
                                text: model.quoteOfTheDay!,
                              ),

                              // CustomQuoteContainer(
                              //   text: Text(
                              //     'Keep away from people who try to belittle your ambitions. Small people always do that, but the really great ones make you feel that you, too, can become great.\n-- Mark Twain--',
                              //     style: kQuoteText,
                              //   ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 36.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
    //     ),
    //   ),
    // );
  }

  InkWell logOut(HomeViewModel model) {
    return InkWell(
      onTap: model.authService.logout,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            'assets/images/logouticon.svg',
            //   height: 40.h,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            'Logout',
            style: kLogoutText,
          ),
        ],
      ),
    );
  }
}

class CustomQuoteContainer extends StatelessWidget {
  CustomQuoteContainer({
    required this.text,
    required this.model,
    required this.auther,
  });
  final String text;

  final HomeViewModel model;
  final String auther;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //color: Colors.red,
          decoration: BoxDecoration(
            //color: Colors.red,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF567275),
                Color(0xFF2B393B),
              ],
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/leftquote.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  text.length > 2000 ? text.substring(0, 500) + '...' : text,
                  style: kQuoteText.copyWith(
                    fontSize: text.length > 600 ? 18.sp : 22.sp,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    auther.length > 25 ? text.substring(0, 20) + '...' : auther,
                    style: kQuoteText.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/rightquote.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 36.h,
        ),
      ],
    );
  }
}
