import 'package:effah/modules/app/app_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';

import '../../../components/questions/multiple_choices.dart';
import '../../../components/questions/one_choice.dart';
import '../../../components/questions/text_question.dart';
import '../../../constants.dart';
import '../../../managers/question_manager.dart';
import '../../../models/question_model.dart';
import '../../../modules/basic_info_provider.dart';
import '../religion_info.dart';
import 'options.dart';
import '../birthdate_info.dart';

class Education extends StatelessWidget {
  Education(
      {Key? key,
      required this.progress,
      required this.id,
      required this.gender})
      : super(key: key);
  late double progress;
  int? id;
  int gender;
//   @override
//   State<Education> createState() => _EducationState();
// }

// class _EducationState extends State<Education> {
  bool press = false;
  bool isChecked = false;
  late bool _loading;

  late double _progressValue = progress;
  TextEditingController editingController = TextEditingController();

  final controller = SwiperController();

  int tapIndex = 0;

  //int tapIndex = 0;
  static int myLen = 0;
  static int femaleLen = 0;
  Future<List<Question>>? maleQuestionList;
  Future<List<Question>>? femaleQuestionList;
  var g, myfLen, k;
  int h = 0;
  int len = 0;
  int fLen = 0;
  // getLength() async {
  //   // myLen = g.length;
  //   k = await QuestionManager().getQuestions(id!, 3, 1);
  //   myLen = k.length;

  //   myfLen = await QuestionManager().getQuestions(id!, 3, 2);
  //   femaleLen = myfLen.length;

  //   // print(g.length);
  //   // len = g.length;
  //   // print("len");
  //   // print(myLen);
  // }

  @override
  Widget build(BuildContext context) {
    maleQuestionList = QuestionManager().getQuestions(id!, 3, 1);
    femaleQuestionList = QuestionManager().getQuestions(id!, 3, 2);
Future<List<Question>> list= QuestionManager().getQuestions(id!, 3, gender);
  
  list.then((value) {
      print("gender ");
      print(QuestionManager.len);
      print(Provider.of<InfoProvider>(context, listen: false)
          .educationProgressValue);
      Provider.of<InfoProvider>(context, listen: false).educationProgressValue =
          1 / QuestionManager.len;
    });
    print("gender ==");
    print(QuestionManager.len);
    print(Provider.of<InfoProvider>(context, listen: false)
        .educationProgressValue);
    // if (gender == 1) {
    //   QuestionManager().getQuestions(id!, 3, 1);
    //   print("gender == 1");
    //   print(QuestionManager.len);
    //   print(Provider.of<InfoProvider>(context, listen: false)
    //       .educationProgressValue);
    //   Provider.of<InfoProvider>(context, listen: false).educationProgressValue =
    //       1 / QuestionManager.len;
    // } else {
    //  QuestionManager().getQuestions(id!, 3, 2);

    //   print("gender == 2");
    //   print(QuestionManager.len);
    //   print(Provider.of<InfoProvider>(context, listen: false)
    //       .educationProgressValue);
    // }
    // Color getColor(Set<MaterialState> states) {
    //   const Set<MaterialState> interactiveStates = <MaterialState>{
    //     MaterialState.pressed,
    //     MaterialState.hovered,
    //     MaterialState.focused,
    //   };
    // if (states.any(interactiveStates.contains)) {
    //   return Colors.blue;
    //   // }
    //   return white;
    //   // Color(0xffff8297)
    // }

    // final model = Provider.of<AppStateProvider>(context, listen: false);
    // TextEditingController firstName = TextEditingController();
    // TextEditingController secondName = TextEditingController();

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: transparnt,
      // ),
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
                  "التعليم & العمل",
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
                          .educationProgressValue,
                    );
                  }),
                )),
          ),
        ),

        Expanded(
          flex: 3,
          //height: fit,
          child: SizedBox(
            //  height: 600.h,
            child: FutureBuilder<List<Question>>(
                future: gender == 1 ? maleQuestionList : femaleQuestionList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Swiper(
                      controller: controller,
                      onIndexChanged: (value) {
                        Provider.of<InfoProvider>(context, listen: false)
                            .myIndexEducation = value;
                      },
                      loop: false,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int x) {
                        // getLength().then((v) {
                        //   // myLen = len;
                        // });

                        if (snapshot.data![x].type == 1) {
                          return Center(
                            child: TextQuestion(
                                id: id,
                                myLength: gender == 1 ? myLen : femaleLen,
                                progress: _progressValue,
                                questions: gender == 1
                                    ? maleQuestionList
                                    : femaleQuestionList,
                                myIndex: Provider.of<InfoProvider>(context,
                                        listen: false)
                                    .myIndexEducation),
                          );
                        } else if (snapshot.data![x].type == 2 ||
                            snapshot.data![x].type == 4) {
                          return Center(
                            child: OneChoice(
                                gender: gender,
                                editingController: editingController,
                                id: id,
                                myLength: gender == 1 ? myLen : femaleLen,
                                progress: _progressValue,
                                questions: gender == 1
                                    ? maleQuestionList
                                    : femaleQuestionList,
                                myIndex: Provider.of<InfoProvider>(context,
                                        listen: false)
                                    .myIndexEducation),
                          );
                        } else {
                          return Center(
                            child: MultipleChoices(
                                id: id,
                                myLength: gender == 1 ? myLen : femaleLen,
                                progress: _progressValue,
                                questions: gender == 1
                                    ? maleQuestionList
                                    : femaleQuestionList,
                                myIndex: Provider.of<InfoProvider>(context,
                                        listen: false)
                                    .myIndexEducation

                                // myLength: gender == 1 ? myLen : femaleLen,
                                // progress: _progressValue,
                                // questions: gender == 1
                                //     ? maleQuestionList
                                //     : femaleQuestionList,
                                // myIndex: Provider.of<InfoProvider>(context,
                                //         listen: false)
                                //     .myIndex
                                ),
                          );
                        }
                      },
                      itemCount: QuestionManager.len,
                      //  gender == 1 ? myLen :femaleLen,
                      //3
                      // control: const SwiperControl(
                      //   color: black,
                      //   disableColor: red,
                      //   //padding:  EdgeInsets.only(bottom: 50.h ) ,
                      //   // // size: ,

                      //   iconPrevious: Icons.arrow_back_ios,
                      //   iconNext: Icons.arrow_forward_ios,
                      // ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),

        // SizedBox(
        //   height: 25.h,
        // ),

        Consumer<InfoProvider>(builder: (_, a, child) {
          if (Provider.of<InfoProvider>(context, listen: false)
                  .myIndexEducation ==
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
                        // visible = true;
                        // Provider.of<InfoProvider>(context, listen: false)
                        //     .rebuild();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Options(
                        //               progress: _progressValue,
                        //               id: id,
                        //               gender: 0,
                        //             )));
                      },
                    ),
                  ),
                ));
          } else if (Provider.of<InfoProvider>(context, listen: false)
                  .myIndexEducation ==
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
                        // Provider.of<InfoProvider>(context, listen: false)
                        //     .myIndex++;

                        // Provider.of<InfoProvider>(context, listen: false)
                        //     .rebuild();
                        _removeProgress(context);
                        controller.previous();

                        decrement(context);
                        print("pressed");
                        print(Provider.of<InfoProvider>(context, listen: false)
                            .myIndexEducation);
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
                          // visible = true;
                          // Provider.of<InfoProvider>(context, listen: false)
                          //     .rebuild();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Options(
                          //               progress: _progressValue,
                          //               id: id,
                          //               gender: 0,
                          //             )));
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
                    // Provider.of<InfoProvider>(context, listen: false)
                    //             .myIndex ==
                    //         0
                    //     ? visible
                    //     : !visible,
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
                            print("pressed");
                            print(Provider.of<InfoProvider>(context,
                                    listen: false)
                                .myIndexEducation);
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
                          progress: _progressValue,
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
  //   return await QuestionManager().getQuestions(id!, 3, gender);
  // }

  void increment(BuildContext context) {
    Provider.of<InfoProvider>(context, listen: false).myIndexEducation++;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void decrement(BuildContext context) {
    Provider.of<InfoProvider>(context, listen: false).myIndexEducation--;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void _updateProgress(BuildContext context) {
    //Provider.of<InfoProvider>(context, listen: false).updateProgress(_progressValue);

    Provider.of<InfoProvider>(context, listen: false).educationProgressValue +=
        1 / QuestionManager.len;
    Provider.of<InfoProvider>(context, listen: false).rebuild();
  }

  void _removeProgress(BuildContext context) {
    //Provider.of<InfoProvider>(context, listen: false).updateProgress(_progressValue);

    if (Provider.of<InfoProvider>(context, listen: false)
            .educationProgressValue !=
        (1.0 - (1 / QuestionManager.len))) {
      Provider.of<InfoProvider>(context, listen: false)
          .educationProgressValue -= 1 / QuestionManager.len;
      Provider.of<InfoProvider>(context, listen: false).rebuild();
    }
  }
}