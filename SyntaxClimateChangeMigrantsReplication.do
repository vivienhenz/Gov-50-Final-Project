***Syntax Attitudes towards Climate Change Migrants***

**RECODING VARIABLES**

*Graphs 1 and 2 / Table 5 
*Dependent variable "Immigration acceptance" (0=no, 1=yes)
gen accept=0
recode accept (0=1) if v_4==1 | v_29==1 | v_30==1 | v_31==1 | v_32==1 | ///
v_33==1 | v_34==1 | v_35==1 | v_36==1 | v_37==1 | v_38==1 | ///
v_40==1 | v_41==1 | v_42==1 | v_43==1 | v_44==1 | v_45==1 | ///
v_46==1 | v_47==1 | v_48==1 | v_49==1 | v_50==1 | v_51==1 | v_52==1

*Vignette dimensions
*Reasons of migration (1=political, 2=economic, 3=droughts, 4=droughts/climate change, 5=sea level, 6=sea level/climate change)
gen reason=1
recode reason (1=2) if v_29>0 | v_35>0 | v_42>0 | v_48>0
recode reason (1=3) if v_30>0 | v_36>0 | v_43>0 | v_49>0
recode reason (1=4) if v_31>0 | v_37>0 | v_44>0 | v_50>0
recode reason (1=5) if v_32>0 | v_38>0 | v_45>0 | v_51>0
recode reason (1=6) if v_33>0 | v_40>0 | v_46>0 | v_52>0

*Alternative measures for environmental reasons for Table A6
gen reason2=1
recode reason2 (1=2) if v_29>0 | v_35>0 | v_42>0 | v_48>0
recode reason2 (1=3) if v_30>0 | v_36>0 | v_43>0 | v_49>0 | v_32>0 | v_38>0 | v_45>0 | v_51>0
recode reason2 (1=4) if v_32>0 | v_38>0 | v_45>0 | v_51>0 | v_33>0 | v_40>0 | v_46>0 | v_52>0

*Migrant characteristics
*Religion
gen muslim=0
recode muslim (0=1) if v_4>0 | v_29>0 | v_30>0 | v_31>0 | v_32>0 | ///
v_33>0 | v_40>0 | v_41>0 | v_42>0 | v_43>0 | v_44>0 | v_45>0
gen christian=muslim
recode christian (0=1) (1=0)

*Education (0=low educated, 1=high educated)
gen highedu=0
recode highedu (0=1) if v_4>0 | v_29>0 | v_30>0 | v_31>0 | v_32>0 | ///
v_33>0 | v_34>0 | v_35>0 | v_36>0 | v_37>0 | v_38>0 | v_40>0


**Graphs 3 und 4 / Table 7
*Dependent variable "Agreements with arguments" (1=fully yes, 2=partly yes, 3=partly no, 4=fully no)
gen agree=.
recode agree (.=4) if v_19==1 | v_20==1 | v_28==1 | v_22==1 | v_23==1 | v_24==1 
recode agree (.=3) if v_19==2 | v_20==2 | v_28==2 | v_22==2 | v_23==2 | v_24==2 
recode agree (.=2) if v_19==4 | v_20==4 | v_28==4 | v_22==4 | v_23==4 | v_24==4 
recode agree (.=1) if v_19==5 | v_20==5 | v_28==5 | v_22==5 | v_23==5 | v_24==5 

*Vignette dimensions
*Migration numbers (small=0, high=1)
gen impact=0
recode impact (0=1) if v_22>0 | v_23>0 | v_24>0

*Arguments (morality=0, corrective justice=1, capacity=2
gen argu=0
recode argu (0=1) if v_20>0 | v_23>0
recode argu (0=2) if v_28>0 | v_24>0


*Respondent characteristics
*Recoding environmental attitudes
gen v_6r=v_6
recode v_6r (0 5=.)
gen v_7r=v_7
recode v_7r (0 5=.)
gen v_8r=v_8
recode v_8r (0 5=.)

*Index environmentalism
alpha v_6r v_7r v_8r, gen(eco)

*Dichotomizatiion environmentalism (0=non-environmentalists, 1=environmentalists)
gen eco_dich=0
recode eco_dich (0=1) if eco>2.1

*High education
gen higheducation=0
recode higheducation (0=1) if inlist(v_3, 4, 6, 7, 8 )
gen higheducation2=0
recode higheducation2 (0=1) if inlist(v_3, 6, 7, 8 )

*Age
gen age=2018-v_2

*LeftRight
gen lire=v_67  
recode lire (0=.)
gen left=0
recode left (0=1) if lire<6
gen right=0
recode right (0=1) if lire>6

*Income
gen income=v_56
recode income (0=.)

**ANALYSES**

*Table A2: Descriptive statistics
sum accept agree eco higheducation

*Tables A3 and A4: Balance tests 
mean age income lire, over(reason)
mean age income lire, over(argu)
mean age income lire, over(impact)

*Table A5: Immigration acceptance 
logit accept ib2.reason christian highedu 
outreg2 using table_accept.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) replace
logit accept ib2.reason christian highedu  if higheducation==1
outreg2 using table_accept.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append
logit accept ib2.reason christian highedu  if higheducation==0
outreg2 using table_accept.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append
logit accept ib2.reason christian highedu  if eco<2.1
outreg2 using table_accept.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append
logit accept ib2.reason christian highedu  if eco>2.1
outreg2 using table_accept.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append

*Table A6: Immigration acceptance with alternative measure for climate change reasons 
logit accept ib2.reason2 christian highedu 
outreg2 using table_accept.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) replace
logit accept ib2.reason2 christian highedu  if higheducation==1
outreg2 using table_accept.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append
logit accept ib2.reason2 christian highedu  if higheducation==0
outreg2 using table_accept.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append
logit accept ib2.reason2 christian highedu  if eco<2.1
outreg2 using table_accept.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append
logit accept ib2.reason2 christian highedu  if eco>2.1
outreg2 using table_accept.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append

*Table A7: Justifications and self-interests
reg agree impact ib2.argu
outreg2 using table_agree.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) replace
reg agree impact ib2.argu if higheducation==1
outreg2 using table_agree.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append
reg agree impact ib2.argu if higheducation==0
outreg2 using table_agree.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append
reg agree impact ib2.argu if eco<2.1
outreg2 using table_agree.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append
reg agree impact ib2.argu if eco>2.1
outreg2 using table_agree.doc, dec(3) alpha(0.001, 0.01, 0.05, 0.1) symbol(***, **, *, °) append


