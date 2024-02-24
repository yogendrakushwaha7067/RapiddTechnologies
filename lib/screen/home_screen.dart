

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController=Get.put(HomeController());
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    homeController.getCourse();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // User reached the end of the list
      if (!isLoading) {
        // Load more data
        setState(() {
          isLoading = true;
        });
        _loadMoreData();
      }
    }
  }
  void _loadMoreData() {
    // Simulate loading more data (replace this with your actual data fetching logic)
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
         homeController.getCourse1();
        isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F9FA),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text("Academy",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal)),
        leading: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,),
      ),
      body: GetBuilder(
        init: HomeController(),
        builder: (con) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("Showing ${homeController.listcourse.length} Courses",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),
              ),

              SizedBox(height: 20,),
              Expanded(
                child:homeController.isdataloading==true?Center(child: CircularProgressIndicator(),): ListView.builder(
                    itemCount: homeController.listcourse.length+ (isLoading ? 1 : 0),
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemBuilder: (context,index){

                  if (index < homeController.listcourse.length) {
                    return   Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network("${ homeController.listcourse[index].image}",),

                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("${ homeController.listcourse[index].title}",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal),),

                                  Text("${ homeController.listcourse[index].description}",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.normal),),

                                  // Text("Showing 14 Courses",style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.normal),),


                                  Row(
                                    children: [
                                      Expanded(
                                        flex:3,
                                        child: RatingBar.builder(
                                          initialRating:double.parse( "${ homeController.listcourse[index].rating?.rate}"),
                                          minRating: 1,itemSize: 12,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star_border,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Text("${ homeController.listcourse[index].rating?.rate}")),
                                      Expanded(
                                          flex: 2,
                                          child: Text("(${ homeController.listcourse[index].rating?.count})")),
                                      Expanded(
                                          flex: 2,
                                          child: Text("\$${ homeController.listcourse[index].price}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),


                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }else{
                    return Center(child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                          // height: 30,
                          // width: 50,

                          child: CircularProgressIndicator()),
                    ),);
                  }


                }),
              )

            ],
          );
        }
      ),
    );
  }
}
