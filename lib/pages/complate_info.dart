import 'package:effah/components/reusable_widgets/rounded_button.dart';
import 'package:effah/constants.dart';
import 'package:effah/modules/app/app_state_model.dart';
import 'package:effah/pages/basic_info/basic_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../managers/terms_manager.dart';
import '../models/terms_model.dart';

// ignore: use_key_in_widget_constructors
class ComplateInfo extends StatefulWidget {
   ComplateInfo({Key? key, required this.id}) : super(key: key);
 int id;
  @override
  State<ComplateInfo> createState() => _ComplateInfoState();
}

class _ComplateInfoState extends State<ComplateInfo> {
  // By defaut, the checkbox is unchecked and "agree" is "false"
  bool agree = false;

  // This function is triggered when the button is clicked
  void _doSomething() {
    // Do something
  }
  Future<Terms>? futureTerms;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.id");
    print(widget.id);
    if (futureTerms == null) {
      futureTerms = TermsManager().getTerms();
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateProvider>(context, listen: false);

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: transparnt,
      // ),
      body: Padding(
        padding:
            EdgeInsets.only(top: 20.h, bottom: 20.h, left: 10.h, right: 10.h),
        child: Column(children: [
          SizedBox(
            height: 65.h,
          ),
          // const Center(
          //   child: Text("Compalte"),
          // ),
          // TextButton(
          //     onPressed: () {
          //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>XDiPhoneXXS11Pro3()));
          //       model.completAccount();
          //     },
          //     child: const Text("Compalte"))

          Center(
            child: RichText(
              text: TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: TextStyle(
                    fontSize: 24.0,
                    color: darkblack,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: 'أهلا بك في  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                      fontFamily: 'JFFlat',
                    ),
                  ),
                  TextSpan(
                      text: 'عفة',
                      style: TextStyle(
                        color: basicPink,
                        fontFamily: 'JFFlat',
                        // fontWeight: FontWeight.w700,
                      ))
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
            child: Center(
              child: Text(
                'تطبيق الزواج الصادق',
                style: TextStyle(
                  fontFamily: 'JFFlat',
                  fontSize: 14.sp,
                  color: midGrey,
                  // fontWeight: FontWeight.normal
                ),
              ),
            ),
          ),

          // const SizedBox(
          //   height: 20,
          // ),
          Expanded(
            child: Center(
              child: Container(
                width: 343.w,
                height: 498.h,
                // adding margin
                margin: const EdgeInsets.all(10.0),

                // adding padding
                padding:
                    const EdgeInsets.only(bottom: 9.0, left: 9.0, right: 9.0),

                // height should be fixed for vertical scrolling
                // height: 120,
                decoration: BoxDecoration(

                    // adding borders around the widget
                    border: Border.all(
                        color: gGrey, width: 0.7.w, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10)),
                // SingleChildScrollView should be
                // wrapped in an Expanded Widget
                child: SafeArea(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    interactive: true,
                    child: SingleChildScrollView(
                      // for Vertical scrolling
                      scrollDirection: Axis.vertical,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: EdgeInsets.only(
                              //   top: 5.h,
                              left: 8.0.w,
                              right: 8.0.w,
                              bottom: 10.0.h),
                          child: FutureBuilder<Terms>(
                              future: futureTerms,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              // top: 10.h,
                                              bottom: 30.h),
                                          child: Text(
                                            '${snapshot.data!.title}',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          '${snapshot.data!.content}',
                                          // "  ببساطة نص شكلي (بمعنى أن الغاية هي الشكل "
                                          // "و ليس المحتوى) ويُستخدم في صناعات المطابع"
                                          // "ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص "
                                          // "الشكلي منذ القرن الخامس عشر عندما قامت مطبعة "
                                          // "مجهولة برص مجموعة من الأحرف بشكل عشوائي"
                                          // "أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع "
                                          // "شكلي لهذه الأحرف. خمسة قرون من الزمن لم "
                                          // "تقضي على هذا النص، بل انه حتى صار مستخدماً "
                                          // "وبشكله الأصلي في الطباعة والتنضيد الإلكتروني. "
                                          // "انتشر بشكل كبير في ستينيّات هذا القرن  ببساطة نص "
                                          // "شكلي (بمعنى أن الغاية هي الشكل وليس "
                                          // "المحتوى) ويُستخدم في صناعات المطابع ودور "
                                          // "النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي "
                                          // "منذ القرن الخامس عشر عندما قامت مطبعة مجهولة "
                                          // "برص مجموعة من الأحرف بشكل عشوائي أخذتها من "
                                          // " نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه "
                                          // "الأحرف. خمسة قرون من الزمن لم تقضي على هذا "
                                          // "النص، بل انه حتى صار مستخدماً وبشكله الأصلي في "
                                          // "الطباعة والتنضيد الإلكتروني. انتشر بشكل كبير في "
                                          // "ستينيّات هذا القرن  ببساطة نص شكلي (بمعنى أن "
                                          // "الغاية هي الشكل وليس المحتوى) ويُستخدم في "
                                          // "صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال "
                                          // "المعيار للنص الشكلي منذ القرن الخامس عشر عندما"
                                          // "قامت مطبعة مجهولة برص مجموعة من الأحرف "
                                          // "بشكل عشوائي أخذتها من نص، لتكوّن كتيّب بمثابة "
                                          // "دليل أو مرجع شكلي لهذه الأحرف. خمسة قرون من "
                                          // "الزمن لم تقضي على هذا النص، بل انه حتى صار "
                                          // "مستخدماً وبشكله الأصلي في الطباعة والتنضيد "
                                          // "الإلكتروني. انتشر بشكل كبير في ستينيّات هذا القرن",

                                          style: TextStyle(
                                            color: lGrey,

                                            // fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                            letterSpacing: 1,
                                            wordSpacing: 1,
                                          ),
                                        ),
                                      ]);
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }

                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ]);
                              }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'لقد قرأت الشروط والاحكام',
                style: TextStyle(fontSize: 14.sp),
                // overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: 5.w,
              ),
              Material(
                child: Checkbox(
                  activeColor: basicPink,
                  value: agree,
                  onChanged: (value) {
                    setState(() {
                      agree = value ?? false;
                    });
                  },
                ),
              ),
            ],
          ),

          SizedBox(
            width: 148.w,
            // height: 44.h,
            child: RoundedButton(
              mywidget: Padding(
                padding: EdgeInsets.symmetric(vertical: 7),
                child: Text('ابدأ',
                    style: TextStyle(
                      color: agree ? white : darkgrey,
                      fontSize: 16.sp,
                      //fontWeight: FontWeight.w500
                    )),
              ),
              myfun: agree
                  ? () {
                      _doSomething;
                      //model.completAccount();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BasicInfo(id: widget.id,)));
                    }
                  : () {},
              raduis: 10,
              color: agree ? basicPink : lwhite,
              //() {
              //   print('Pressed');

              //   //agree ? _doSomething : null;
              //   model.verified();
              // },
            ),
          )
          // TextButton(
          //     child: Padding(
          //       padding: EdgeInsets.only(left: 40.0, right: 40.0),
          //       child: Text('ابدأ',
          //           style: TextStyle(
          //               color: agree
          //                   ? const Color(0xFFFFFFFF)
          //                   : Color.fromARGB(255, 121, 118, 118),
          //               fontSize: 18,
          //               fontWeight: FontWeight.w500)),
          //     ),
          //     style: TextButton.styleFrom(
          //       backgroundColor: agree
          //           ? const Color(0xffff8297)
          //           : Color.fromARGB(255, 231, 230, 230),
          //       // primary: Colors.teal,
          //       // onSurface: Colors.yellow,
          //       // side: BorderSide(color: Colors.teal, width: 2),
          //       shape: const RoundedRectangleBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(10))),
          //     ),
          //     onPressed:
          // agree
          //         ? () {
          //             _doSomething;
          //             //model.completAccount();
          //             Navigator.of(context).push(
          //                 MaterialPageRoute(builder: (context) => BasicInfo()));
          //           }
          //         : null
          //     // () {
          //     //   print('Pressed');

          //     //   //agree ? _doSomething : null;
          //     //   model.verified();
          //     // },
          //     )
        ]),
      ),
    );
  }
}
