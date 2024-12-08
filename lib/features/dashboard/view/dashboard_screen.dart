import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userName = "Zohaib Hassan";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, $userName",
                  style: TextStyle(
                      fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Verified",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.notifications, color: Colors.black, size: 24.sp),
                Positioned(
                  top: -10,
                  right: 2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 30, color: Colors.green),
                  ),
                   SizedBox(height: 10),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 5),
                  Text(
                    "useremail@example.com",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading:  Icon(Icons.home),
              title:  Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:  Icon(Icons.work),
              title:  Text("Projects"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:  Icon(Icons.account_balance_wallet),
              title:  Text("Wallet"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:  Icon(Icons.settings),
              title:  Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:  Icon(Icons.logout),
              title:  Text("Logout"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title:  Text("Logout"),
                      content:  Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child:  Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context.go('/');
                          },
                          child:  Text("Logout"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

          ],
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),


              Container(
                margin: EdgeInsets.only(top: 20),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset:  Offset(0, 3),
                          ),
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset:  Offset(0, -3),
                          ),
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset:  Offset(3, 0),
                          ),
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset:  Offset(-3, 0),
                          ),
                        ],

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _accountDetail(
                            "Carbon Credits Available",
                            "20,000 (tons of CO2)",
                            Colors.green[700]!,
                            46.5.sp,
                          ),
                          const SizedBox(height: 8),
                          _accountDetail(
                            "Carbon Credits Sold",
                            "20,000 (tons of CO2)",
                            Colors.blue[700]!,
                            50.0.sp,
                          ),
                          const SizedBox(height: 8),
                          _accountDetail(
                            "Carbon Credits Earned",
                            "20,000 (tons of CO2)",
                            Colors.lightGreen[600]!,
                            54.0.sp,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -22,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Account Summary",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2.h),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          "assets/img_1.png",
                          height: 25.h,
                          width: 100.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      ClipRRect(
                        child: Image.asset(
                          "assets/img.png",
                          height: 22.h,
                          width: 100.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 26.h,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Recent Green Projects →",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // color: Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
               color: Colors.white.withOpacity(0.1),
              blurRadius: 2,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
           backgroundColor: Colors.white,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black.withOpacity(0.6),
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {},
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_sharp, size: 40),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.park_sharp, size: 40),
              label: "Projects",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet, size: 40),
              label: "Wallet",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes, size: 40),
              label: "Target",
            ),
          ],
        ),
      ),

    );
  }

  Widget _accountDetail(String title, String value, Color backgroundColor, double width ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:  TextStyle(
              fontSize: 16.sp,
              color: Colors.green,
            ),
          ),
          Container(
            width: (width),
            padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                Center(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}