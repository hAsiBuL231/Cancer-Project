import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LifestylePage extends StatefulWidget {
  const LifestylePage({super.key});

  @override
  State<LifestylePage> createState() => _LifestylePageState();
}

class _LifestylePageState extends State<LifestylePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            foregroundColor: Colors.black,
            title: RichText(
                softWrap: true,
                text: const TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'Life',
                      style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Style',
                      style: TextStyle(fontSize: 24, color: Color(0xFF016DF7), fontWeight: FontWeight.bold))
                ]))),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: InkWell(
                    onTap: () => setState(() {
                      index == 1 ? index = 0 : index = 1;
                    }),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              '1. Maintain a Healthy Weight',
                              style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.outfit().fontFamily),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (index == 1)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                      child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Keeping weight in check can be hard, but it has amazing health benefits, including lowering the risk of 13 different cancers. "
                              "A few simple tips can help. First off, if you’re overweight, focus on not gaining any more weight. "
                              "This by itself has real benefit. Then, when you’re ready, try to take off some extra pounds for an even greater health boost."),
                          Text("\nTips:"),
                          BulletList([
                            'Fit physical activity and movement into your life each day.',
                            'Limit time in front of the TV and computer, and try to stand more.',
                            'Eat a diet rich in fruits, vegetables and whole grains.',
                            'Choose smaller portions, eat more slowly and limit sugary drinks.',
                          ]),
                        ],
                      ),
                    ),
                  )),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: InkWell(
                    onTap: () => setState(() {
                      index == 2 ? index = 0 : index = 2;
                    }),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              '2. Exercise Regularly',
                              style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.outfit().fontFamily),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (index == 2)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                      child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Few things are as good for you as regular physical activity. While it can be hard to find the time, "
                              "it’s important to fit in at least 30 minutes of activity every day. More is even better, but any amount is better than none."),
                          Text("\nTips:"),
                          BulletList([
                            'Choose activities you enjoy. Many things count as exercise, including walking, gardening and dancing.',
                            'Make exercise a habit by setting aside the same time for it each day. Go to the gym at lunchtime or take a walk after dinner.',
                            'Keep it fun and stay motivated by exercising with someone.',
                            'Be active as a family – go to the park, take walks and play active games.',
                          ]),
                        ],
                      ),
                    ),
                  )),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: InkWell(
                    onTap: () => setState(() {
                      index == 3 ? index = 0 : index = 3;
                    }),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              '3. Don’t Smoke Or Use Smokeless\nTobacco',
                              style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.outfit().fontFamily),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (index == 3)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                      child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Tobacco causes many types of cancer, along with other serious problems. So, stay tobacco-free. If you smoke or use smokeless tobacco "
                              "(like chewing tobacco, snuff or snus), quitting is one of the best things you can do for your health. Yes, it’s hard, but you can do it."),
                          Text("\nTips:"),
                          BulletList([
                            'Keep trying! It often takes many attempts before you quit for good.',
                            'Talk to a doctor about quitting, which can double the chances of success.',
                            'Call 800-QUIT-NOW (866-QUIT-YES in Illinois) or visit smokefree.gov for help.',
                            'Talk to your kids about the dangers of smoking, vaping and using smokeless tobacco. The best message to kids is being tobacco-free yourself.',
                          ]),
                        ],
                      ),
                    ),
                  )),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: InkWell(
                    onTap: () => setState(() {
                      index == 4 ? index = 0 : index = 4;
                    }),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              '4. Eat a Healthy Diet',
                              style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.outfit().fontFamily),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (index == 4)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                      child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "The basics of healthy eating are pretty simple. Focus on fruits, vegetables and whole grains, and keep red meat and processed "
                              "meat to a minimum. It’s also important to cut back on bad fats (saturated and trans fats), and choose healthy fats "
                              "(polyunsaturated and monounsaturated fats) more often."),
                          Text("\nTips:"),
                          BulletList([
                            'Make fruits and vegetables a part of every meal. Put fruit on your cereal. Eat vegetables as a snack.',
                            'Choose chicken, fish or beans instead of red and processed meat.',
                            'Choose whole-grain cereal and whole-wheat bread instead of sugary cereal and white bread.',
                            'Choose dishes made with olive or canola oil, which are high in healthy fats.',
                            'Cut back on fast food and store-bought snacks (like cookies).',
                            'Eating a healthy diet is best – but consider a standard multivitamin if you regularly fall short.',
                          ]),
                        ],
                      ),
                    ),
                  )),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: InkWell(
                    onTap: () => setState(() {
                      index == 5 ? index = 0 : index = 5;
                    }),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              '5. Limit Alcohol – Zero Is Best',
                              style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.outfit().fontFamily),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (index == 5)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                      child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Drinking alcohol can increase the chances of developing six different types of cancer. And just ½ to 1 drink a day can increase the "
                              "risk of breast and colon cancer. While moderate drinking may be good for the heart in older adults, zero alcohol is the healthiest"
                              " choice overall."),
                          Text("\nTips:"),
                          BulletList([
                            'Choose nonalcoholic beverages at meals and parties.',
                            'Avoid occasions centered around alcohol.',
                            'Talk to a healthcare professional if you feel you have a problem with alcohol.',
                            'When appropriate, discuss the dangers of drugs and alcohol with children.',
                          ]),
                        ],
                      ),
                    ),
                  )),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: InkWell(
                    onTap: () => setState(() {
                      index == 6 ? index = 0 : index = 6;
                    }),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              '6. Protect Yourself from the Sun\nAnd Avoid Tanning Beds',
                              style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.outfit().fontFamily),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (index == 6)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                      child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "While the warm sun can feel great, too much exposure to it can lead to skin cancer, including melanoma. "
                              "And tanning beds can be just as harmful. Skin damage starts early in childhood, so it’s especially important to protect children."),
                          Text("\nTips:"),
                          BulletList([
                            'If possible, steer clear of direct sunlight between 10 a.m. and 4 p.m. (peak burning hours). It’s the best way to protect yourself.',
                            'Use hats, long-sleeve shirts and sunscreens with SPF 30 or higher.',
                            'Don’t use tanning beds or tanning booths.',
                            'Protect kids first, and set a good example by always wearing sunscreen and the right clothing.',
                          ]),
                        ],
                      ),
                    ),
                  )),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: InkWell(
                    onTap: () => setState(() {
                      index == 7 ? index = 0 : index = 7;
                    }),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              '7. Protect Yourself From Sexually\nTransmitted Infections',
                              style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.outfit().fontFamily),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (index == 7)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                      child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Sexually transmitted infections – like human papillomavirus (HPV), hepatitis and HIV – can cause a number of different cancers."
                              " Protecting against these infections can lower risk. Try to always practice safer sex, which lowers the chance of getting a "
                              "sexually transmitted infection. It’s also important to follow HPV vaccine recommendations for children and adults. Boys and girls "
                              "should get vaccinated at 9 to 12 years old, which helps prevent cancer later in life. But the vaccine is recommended up to age 26, "
                              "and can be given up to age 45. Talk to a healthcare provider or visit cdc.gov/HPV for more information."),
                          Text("\nTips:"),
                          BulletList([
                            'Make sure your healthcare provider includes the HPV vaccine as part of your child’s regular vaccinations. If not, ask for it.',
                            'If you’re an adult and haven’t had the HPV vaccine, talk to a provider about getting it. If you’re not sure if you’ve had the vaccine, ask your parents or try to find a copy of your vaccine record.',
                            'Visit cdc.gov/sexualhealth for more information on safer sex and sexual health.',
                            'When appropriate, discuss with children the importance of sexual responsibility and safer sex.',
                          ]),
                        ],
                      ),
                    ),
                  )),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                  child: InkWell(
                    onTap: () => setState(() {
                      index == 8 ? index = 0 : index = 8;
                    }),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Text(
                              '8. Get Screening Tests',
                              style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.outfit().fontFamily),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (index == 8)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                      child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "There are a number of important screening tests that can help protect against cancer. Some of these tests find cancer early "
                              "when it is more treatable, while others can actually help keep cancer from developing in the first place."),
                          Text(
                              "Guidelines can vary, but talk with your healthcare provider about screening at these ages:"),
                          Text("\nAge 21:"),
                          Padding(padding: EdgeInsets.only(left: 20), child: Text("– Cervical cancer")),
                          Text("\nAge 40:"),
                          Padding(padding: EdgeInsets.only(left: 20), child: Text("– Breast cancer")),
                          Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                  "– Prostate cancer (For African American men and others at highest risk, discuss benefits and risks of screening with a healthcare provider)")),
                          Text("\nAge 45:"),
                          Padding(padding: EdgeInsets.only(left: 20), child: Text("– Colon cancer")),
                          Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                  "– Prostate cancer (For average-risk men, discuss benefits and risks of screening with a healthcare provider)")),
                          Text("\nAge 50:"),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("– Lung cancer (For people who smoke or used to smoke)"),
                          ),
                          Text(
                              "\nIf you have a family history of cancer, you may need to get tests at a younger age.",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  )),
                ),

              /*const Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Maintain a Healthy Weight"),
              )),
              const Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Exercise Regularly"),
              )),
              const Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Don't Smoke"),
              )),
              const Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Eat a Healthy Diet"),
              )),
              const Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Get Screening Test"),
              )),*/
            ],
          ),
        ),
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> strings;

  const BulletList(this.strings, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 24,
                  //height: 1.55,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  str,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.6),
                    height: 1.2,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
