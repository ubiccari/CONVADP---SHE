#ifndef __MODUL_2LSHE4A_H
#define __MODUL_2LSHE4A_H

#define __2LSHE4A_MAX_ANG__      4u
#define __2LSHE4A_DATA_NUM__     111
#define __2LSHE4A_VECT_NUM__     (4*__2LSHE4A_MAX_ANG__ + 1)
#define __2LSHE4A_INDMODMIN__    (F_32)   0.008660      //0.010000*_r3d2
#define __2LSHE4A_INDMODMAX__    (F_32)   0.961288      //1.110000*_r3d2
#define __2LSHE4A_STEP__         (F_32)   ((__2LSHE4A_INDMODMAX__-__2LSHE4A_INDMODMIN__)/(__2LSHE4A_DATA_NUM__-1))

#define __2LSHE4A_TABLE__   {/*rad*/\
            /*{Angle1 Angle2 Angle3 Angle4 }*/\
            {0.36455383, 0.68216075, 1.04886350, 1.40953182}, /**/\
            {0.36519942, 0.68115408, 1.05050927, 1.40787463}, /**/\
            {0.36573385, 0.68000439, 1.05213025, 1.40625943}, /**/\
            {0.36627760, 0.67893040, 1.05375814, 1.40459240}, /**/\
            {0.36685504, 0.67781701, 1.05537681, 1.40296315}, /**/\
            {0.36740926, 0.67675239, 1.05697714, 1.40132296}, /**/\
            {0.36794267, 0.67557314, 1.05859581, 1.39965804}, /**/\
            {0.36848187, 0.67443410, 1.06019261, 1.39800294}, /**/\
            {0.36900002, 0.67340828, 1.06184114, 1.39629132}, /**/\
            {0.36957394, 0.67209748, 1.06322914, 1.39463965}, /**/\
            {0.37003620, 0.67094779, 1.06493251, 1.39302018}, /**/\
            {0.37053572, 0.66976934, 1.06650478, 1.39135523}, /**/\
            {0.37102273, 0.66856156, 1.06804870, 1.38969245}, /**/\
            {0.37151237, 0.66736930, 1.06961397, 1.38801458}, /**/\
            {0.37200392, 0.66614816, 1.07115849, 1.38635338}, /**/\
            {0.37244917, 0.66486565, 1.07270513, 1.38467287}, /**/\
            {0.37290649, 0.66368034, 1.07421825, 1.38297311}, /**/\
            {0.37340875, 0.66236144, 1.07582960, 1.38141075}, /**/\
            {0.37379385, 0.66116198, 1.07726281, 1.37961664}, /**/\
            {0.37422350, 0.65988613, 1.07873782, 1.37793808}, /**/\
            {0.37460753, 0.65855226, 1.08025687, 1.37636700}, /**/\
            {0.37508201, 0.65731636, 1.08173517, 1.37453575}, /**/\
            {0.37549137, 0.65601944, 1.08317626, 1.37283389}, /**/\
            {0.37585333, 0.65466022, 1.08471292, 1.37113823}, /**/\
            {0.37625294, 0.65333569, 1.08623182, 1.36945161}, /**/\
            {0.37659618, 0.65199790, 1.08766690, 1.36769553}, /**/\
            {0.37703003, 0.65063999, 1.08902473, 1.36602871}, /**/\
            {0.37742035, 0.64924591, 1.09059161, 1.36435340}, /**/\
            {0.37764645, 0.64789367, 1.09188363, 1.36250900}, /**/\
            {0.37803154, 0.64646317, 1.09347301, 1.36083814}, /**/\
            {0.37830479, 0.64506556, 1.09485280, 1.35905421}, /**/\
            {0.37858877, 0.64365362, 1.09626619, 1.35731013}, /**/\
            {0.37897174, 0.64219811, 1.09760411, 1.35555264}, /**/\
            {0.37917213, 0.64076304, 1.09905327, 1.35381788}, /**/\
            {0.37943402, 0.63931304, 1.10047848, 1.35205410}, /**/\
            {0.37967807, 0.63782998, 1.10187697, 1.35032201}, /**/\
            {0.37993599, 0.63640907, 1.10327471, 1.34858575}, /**/\
            {0.38017262, 0.63484366, 1.10458675, 1.34674765}, /**/\
            {0.38036821, 0.63333711, 1.10595564, 1.34498248}, /**/\
            {0.38059124, 0.63181870, 1.10730620, 1.34317722}, /**/\
            {0.38076434, 0.63027197, 1.10864877, 1.34139817}, /**/\
            {0.38096151, 0.62871917, 1.10996901, 1.33958817}, /**/\
            {0.38123392, 0.62719762, 1.11127167, 1.33785335}, /**/\
            {0.38121701, 0.62563055, 1.11266855, 1.33610576}, /**/\
            {0.38139434, 0.62397715, 1.11390400, 1.33413192}, /**/\
            {0.38150296, 0.62235885, 1.11521183, 1.33230518}, /**/\
            {0.38161667, 0.62077257, 1.11645246, 1.33045943}, /**/\
            {0.38177687, 0.61908052, 1.11777839, 1.32850470}, /**/\
            {0.38181957, 0.61747682, 1.11899307, 1.32672951}, /**/\
            {0.38191082, 0.61580701, 1.12028031, 1.32495356}, /**/\
            {0.38189212, 0.61409572, 1.12147894, 1.32302185}, /**/\
            {0.38189540, 0.61241002, 1.12269881, 1.32108430}, /**/\
            {0.38196803, 0.61072878, 1.12398141, 1.31925443}, /**/\
            {0.38190759, 0.60893627, 1.12510272, 1.31724957}, /**/\
            {0.38188689, 0.60719498, 1.12635232, 1.31538194}, /**/\
            {0.38184476, 0.60543774, 1.12749348, 1.31344872}, /**/\
            {0.38177406, 0.60361370, 1.12860345, 1.31141197}, /**/\
            {0.38166339, 0.60181389, 1.12978346, 1.30949539}, /**/\
            {0.38158541, 0.59995914, 1.13090939, 1.30751132}, /**/\
            {0.38146770, 0.59817299, 1.13196279, 1.30544301}, /**/\
            {0.38136096, 0.59626128, 1.13319754, 1.30356229}, /**/\
            {0.38115395, 0.59446215, 1.13419882, 1.30151268}, /**/\
            {0.38097520, 0.59252022, 1.13515594, 1.29932064}, /**/\
            {0.38077242, 0.59061184, 1.13618377, 1.29725103}, /**/\
            {0.38053778, 0.58868402, 1.13724782, 1.29517479}, /**/\
            {0.38031409, 0.58675111, 1.13826673, 1.29315955}, /**/\
            {0.38000250, 0.58471828, 1.13915386, 1.29090111}, /**/\
            {0.37975663, 0.58273069, 1.14009015, 1.28879088}, /**/\
            {0.37945832, 0.58078583, 1.14102904, 1.28668626}, /**/\
            {0.37901853, 0.57862287, 1.14186820, 1.28429400}, /**/\
            {0.37864870, 0.57649238, 1.14282001, 1.28210194}, /**/\
            {0.37823530, 0.57445588, 1.14354815, 1.27975299}, /**/\
            {0.37779226, 0.57230808, 1.14438436, 1.27750209}, /**/\
            {0.37730144, 0.57021067, 1.14519634, 1.27529609}, /**/\
            {0.37685366, 0.56806542, 1.14580050, 1.27273234}, /**/\
            {0.37631030, 0.56578344, 1.14644805, 1.27025511}, /**/\
            {0.37576499, 0.56355634, 1.14704675, 1.26775069}, /**/\
            {0.37518043, 0.56128981, 1.14768291, 1.26528455}, /**/\
            {0.37447804, 0.55893623, 1.14823638, 1.26274445}, /**/\
            {0.37404461, 0.55682907, 1.14843737, 1.25989540}, /**/\
            {0.37318352, 0.55433319, 1.14898777, 1.25732208}, /**/\
            {0.37248568, 0.55192810, 1.14931480, 1.25450843}, /**/\
            {0.37169472, 0.54959891, 1.14976208, 1.25185889}, /**/\
            {0.37093788, 0.54704900, 1.14988518, 1.24899668}, /**/\
            {0.37008106, 0.54457723, 1.14998376, 1.24589906}, /**/\
            {0.36910220, 0.54210495, 1.14999132, 1.24281897}, /**/\
            {0.36818540, 0.53939879, 1.14976220, 1.23943985}, /**/\
            {0.36728828, 0.53677816, 1.14960552, 1.23613021}, /**/\
            {0.36618354, 0.53422740, 1.14942825, 1.23295382}, /**/\
            {0.36506971, 0.53138163, 1.14853842, 1.22899451}, /**/\
            {0.36394426, 0.52866115, 1.14778787, 1.22507239}, /**/\
            {0.36281112, 0.52580199, 1.14713242, 1.22125167}, /**/\
            {0.36164620, 0.52314440, 1.14599465, 1.21721788}, /**/\
            {0.36017992, 0.52006173, 1.14493580, 1.21298412}, /**/\
            {0.35881592, 0.51714963, 1.14306873, 1.20801270}, /**/\
            {0.35734861, 0.51411236, 1.14058531, 1.20251136}, /**/\
            {0.35575511, 0.51083759, 1.13885827, 1.19768497}, /**/\
            {0.35412154, 0.50764302, 1.13583641, 1.19157564}, /**/\
            {0.35229326, 0.50425248, 1.13162527, 1.18422819}, /**/\
            {0.35042989, 0.50088133, 1.12817029, 1.17777293}, /**/\
            {0.34843285, 0.49723597, 1.12265594, 1.16921080}, /**/\
            {0.34617606, 0.49348118, 1.11644658, 1.16002195}, /**/\
            {0.34380375, 0.48944665, 1.10884732, 1.14933885}, /**/\
            {0.34131026, 0.48546606, 1.09957644, 1.13720156}, /**/\
            {0.33839677, 0.48095353, 1.08810497, 1.12285560}, /**/\
            {0.33503314, 0.47596927, 1.07271844, 1.10468859}, /**/\
            {0.33103951, 0.47031907, 1.05184770, 1.08124726}, /**/\
            {0.32567030, 0.46321697, 1.02346336, 1.05044011}, /**/\
            {0.31805099, 0.45354904, 0.98049206, 1.00576918}, /**/\
            {0.30819056, 0.44143315, 0.93121652, 0.95576918}, /**/\
            {0.29685834, 0.42769119, 0.88121652, 0.90605919} /**/\
      }
#define __2LSHE4A_SIGN__   {1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1}
#endif //__MODUL_2LSHE4A_H