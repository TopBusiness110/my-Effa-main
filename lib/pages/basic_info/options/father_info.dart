import 'package:effah/constants.dart';
import 'package:effah/managers/question_manager.dart';
import 'package:effah/models/question_model.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

import '../../../../components/questions/multiple_choices.dart';
import '../../../../components/questions/one_choice.dart';
import '../../../../components/questions/text_question.dart';
import '../../../../modules/basic_info_provider.dart';

import 'options.dart';

class FatherInfo extends StatelessWidget {
  FatherInfo(
      {Key? key,
    
      required this.id,
      required this.gender})
      : super(key: key);
 
  int gender;
  int? id;

  bool press = false;


  TextEditingController editingController = TextEditingController();

  int tapIndex = 0;
  static int myLen = 0;
  static int femaleLen = 0;

  Future<List<Question>>? femaleQuestionList;
  final controller = SwiperController();

  var g, myfLen, k;
  int h = 0;
  int len = 0;
  int fLen = 0;
  int level = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 65.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                SvgPicture.asset("assets/icon/nextto.svg"),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "بيانات ولي الأمر",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, bottom: 45.h, top: 20.h),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Consumer<InfoProvider>(builder: (_, a, child) {
                    return LinearProgressIndicator(
                      minHeight: 9.h,
                      backgroundColor: bgrey,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(basicPink),
                      value: Provider.of<InfoProvider>(context, listen: false)
                          .parentProgressValue,
                    );
                  }),
                )),
          ),
        ),
        FutureBuilder<List<Question>>(
            future: QuestionManager().getQuestions(2, level,context),
            builder: (context, snapshot) {
              Future<List<Question>> list= QuestionManager().getQuestions(2, level ,context);
              if (snapshot.hasData) {
                return Expanded(
                  child: Swiper(
                    controller: controller,
                    onIndexChanged: (value) {
                      Provider.of<InfoProvider>(context, listen: false)
                          .myIndexParent = value;
                      print("${value+1}dssssssssssssssssssssssssssssssssssssssssssssssssssssssd");
                      print("${QuestionManager.len}dsssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssssssssssssssssssd");

                      QuestionManager.len == value+1 ? level++:null;
                      print(level);
                    },
                    loop: false,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int x) {
                      if (snapshot.data![x].type == 1) {
                        return Center(
                          child:  TextQuestion(
                            id: id,
                            Q_id:  snapshot.data![x].id,
                            question: snapshot.data![x].content!,
                            answers: snapshot.data![x].answers,),
                        );
                      } else if (snapshot.data![x].type == 2 ||
                          snapshot.data![x].type == 4) {
                        return Center(
                          child: OneChoice(
                            editingController: editingController,
                            id: id,
                            Q_id:  snapshot.data![x].id,
                            answers: snapshot.data![x].answers,
                            question: snapshot.data![x].content!,),
                        );
                      } else {
                        return Center(
                          child: MultipleChoices(
                            id: id,
                            Q_id: snapshot.data![x].id,
                            question:snapshot.data![x].content!,
                            answers:snapshot.data![x].answers,
                          ),
                        );
                      }
                    },
                    itemCount: QuestionManager.len,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
        Consumer<InfoProvider>(builder: (_, a, child) {
          if (Provider.of<InfoProvider>(context, listen: false).myIndexParent ==
              0) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5.w,
                        // assign the color to the border color
                        color: transparnt,
                      ),
                      color: basicPink,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      child: Text('تخطي',
                          style: TextStyle(
                            color: white,
                            fontSize: 16.sp,
                            // fontWeight: FontWeight.w500
                          )),
                      style: TextButton.styleFrom(
                        // backgroundColor: const Color(0xffff8297),
                        // primary: Colors.teal,
                        // onSurface: Colors.yellow,
                        // side: BorderSide(color: Colors.teal, width: 2),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        _updateProgress(context);
                        controller.next();

                        increment(context);
                      },
                    ),
                  ),
                ));
          } else if (Provider.of<InfoProvider>(context, listen: false)
                  .myIndexParent ==
              QuestionManager.len - 1) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: transparnt,
                      border: Border.all(
                        width: 1.5.w,
                        // assign the color to the border color
                        color: black,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextButton(
                      child: Text('السابق',
                          style: TextStyle(
                            color: black,
                            fontSize: 16.sp,
                            //fontWeight: FontWeight.w500
                          )),
                      style: TextButton.styleFrom(
                        // backgroundColor: const Color(0xffff8297),
                        // primary: Colors.teal,
                        // onSurface: Colors.yellow,
                        // side: BorderSide(color: Colors.teal, width: 2),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        _removeProgress(context);
                        controller.previous();

                        decrement(context);
                      },
                    ),
                  ),
                ));
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SizedBox(
                width: double.infinity,
                child: Row(children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5.w,
                          // assign the color to the border color
                          color: transparnt,
                        ),
                        color: basicPink,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextButton(
                        child: Text('تخطي',
                            style: TextStyle(
                              color: white,
                              fontSize: 16.sp,
                              // fontWeight: FontWeight.w500
                            )),
                        style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () {
                          _updateProgress(context);

                          controller.next();

                          increment(context);
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: SizedBox(
                      width: 25.w,
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: transparnt,
                          border: Border.all(
                            width: 1.5.w,
                            // assign the color to the border color
                            color: black,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextButton(
                          child: Text('السابق',
                              style: TextStyle(
                                color: black,
                                fontSize: 16.sp,
                                //fontWeight: FontWeight.w500
                              )),
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          onPressed: () {
                            _removeProgress(context);
                            controller.previous();

                            decrement(context);

                            // // _updateProgress(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Options(
                            //               gender: 0,
                            //               progress: _progressValue,
                            //               id: id,
                            //             )));
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          }
        }),
        SizedBox(
          height: 30.h,
        ),
        GestureDetector(
          onTap: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Options(
                          gender: 0,
                          id: id,
                        
                        )));
          }),
          child: Text(
            "الانهاء في وقت اخر",
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ]),
    );
  }

  // Future<List<Question>> getQuestions() async {
  //   return await QuestionManager().getQuestions(id!, 5, gender);
  // }

  void increment(BuildContext context) {
    // setState(() {
    // visible = true;
    Provider.of<InfoProvider>(context, listen: false).myIndexParent++;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
    // });
  }

  void decrement(BuildContext context) {
    // setState(() {
    // visible = true;
    Provider.of<InfoProvider>(context, listen: false).myIndexParent--;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
    // });
  }

  void _updateProgress(BuildContext context) {
    //Provider.of<InfoProvider>(context, listen: false).updateProgress(_progressValue);
    Provider.of<InfoProvider>(context, listen: false).parentProgressValue +=
        1 / QuestionManager.len;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void _removeProgress(BuildContext context) {
    if (Provider.of<InfoProvider>(context, listen: false).parentProgressValue !=
        (1.0 - (1 / QuestionManager.len))) {
      Provider.of<InfoProvider>(context, listen: false).parentProgressValue -=
          1 / QuestionManager.len;
      Provider.of<InfoProvider>(context, listen: false).rebuild();
    }
  }
}
