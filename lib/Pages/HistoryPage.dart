import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../All Functions Page/Functions.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Cancer History"), elevation: 10, backgroundColor: Colors.amber),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
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
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          'What is Cancer?',
                          style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.outfit().fontFamily),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          index == 1 ? index = 0 : index = 1;
                        }),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (index == 1)
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                    child: Center(
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: RichText(
                        softWrap: true,
                        text: const TextSpan(
                          text:
                              "Cancer is a group of diseases which arises from a single mutation resulting in uncontrolled cell proliferation and spread (metastasis) to nearby tissue or secondary organs. "
                              "The abnormal mass of cells is termed as tumor or neoplasm. The tumor is benign when the cells are not invasive. "
                              "When the cells become capable of invading the surrounding tissue, it is called malignant, i.e., cancer.\n\n",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  "Cancer can be treated by surgery, that is, removing tumor when it is in the benign stage. "
                                  "Chemotherapy is used to kill cancerous cells. It includes intravenous injection, cream or ointment, oral drugs (liquid, capsule, and tablet). "
                                  "Radiation is used alone or with the combination of surgery or chemotherapy. "
                                  "Other treatments include immunotherapy (use of cytokine, antibody), hormonal therapy, stem cell transplants.\n\n",
                            ),
                            TextSpan(
                                text:
                                    "About 30-50% of cancer can be prevented by improving lifestyle, avoiding tobacco or alcohol, and raising awareness about infection, exposure to carcinogens and environmental pollution.")
                          ],
                        ),
                      )),
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
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          'Cancer Types',
                          style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.outfit().fontFamily),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          index == 2 ? index = 0 : index = 2;
                        }),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ],
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
                    child: Text(
                      "According to the tissue of origin, types of cancers are-\n"
                      "   1. Carcinoma (arising from epithelial cells)\n"
                      "   2. Sarcoma (developed from connective tissue or muscle cells)\n"
                      "   3. Melanoma (derived from skin pigment)\n"
                      "   4. Leukemia (cancers of white blood cells)\n"
                      "   5. Lymphoma & Myeloma (originated from immune cells)\n\n"
                      "More than 100 types of cancers are classified according to the organs involved (WHO, 2018). The most common are-\n"
                      "   1. Lung cancer (2.09 million cases)\n"
                      "   2. Breast cancer (2.09 million cases)\n"
                      "   3. Colorectal cancer (1.80 million cases)\n"
                      "   4. Prostate cancer (1.28 million cases)\n"
                      "   5. Skin cancer (non-melanoma) (1.04 million cases)\n"
                      "   6. Stomach cancer (1.03 million cases)",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  )),
                ),
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
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          'Causes of Cancer?',
                          style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.outfit().fontFamily),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          index == 3 ? index = 0 : index = 3;
                        }),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (index == 3)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Carcinogenesis is the development of cancer and the substances causing cancer are referred to as carcinogens. "
                        "The external agents responsible for cancer are categorized as-\n"
                        "   1. Physical carcinogens- radiation such as X-ray, UV-ray which causes chromosomal breakage, DNA alterations.\n"
                        "   2. Chemical carcinogens- ethidium bromide, asbestos, arsenic, components of tobacco smoke etc. Tobacco use is the most important risk factor comprising 22% deaths.\n"
                        "   3. Biological carcinogens- infections from certain viruses, bacteria and parasites. Viral infections including papillomavirus, hepatitis-B & C virus, Epstein- Barr virus, HIV and others are responsible for one-fourth death cases.\n\n"
                        "Other risk factors are-\n"
                        "   Obesity\n"
                        "   Poor diet\n"
                        "   Lack of exercise\n"
                        "   Excessive drinking\n"
                        "   Several disease complications\n"
                        "   Epigenetic change\n"
                        "   Heredity or family history of genetic defects (5-10% cases).\n\n"
                        "Not a single cause accounts for the development of cancer, rather it is a multistep process where multiple factors contribute to its progression.\n"
                        "Diagnosis is important to understand the specific type of cancer so that the treatment becomes easier and lives can be saved. "
                        "Laboratory test (blood test, urine/feces test), endoscopy (visual examination of the interior of a hollow body organ), tumor biopsy (physical examination of tissue or body fluid) and imaging are performed to diagnose cancer.",
                        style: TextStyle(color: Colors.black54),
                      )),
                ),
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
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          'Statistics',
                          style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.outfit().fontFamily),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          index == 4 ? index = 0 : index = 4;
                        }),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (index == 4)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Deaths: \n"
                        "Scenario: \n"
                        "Worldwide: \n"
                        "Bangladesh: \n",
                        style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.outfit().fontFamily),
                      ),
                    ),
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
