#ifndef __MODUL_2LSHE4A_H
#define __MODUL_2LSHE4A_H

#define __2LSHE4A_MAX_ANG__      4u
#define __2LSHE4A_DATA_NUM__     112
#define __2LSHE4A_VECT_NUM__     (4*__2LSHE4A_MAX_ANG__ + 1)
#define __2LSHE4A_INDMODMIN__    (F_32)   0.008660      //0.010000*_r3d2
#define __2LSHE4A_INDMODMAX__    (F_32)   0.969948      //1.120000*_r3d2
#define __2LSHE4A_STEP__         (F_32)   ((__2LSHE4A_INDMODMAX__-__2LSHE4A_INDMODMIN__)/(__2LSHE4A_DATA_NUM__-1))

#define __2LSHE4A_TABLE__   {/*rad*/\
            /*{Angle1 Angle2 Angle3 Angle4 }*/\
            {0.33321867, 0.71468189, 1.04582254, 1.38275796}, /**/\
            {0.33250319, 0.71588743, 1.04452133, 1.38459515}, /**/\
            {0.33189838, 0.71701197, 1.04314914, 1.38640856}, /**/\
            {0.33127213, 0.71821475, 1.04176240, 1.38814603}, /**/\
            {0.33064978, 0.71937948, 1.04036999, 1.38994898}, /**/\
            {0.33004216, 0.72061726, 1.03902404, 1.39181856}, /**/\
            {0.32939255, 0.72172939, 1.03770269, 1.39351083}, /**/\
            {0.32870599, 0.72282495, 1.03614422, 1.39528530}, /**/\
            {0.32808229, 0.72401356, 1.03482522, 1.39712667}, /**/\
            {0.32740959, 0.72508843, 1.03326528, 1.39872169}, /**/\
            {0.32670138, 0.72617029, 1.03186125, 1.40052929}, /**/\
            {0.32599994, 0.72729606, 1.03036827, 1.40228495}, /**/\
            {0.32535010, 0.72837377, 1.02893050, 1.40405760}, /**/\
            {0.32462773, 0.72950042, 1.02748795, 1.40581572}, /**/\
            {0.32397518, 0.73052452, 1.02596032, 1.40754722}, /**/\
            {0.32325935, 0.73160103, 1.02448213, 1.40924683}, /**/\
            {0.32257211, 0.73263196, 1.02295030, 1.41101976}, /**/\
            {0.32185973, 0.73367352, 1.02142731, 1.41275236}, /**/\
            {0.32112630, 0.73473671, 1.01989205, 1.41443927}, /**/\
            {0.32045776, 0.73563173, 1.01832090, 1.41607581}, /**/\
            {0.31968243, 0.73685870, 1.01684756, 1.41786562}, /**/\
            {0.31891732, 0.73773228, 1.01526812, 1.41961882}, /**/\
            {0.31819344, 0.73869145, 1.01374494, 1.42144127}, /**/\
            {0.31748946, 0.73967225, 1.01206838, 1.42306607}, /**/\
            {0.31673699, 0.74063946, 1.01046973, 1.42477985}, /**/\
            {0.31598640, 0.74156457, 1.00884142, 1.42646662}, /**/\
            {0.31523322, 0.74251088, 1.00723787, 1.42817365}, /**/\
            {0.31446218, 0.74343766, 1.00559658, 1.42988484}, /**/\
            {0.31367400, 0.74433996, 1.00395300, 1.43159012}, /**/\
            {0.31290766, 0.74524548, 1.00227878, 1.43327586}, /**/\
            {0.31218686, 0.74613675, 1.00062568, 1.43492112}, /**/\
            {0.31126748, 0.74705312, 0.99895560, 1.43666290}, /**/\
            {0.31058224, 0.74794787, 0.99724727, 1.43833423}, /**/\
            {0.30978419, 0.74870659, 0.99552278, 1.44003113}, /**/\
            {0.30897082, 0.74960479, 0.99369067, 1.44166123}, /**/\
            {0.30819978, 0.75037391, 0.99208093, 1.44338751}, /**/\
            {0.30736557, 0.75118714, 0.99029139, 1.44509509}, /**/\
            {0.30653334, 0.75194270, 0.98852114, 1.44675269}, /**/\
            {0.30569782, 0.75267499, 0.98672820, 1.44839232}, /**/\
            {0.30490748, 0.75353519, 0.98498559, 1.45013459}, /**/\
            {0.30402868, 0.75420707, 0.98306547, 1.45174815}, /**/\
            {0.30322430, 0.75500305, 0.98133292, 1.45337568}, /**/\
            {0.30239045, 0.75561196, 0.97944167, 1.45510824}, /**/\
            {0.30155829, 0.75630511, 0.97753489, 1.45679092}, /**/\
            {0.30069770, 0.75693384, 0.97565064, 1.45845735}, /**/\
            {0.29983320, 0.75757646, 0.97374347, 1.46012062}, /**/\
            {0.29897966, 0.75821299, 0.97183584, 1.46179188}, /**/\
            {0.29808673, 0.75891041, 0.96992402, 1.46340481}, /**/\
            {0.29724314, 0.75939033, 0.96792493, 1.46510132}, /**/\
            {0.29637329, 0.75996135, 0.96595038, 1.46676113}, /**/\
            {0.29546350, 0.76053182, 0.96396808, 1.46835305}, /**/\
            {0.29460959, 0.76108652, 0.96192840, 1.47000499}, /**/\
            {0.29371284, 0.76149736, 0.95985846, 1.47174304}, /**/\
            {0.29279329, 0.76200629, 0.95796061, 1.47332639}, /**/\
            {0.29190026, 0.76237674, 0.95566369, 1.47506540}, /**/\
            {0.29096825, 0.76286952, 0.95362366, 1.47671648}, /**/\
            {0.29004011, 0.76324001, 0.95153934, 1.47827786}, /**/\
            {0.28908628, 0.76359776, 0.94926115, 1.47992512}, /**/\
            {0.28820262, 0.76389048, 0.94703381, 1.48170568}, /**/\
            {0.28729202, 0.76416868, 0.94477174, 1.48335435}, /**/\
            {0.28634420, 0.76456417, 0.94265072, 1.48494043}, /**/\
            {0.28540751, 0.76465728, 0.94024825, 1.48664019}, /**/\
            {0.28444766, 0.76491248, 0.93797981, 1.48829373}, /**/\
            {0.28349011, 0.76500744, 0.93540362, 1.48991119}, /**/\
            {0.28262468, 0.76517702, 0.93318555, 1.49158598}, /**/\
            {0.28157515, 0.76516579, 0.93068494, 1.49324426}, /**/\
            {0.28061034, 0.76519614, 0.92819594, 1.49490519}, /**/\
            {0.27963197, 0.76518318, 0.92565555, 1.49655039}, /**/\
            {0.27861636, 0.76515529, 0.92313369, 1.49821800}, /**/\
            {0.27769638, 0.76506675, 0.92051357, 1.49984963}, /**/\
            {0.27658742, 0.76495182, 0.91786166, 1.50154568}, /**/\
            {0.27575766, 0.76469814, 0.91521862, 1.50313976}, /**/\
            {0.27461043, 0.76454592, 0.91253111, 1.50477880}, /**/\
            {0.27368809, 0.76417288, 0.90973276, 1.50644980}, /**/\
            {0.27257109, 0.76367569, 0.90670347, 1.50814884}, /**/\
            {0.27154017, 0.76337539, 0.90376535, 1.50978166}, /**/\
            {0.27041452, 0.76288465, 0.90099002, 1.51145422}, /**/\
            {0.26934315, 0.76220841, 0.89777863, 1.51312647}, /**/\
            {0.26839189, 0.76158079, 0.89475811, 1.51471718}, /**/\
            {0.26724114, 0.76082540, 0.89142448, 1.51650427}, /**/\
            {0.26619512, 0.75989381, 0.88819334, 1.51804245}, /**/\
            {0.26507449, 0.75913019, 0.88493363, 1.51979735}, /**/\
            {0.26391360, 0.75801051, 0.88131223, 1.52144345}, /**/\
            {0.26280915, 0.75680541, 0.87776007, 1.52308593}, /**/\
            {0.26168289, 0.75576112, 0.87433684, 1.52470875}, /**/\
            {0.26051064, 0.75438251, 0.87040445, 1.52640793}, /**/\
            {0.25938693, 0.75266969, 0.86635137, 1.52813036}, /**/\
            {0.25812338, 0.75127336, 0.86258358, 1.52978631}, /**/\
            {0.25703917, 0.74952955, 0.85835052, 1.53141029}, /**/\
            {0.25580339, 0.74756553, 0.85406023, 1.53305182}, /**/\
            {0.25448880, 0.74544246, 0.84963035, 1.53485338}, /**/\
            {0.25330103, 0.74308104, 0.84480306, 1.53657628}, /**/\
            {0.25200506, 0.74047237, 0.83998822, 1.53821488}, /**/\
            {0.25079621, 0.73786252, 0.83510900, 1.53992379}, /**/\
            {0.24942213, 0.73514114, 0.83010932, 1.54159895}, /**/\
            {0.24803950, 0.73189920, 0.82452387, 1.54327459}, /**/\
            {0.24657038, 0.72837624, 0.81881180, 1.54500115}, /**/\
            {0.24515767, 0.72451620, 0.81268069, 1.54675040}, /**/\
            {0.24368839, 0.72036209, 0.80636486, 1.54844338}, /**/\
            {0.24215774, 0.71584676, 0.79965912, 1.55018248}, /**/\
            {0.24060525, 0.71079334, 0.79252990, 1.55190198}, /**/\
            {0.23885500, 0.70575922, 0.78535677, 1.55363194}, /**/\
            {0.23723006, 0.70000592, 0.77762283, 1.55536596}, /**/\
            {0.23544291, 0.69335603, 0.76894857, 1.55714943}, /**/\
            {0.23342440, 0.68633204, 0.76001540, 1.55889395}, /**/\
            {0.23134778, 0.67797039, 0.74988283, 1.56070241}, /**/\
            {0.22920705, 0.66965174, 0.73985472, 1.56243608}, /**/\
            {0.22679061, 0.65979294, 0.72828365, 1.56428486}, /**/\
            {0.22422043, 0.64906844, 0.71619134, 1.56598991}, /**/\
            {0.22119828, 0.63667476, 0.70257888, 1.56786091}, /**/\
            {0.21795802, 0.62280067, 0.68768276, 1.56966803}, /**/\
            {0.21479952, 0.61010104, 0.67402074, 1.57079632} /**/\
      }
#define __2LSHE4A_SIGN__   {-1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1}
#endif //__MODUL_2LSHE4A_H