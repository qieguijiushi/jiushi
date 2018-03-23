**********************************************************
**By ZhouQian

**Objective: to clean the raw facility form data survey

***********************************************************

clear
set more off
capture more off

cd "C:\Users\qq630068828\Desktop\CEEE\眼镜SP"

**Input the raw data
import excel "C:\Users\qq630068828\Desktop\CEEE\眼镜SP\Esp_ins_2018.xlsx", clear
save Esp_ins_2018.dta, replace

use Esp_ins_2018.dta,clear

**delete the variables which is not needed
   drop D E F



**rename the variables and add label
	rename A faci_order
	rename B faci_time1
	rename C faci_time2
	rename G faci_enumerator
	rename H faci_check
	rename I faci_date
	rename J faci_id
	rename K faci_county
	rename L faci_facility
	rename M faci_telphone
	rename N faci_1
	rename O faci_2
	rename P faci_3
	rename Q faci_4
	rename R faci_5
	rename S faci_6
	rename T faci_7
	rename U faci_8
	rename V faci_9
	rename W faci_10
	rename X faci_11
	rename Y faci_12
	rename Z faci_13
	rename AA faci_14
	rename AB faci_15
	rename AC faci_16
	rename AD faci_17
	rename AE faci_18
	rename AF faci_19
	rename AG faci_20
	rename AH faci_21
	rename AI faci_22
	rename AJ faci_23
	rename AK faci_24
	rename AL faci_25
	rename AM faci_26
	rename AN faci_27
	rename AO faci_28
	rename AP faci_29
	rename AQ faci_30
	rename AR faci_31
	rename AS faci_32
	rename AT faci_comment

    label var faci_order"序号"
	label var faci_time1"提交答卷时间"
	label var faci_time2"所用时间"
	label var faci_enumerator"调查员"
	label var faci_check"核查员"
	label var faci_date"调研日期"
	label var faci_id"问卷编码（6位数）"
	label var faci_county"请选择省份城市与地区:"
	label var faci_facility"机构名称"
	label var faci_telphone"机构联系方式"
	label var faci_1"1.贵店/科室是否与其他眼镜店或医院有合作关系？"
	label var faci_2"2.贵店/科室是从哪一年开始营业的？年"
	label var faci_3"3.最近的其他眼镜店或眼科有多远？公里"
	label var faci_4"4.贵店/科室有多少名工作人员？"
	label var faci_5"5. 其中，眼科医生多少名？"
	label var faci_6"6. 可以验光的人员有多少名？"
	label var faci_7"7. 从事销售（或兼职）的人员有多少名？名"
	label var faci_8"8.贵店/眼科验光师（或负责验光的医生）平均月工资是多少？  元/月"
	label var faci_9"9.验光师（或负责验光的医生）的收入与眼镜销售情况有关联吗？"
	label var faci_10"10.如果有，验光师（或负责验光的医生）与眼镜销售相关的收入占总收入的比例是多少？ %"
	label var faci_11"11.最近一周，贵店/科室平均每位验光师（或负责验光的医生）每天为多少人次进行视力检查？   人次"
	label var faci_12"12.验光师（或负责验光的医生）平均每个工作日工作几个小时？  小时"
	label var faci_13"13.贵店/科室最有经验的验光师（或负责验光的医生）从事这一职业多长时间了？ 年"
	label var faci_14"14.贵店验光师（或负责验光的医生）中拥有的最高全日制学历是什么？"
	label var faci_15"15.贵店验光师（或负责验光的医生）中拥有的最高验光职业资格证书是什么？"
	label var faci_16"16.贵店验光师（或负责验光的医生）中平均月工资最高的是多少？ 元"
	label var faci_17"17.该验光师/医生的性别？"
	label var faci_18"18.该验光师/医生的年龄？ 岁"
	label var faci_19"19.该验光师/医生的全日制学历？"
	label var faci_20"20.该验光师/医生是否有验光职业资格证书？"
	label var faci_21"21.该验光师/医生的职称？"
	label var faci_22"22.该验光师/医生从事这一职业多长时间了？ 年"
	label var faci_23"23.2015年，该验光师/医生参加过多长时间的验光方面的培训？天"
	label var faci_24"24.该验光师/医生每月的平均收入有多少？ 元"
	label var faci_25"25.视力表（E表）"
	label var faci_26"26.焦度计"
	label var faci_27"27.验光镜片箱（主观验光用）"
	label var faci_28"28.瞳距尺"
	label var faci_29"29.自动验光仪"
	label var faci_30"30.磨边机"
	label var faci_31"31.裂隙灯"
	label var faci_32"32.电脑综合验光仪"
	label var faci_comment"特殊情况说明"
	
	**clean the variables

tab faci_order,mi
    duplicates report faci_order
	destring faci_order,replace

tab faci_enumerator,mi


**clean the ID

																																																																
tab faci_id
  *修改录入错误
replace faci_id="742104" if faci_id == "792104" & strpos(faci_facility,"波涛")!=0
replace faci_id="792202" if faci_id == "742202" & strpos(faci_facility,"视立美")!=0
replace faci_id="792301" if faci_id == "742301" & strpos(faci_facility,"林斐")!=0
replace faci_id="792403" if faci_id == "742403" & strpos(faci_facility,"医学配镜")!=0

     duplicates tag faci_id,gen(dupli_var)
	 tab dupli_var

  tostring faci_id,replace
  gen length= length(faci_id)  //length必须是对文本型数值
  tab length,mi
  list faci_id faci_enumerator faci_check if length==8
  replace faci_id="752104" if faci_id=="752104·" & faci_enumerator=="赵锦" & faci_check=="齐明艳"
 drop length
/**########################################

       MEERGE DATA
	   
###########################################*/



/**########################################

       CLEAN THE VARIABLES
	   
###########################################*/

* 1.修改表头

tab faci_county,mi
   
tab faci_facility,mi
	replace faci_facility = "理想眼镜" if faci_facility=="陕西省延安市子长县"	//l录入错误
	
	destring faci_id,replace
gen faci_public = int(faci_id/1000-int(faci_id/10000)*10)
    recode faci_public (2=0)
    tab faci_public,mi
	label var faci_public "public or not"
	
	
*2.修改问卷问题
			
forvalue num=1/32 {
   tostring faci_`num' ,replace
   }
   

   			
			
forvalue num=1/32 {
   replace faci_`num' = "." if faci_`num' == "(空)"|faci_`num' == "-2"
   }
   

   
tab faci_1,mi	

    replace faci_1="2" if faci_1=="-2"
	gen faci_1a=faci_1 if strpos(faci_1,"3")!=0
	destring faci_1,replace
	bysort faci_public: tab faci_1
   
	order faci_1a,after(faci_1)
    
tab faci_2,mi		
	destring faci_2 ,replace
		
tab faci_3,mi
    destring faci_3,replace

tab faci_4,mi	
	destring faci_4,replace
	bysort faci_public: tab faci_4,mi
	
tab faci_5,mi
	destring faci_5,replace  //再检查
	tab faci_5 if faci_public==0
	list faci_facility faci_5 faci_4 faci_id if faci_5 !=. & faci_5 >faci_4

tab faci_6,mi
	destring faci_6,replace
	list faci_facility faci_6 faci_4 faci_id if faci_6 !=. & faci_6 >faci_4
	
tab faci_7,mi
	destring faci_7,replace
	list faci_facility faci_7 faci_4 faci_id if faci_7 !=. & faci_7 >faci_4
	
tab faci_8,mi
	destring faci_8,replace
 
tab faci_9,mi	
tostring faci_9,replace
	destring faci_9,replace
	
tab faci_10,mi	
    replace faci_10 = "10" if faci_10 =="10%"
	replace faci_10 = "100" if faci_10 =="100%"
	replace faci_10 = "" if faci_10 =="999"
	destring faci_10,replace
	bysort faci_9 :tab faci_10,mi

tab faci_11,mi
    destring faci_11,replace
	
tab faci_12,mi
	destring faci_12,replace
	bysort faci_public: tab faci_12
	
**清理问卷第二部分

tab faci_13,mi
	destring faci_13,replace
	
tab faci_14,mi
	gen faci_14a=faci_14 if strpos(faci_14,"7")!=0
	destring faci_14,replace
	order faci_14a,after(faci_14)

tab faci_15,mi
	gen faci_15a=faci_15 if strpos(faci_15,"7")!=0
	destring faci_15,replace
	order faci_15a,after(faci_15)
	
tab faci_16,mi	
	destring faci_16,replace
	
tab faci_17,mi
	destring faci_17, replace
	
tab faci_18,mi
	destring faci_18 ,replace
	
tab faci_19,mi
	destring faci_19,replace

tab faci_20,mi
	destring faci_20,replace

tab faci_21,mi
	gen faci_21a=faci_21 if strpos(faci_21,"7")!=0
	destring faci_21,replace
	bysort faci_public:tab faci_21,mi
	order faci_21a,after(faci_21)
	
tab faci_22,mi
	destring faci_22, replace
	
tab faci_23,mi
	destring faci_23 ,replace
	*br if faci_23=="547.5" //???

tab faci_24,mi
	destring faci_24 ,replace
	
forvalue num=25/32 {
	destring faci_`num',replace
	recode faci_`num' (2=0)
	tab faci_`num',mi
	}	

**生成问卷是否完成的变量

gen completation=0

forvalue num=1/32 {
	replace completation = completation + 1 if missing( faci_`num') != 0
	}
	
	tab completation,mi
    
	gen res_done = 0 if completation ==31
	replace res_done = 1 if completation <31
	drop completation
	label var res_done "done or not"
	
	
	save Esp_ins_2018_clean.dta, replace

/**########################################

