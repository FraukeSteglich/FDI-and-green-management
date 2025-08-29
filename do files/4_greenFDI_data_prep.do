/*
Green gifts from abroad? FDI and firms' green management
Authors: Peter Kannen, Finn Ole Semrau, Frauke Steglich

Replication files for the accepted manuscript
Journal of International Business Policy

Data preparation
28.08.2025
*/

use "${data_path_prep}WBES_panel.dta", replace

********************************************************************************
*** Replace don`t know answers and generate dummy variables
foreach var in yrestablished owned_domestic fdi owned_gov owned_other sales exports certification sector ISIC employees _2009_ECAo3 _2013_h6 _2013_innov _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 ///
				_2019_h8 _2019_BMj4a _2019_BMj4b _2019_BMj4c _2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23a _2019_BMGc23b _2019_BMGc23c _2019_BMGc23d _2019_BMGc23e borrowed_bank borrowed_nonbank businessstrategy ///
				_2019_BMGc23f _2019_BMGc23g _2019_BMGc23h _2019_BMGc23i _2019_BMGc23j _2019_BMGd6 _2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2013_2019_h8 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2019_a7b a11 ///
				e1 _2019_BMl1a k30 m1a _2019_BMGb1 _2019_BMGb2 input_domestic  input_foreign  sales_national exports_indirec _2019_BMGa4  _2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8  _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11 { 
		replace `var'=. if `var'==-9 | `var'==-8  | `var'==-7
	}

	
	foreach var  in _2009_ECAo3 _2013_innov _2013_ECAr18 _2013_ECAr17c _2013_ECAr17b _2013_ECAr17a _2013_h6 _2019_BMGd6 _2019_BMGc22 _2019_BMGc23j _2019_BMGc23i _2019_BMGc23h ///
				_2019_BMGc23g _2019_BMGc23f _2019_BMGc23e _2019_BMGc23d _2019_BMGc23c _2019_BMGc23b _2019_BMGc23a _2019_BMGa2 _2019_BMGa1 _2019_h8 _2013_2019_h8 businessstrategy ///
				_2013_2019_BMh3 _2013_2019_BMh2 _2013_2019_BMh1 _2013_2019_h5 certification _2019_BMr2 _2019_BMGb1 _2019_BMGb2 _2019_BMGa4 _2019_a7b a11 a7 {
		replace `var'=0 if `var'==2
	}

	
**** Generate general management score	
	replace _2013_2019_BMr3=. if _2013_2019_BMr3==4
	replace _2013_2019_BMr3=0 if _2019_BMr2==0
	replace _2013_2019_BMr5=. if _2013_2019_BMr5==4
	replace _2013_2019_BMr9=. if _2013_2019_BMr9==5
	
	* What response best describes what happened in the company when a problem arose in its processes?
	replace _2013_2019_BMr1 = 0 	if  _2013_2019_BMr1 ==4
	replace _2013_2019_BMr1 = 0.33  if  _2013_2019_BMr1 ==1
	replace _2013_2019_BMr1 = 0.67	if  _2013_2019_BMr1 ==2
	replace _2013_2019_BMr1 = 1		if  _2013_2019_BMr1 ==3
		
		norm _2013_2019_BMr1,  method(mmx)
	rename mmx__2013_2019_BMr1 operations_mmx
		norm _2013_2019_BMr1,  method(zee)
	rename zee__2013_2019_BMr1 operations_z
		
	* Did This Establishment Monitor Any Production/Service Performance Indicators?  +  How many key performance indicators were monitored in the company? (_2019_BMr2 not necessary)
	replace _2013_2019_BMr3 = 0 	if  _2013_2019_BMr3 ==0
	replace _2013_2019_BMr3 = 0.33	if  _2013_2019_BMr3 ==1
	replace _2013_2019_BMr3 = 0.67	if  _2013_2019_BMr3 ==2
	replace _2013_2019_BMr3 = 1		if  _2013_2019_BMr3 ==3
		
		norm _2013_2019_BMr3,  method(mmx)
	rename mmx__2013_2019_BMr3 monitoring_mmx
		norm _2013_2019_BMr3,  method(zee)
	rename zee__2013_2019_BMr3 monitoring_z
		
	
	* Did this establishment have production targets?  +  What best describes the time frame of production targets at this establishment?
	replace _2013_2019_BMr5 = 0 	if _2019_BMr4==2 & _2013_2019_BMr5==.
	replace _2013_2019_BMr5 = 0.33	if _2013_2019_BMr5==1
	replace _2013_2019_BMr5 = 0.67	if _2013_2019_BMr5==2
	replace _2013_2019_BMr5 = 1		if _2013_2019_BMr5==3
			
		norm _2013_2019_BMr5,  method(mmx)
		norm _2013_2019_BMr5,  method(zee)
	

	* How easy or difficult was it for this establishment to achieve its production targets overall?
	replace _2013_2019_BMr6 = 0		if _2013_2019_BMr6==6
	replace _2013_2019_BMr6 = 0.2	if _2013_2019_BMr6==5
	replace _2013_2019_BMr6 = 0.4	if _2013_2019_BMr6==4
	replace _2013_2019_BMr6 = 0.6	if _2013_2019_BMr6==2
	replace _2013_2019_BMr6 = 0.8	if _2013_2019_BMr6==3
	replace _2013_2019_BMr6 = 1		if _2013_2019_BMr6==1

		norm _2013_2019_BMr6,  method(mmx)
		norm _2013_2019_BMr6,  method(zee)

	* Who was aware of the production targets at this establishment?
	replace _2013_2019_BMr7 = 0		if _2013_2019_BMr7==1
	replace _2013_2019_BMr7 = 0.33	if _2013_2019_BMr7==2
	replace _2013_2019_BMr7 = 0.67	if _2013_2019_BMr7==3
	replace _2013_2019_BMr7 = 1		if _2013_2019_BMr7==4
	
		norm _2013_2019_BMr7,  method(mmx)
		norm _2013_2019_BMr7,  method(zee)
		
	egen targeting_mmx= rowtotal(mmx__2013_2019_BMr5  mmx__2013_2019_BMr6  mmx__2013_2019_BMr7) 
	egen targeting_z= rowtotal(zee__2013_2019_BMr5  zee__2013_2019_BMr6  zee__2013_2019_BMr7) 


	* What were the performance bonuses for managers based on?		
	replace _2013_2019_BMr9 = 0 	if _2019_BMr8==2 
	replace _2013_2019_BMr9 = 0.25	if _2013_2019_BMr9==4
	replace _2013_2019_BMr9 = 0.5	if _2013_2019_BMr9==3
	replace _2013_2019_BMr9 = 0.75	if _2013_2019_BMr9==2
	replace _2013_2019_BMr9 = 1		if _2013_2019_BMr9==1
		norm _2013_2019_BMr9,  method(mmx)
		norm _2013_2019_BMr9,  method(zee)
	
	
	* What were the criteria with which the non-managers were promoted in the company?		
	replace _2013_2019_BMr10 = 0	if _2013_2019_BMr10==4
	replace _2013_2019_BMr10 = 0.33 if _2013_2019_BMr10==3
	replace _2013_2019_BMr10 = 0.67 if _2013_2019_BMr10==2
	replace _2013_2019_BMr10 = 1	if _2013_2019_BMr10==1
	
		norm _2013_2019_BMr10,  method(mmx)
		norm _2013_2019_BMr10,  method(zee)
	

	* When a non-manager had a bad performance, was he or she reassigned or dismissed?	
	replace _2013_2019_BMr11 = 0	if _2013_2019_BMr11==3
	replace _2013_2019_BMr11 = 0.5	if _2013_2019_BMr11==2
	replace _2013_2019_BMr11 = 1	if _2013_2019_BMr11==1	
		norm _2013_2019_BMr11,  method(mmx)
		norm _2013_2019_BMr11,  method(zee)
	
	egen incentives_mmx= rowtotal(mmx__2013_2019_BMr9  mmx__2013_2019_BMr10  mmx__2013_2019_BMr11) 
	egen incentives_z= rowtotal(zee__2013_2019_BMr9  zee__2013_2019_BMr10  zee__2013_2019_BMr11) 
	
	egen countmissing_mmx = rmiss2(operations_mmx monitoring_mmx mmx__2013_2019_BMr5 mmx__2013_2019_BMr6 mmx__2013_2019_BMr7 mmx__2013_2019_BMr9 mmx__2013_2019_BMr10 mmx__2013_2019_BMr11)
	egen countmissing_z = rmiss2(operations_z monitoring_z zee__2013_2019_BMr5 zee__2013_2019_BMr6 zee__2013_2019_BMr7 zee__2013_2019_BMr9 zee__2013_2019_BMr10 zee__2013_2019_BMr11)		
		
	egen managementscore_mmx= rmean(operations_mmx monitoring_mmx mmx__2013_2019_BMr5 mmx__2013_2019_BMr6 mmx__2013_2019_BMr7 mmx__2013_2019_BMr9 mmx__2013_2019_BMr10 mmx__2013_2019_BMr11) if countmissing_mmx<=2
	egen managementscore_z= rmean(operations_z monitoring_z zee__2013_2019_BMr5 zee__2013_2019_BMr6 zee__2013_2019_BMr7 zee__2013_2019_BMr9 zee__2013_2019_BMr10 zee__2013_2019_BMr11) if countmissing_z<=2
	
	norm managementscore_mmx, method(mmx)
	norm managementscore_z, method(zee)
	drop  _2013_2019_BMr1 - _2013_2019_BMr11 _2019_BMr2 - _2019_BMr8    mmx__2013_2019_BMr5 - zee__2013_2019_BMr7    mmx__2013_2019_BMr9 - zee__2013_2019_BMr11 countmissing_mmx countmissing_z
	
	* Sector cleaning
	replace sector=29 if sector==30
	replace sector=31 if sector==32
	replace sector=34 if sector==35
	replace sector=60 if sector==61 | sector==62 | sector==63 | sector==64
	replace sector=15 if sector==12 
	 	
	replace certification=1 if certification==-6 // -6: still in process considered as yes
	
	drop *a4a /*Industry Sampling Sector*/
	
*** Generate variables
	gen age = year - yrestablished

	replace age = . if yrestablished == -9 | yrestablished == -7
	gen l_age = log(age)
		
	rename _2019_BMGa1 greenstrategy
	rename _2019_BMGa2 greenmanager
	rename _2019_BMGc22 managerevaluation
	
 
	gen green=0 if greenstrategy==0 & greenmanager==0
	replace green=1 if greenstrategy==1 | greenmanager==1

	rename a7 multiestabfirm
	rename _2019_a7b headquarterlocation
	rename a11 hqindependent
	
	gen managerreportto=.
	replace managerreportto=0 if _2019_BMGa3==3
	replace managerreportto=1 if _2019_BMGa3==2
	replace managerreportto=2 if _2019_BMGa3==1
	drop _2019_BMGa3
	
	replace fdi=0 if owned_domestic==100
	* FDI Dummies
	/* Definition of FDI: here >10 */
	gen fdidummy=1 if fdi>=10 & fdi!=. 				
	replace fdidummy=0 if fdidummy==. & fdi!=.
	
	/* Definition of FDI: here >50 */
	gen fdidummy50=1 if fdi>=50 & fdi!=. 				
	replace fdidummy50=0 if fdidummy50==. & fdi!=.
	
	
	// define ownership change as in Brucal & Javorcik:
	// less than 20% in 2013; more than 20% in 2019
	sort panelid time
	bys panelid: gen fo_change=0
	bys panelid: replace fo_change=1 if fdi>=50 & (fdi[_n-1]<50  ) & fdi!=.
	
	drop year
		
	gen owned_gov_dummy=1 if owned_gov>=50 & owned_gov!=. 				/* Definition of Owned by government: here =>50 */
	replace owned_gov_dummy=0 if owned_gov_dummy==. & owned_gov!=.
	
	gen exportdummy=1 if exports>0 & exports!=.
	replace exportdummy=0 if exports==0
	
	replace ISIC=1800 if ISIC==18	
	gen ISIC_3digit = int(ISIC/10)   
		
	gen adoptdummy=1 if _2019_BMGc23a==1 | _2019_BMGc23b==1 | _2019_BMGc23c==1 | _2019_BMGc23d==1 | _2019_BMGc23e==1 | _2019_BMGc23f==1 | _2019_BMGc23g==1 | _2019_BMGc23h==1 | _2019_BMGc23i==1 | _2019_BMGc23j==1
	replace adoptdummy=0 if adoptdummy==.
	replace adoptdummy=. if time==0 | time==1
	
	egen adoptordinal=rowtotal(_2019_BMGc23a _2019_BMGc23b _2019_BMGc23c _2019_BMGc23d _2019_BMGc23e _2019_BMGc23f _2019_BMGc23g _2019_BMGc23h _2019_BMGc23i _2019_BMGc23j), missing
		
	rename _2013_ECAr17a  _2013_con_skill_imp
	label var _2013_con_skill_imp "Consulting services: business skills improvements"
	
	rename _2013_ECAr17b _2013_con_process_imp 
	label var _2013_con_process_imp "Consulting services: business process improvements"
	
	rename _2013_ECAr17c _2013_con_sophist 
	label var _2013_con_sophist "Consulting services: more sophisticated projects"
	
	rename _2013_ECAr18 _2013_con_local 
	label var _2013_con_local "Any external consultants hired from local consulting firms"
	
	gen _13_19_resdevdummy=.
	replace _13_19_resdevdummy=_2019_h8 if time==2
	replace _13_19_resdevdummy=_2013_h6 if time==1
	
	replace _13_19_resdevdummy=1 if (_13_19_resdevdummy==. & (_2013_2019_BMh2==1 | _2013_2019_BMh3==1)) | (_13_19_resdevdummy==0 & (_2013_2019_BMh2==1 | _2013_2019_BMh3==1))
	replace _13_19_resdevdummy=0 if _13_19_resdevdummy!=1 & (_2013_2019_BMh2==0 & _2013_2019_BMh3==0)
	
	
	label var _13_19_resdevdummy "Spending on R&D"
	
	drop _2009_ECAo3 _2019_h8 _2013_h6 _2013_2019_BMh2 _2013_2019_BMh3    _2013_innov
	
	label define YesNo 0 "No" 1 "Yes"
	label value _2013_con_sophist _2013_con_process_imp _2013_con_skill_imp _2013_con_local _13_19_resdevdummy _2013_2019_BMh1 ///
			_2013_2019_h5 certification exportdummy fdidummy adoptdummy _2019_BMG* greenmanager greenstrategy managerevaluation YesNo
		
	
	gen international_comp = .
	replace international_comp = 0 if e1 == 1 | e1 ==2
	replace international_comp = 1 if e1 ==3
	label var international_comp "Main market for main product: International"
	
	rename _2019_BMl1a sh_high_skilled
	label var sh_high_skilled "share of FT emp with uni degree _2019_BMl1a"
	
	rename _2013_2019_BMh1 externalknowledge
	
	label var k30 "Access to finance as obstacle" 
	label var m1a "Biggest obstacle affecting operations"
	rename _2019_BMGb1 LossWeather
	rename _2019_BMGb2 LossPollution
	label var LossWeather "Losses: Extreme weather (D)"
	label var LossPollution "Losses: Pollution (D)"
	label var externalknowledge "External knowledge  (D)"

	gen sector_sections=.
		replace sector_sections=1 if sector<5
		replace sector_sections=2 if sector==5
		replace sector_sections=3 if sector>=10 & sector<=14
		replace sector_sections=4 if sector>=15 & sector<=37
		replace sector_sections=5 if sector==40 | sector==41
		replace sector_sections=6 if sector==45
		replace sector_sections=7 if sector>=50 & sector<=52
		replace sector_sections=8 if sector==55
		replace sector_sections=9 if sector>=60 & sector<=64
		replace sector_sections=10 if sector>=65 & sector<=67
		replace sector_sections=11 if sector>=70 & sector<=74
		replace sector_sections=12 if sector==75
		replace sector_sections=13 if sector==80
		replace sector_sections=14 if sector==85
		replace sector_sections=15 if sector>=90 & sector<=93
		replace sector_sections=16 if sector>=95 & sector<=97
		replace sector_sections=17 if sector==99


	** labour productivity
	gen l_employ=ln(employees)
		label var l_employ "log(Num. Permanent, Full-Time Employees At End of Last Fiscal Year)"


	* combine micro and small sized firms into a single category
	gen firmsize=.
		replace firmsize=0 if size==0 | size==1
		replace firmsize=1 if size==2
		replace firmsize=2 if size==3
	label var firmsize "Size categorial"
	label define fsize 0 "micro or small" 1 "medium" 2 "large"
	label value firmsize fsize 
	
save "${data_path_prep}WBES_panel_prep.dta", replace	


// codes taken from https://wits.worldbank.org/wits/wits/witshelp/content/codes/country_codes.htm
import excel "${data_path}CountryCodes.xlsx", firstrow clear 
save "${data_path}CountryCodes.dta", replace

use "${data_path_prep}WBES_panel_prep.dta", clear	
	
	decode countrycode, gen(countryname)
	
	// adjust spelling
	replace countryname = "Macedonia, FYR" if countryname == "Macedonia, FYR "
	replace countryname = "Egypt, Arab Rep." if countryname == "Egypt, Arab. Rep."
	format %30s countryname 

	merge m:1 countryname using "${data_path}CountryCodes.dta", force
	replace code_ISO3 = "ROU" if countryname=="Romania"

	
	// add manually: Serbia & Kosovo are missing in country code list
	replace code_ISO3 = "SRB" if countryname == "Serbia"
	replace code_ISO3 = "XKX" if countryname == "Kosovo"
	drop if _merge==2
	drop _merge
	
	rename countrycode countryWBES
	rename code_ISO3 countrycode
	
save "${data_path_prep}WBES_panel_prep.dta", replace

	
* Add GNI
	use "${data_path_prep}WBES_panel_prep.dta", clear
	sort countrycode time
	merge m:1 countrycode time using "${data_path_prep}macro_gni_panel.dta", force
	drop if _merge==2
	drop _merge
	sort panelid time
	order idstd panelid  time panel countryname countrycode
	drop if countryWBES ==.
	encode countrycode, gen(country)
	drop  country
	save "${data_path_prep}WBES_panel_prep.dta", replace
		
	
* Add exchange rate to standardize labour productivity in USD
	use "${data_path_prep}WBES_panel_prep.dta", clear
	sort countrycode time
	merge m:1 countrycode time using "${data_path_prep}macro_fx_panel.dta", force
	drop if _merge==2
	drop _merge
	sort panelid time
	order idstd panelid  time panel countryname countrycode
	drop if countryWBES ==.
	encode countrycode, gen(country) 
	
	gen sales_int=sales/fx

	drop fx_int  year eurofx eurofxtotal

	** labour productivity US$
	gen prod_int = sales_int/employees
	gen l_prod_int = log(prod_int)
		
	
	
* World Bank 2019 (https://datahelpdesk.worldbank.org/knowledgebase/articles/906519-world-bank-country-and-lending-groups)	
	gen classification=.
	replace classification=0 if gni_pcap <= 3995 & time==2
	replace classification=1 if gni_pcap > 3995 & gni_pcap <= 12375 & time==2
	replace classification=2 if gni_pcap > 12375 & time==2

	lab define classification 0 "lower-middle" 1 "upper-middle" 2 "high"
	lab value classification classification
	

* Merge EPI data
sort countrycode time
merge m:1 countrycode  using "${data_path_prep}epi.dta"
	drop if _merge==2
	drop _merge 
 
save "${data_path_prep}WBES_panel_prep.dta", replace


***********************************************************
	drop if fdidummy==.

*** Cluster standard errors at sector-country level
	gen sector_str = sector
	tostring sector_str, replace
	
	gen country_str = country
	tostring country_str, replace
	lab var country_str "Country dummy"
	
	gen sec_coun_str = sector_str+"_"+country_str
	encode sec_coun_str, gen(sec_coun)
	lab var sec_coun "Sector - country dummy"

	
* Environmental regulation
	tab _2019_BMGd6
	rename _2019_BMGd6 env_regulation
	lab var env_regulation "Environmental regulation"
	
	* Or is environmental regulation an obstacle
	tab _2019_BMj4c
	tab _2019_BMj4c, nolab
	gen env_regulation_obst = 1 if (_2019_BMj4c == 3 | _2019_BMj4c == 4) & _2019_BMj4c != .
	replace env_regulation_obst = 0 if (_2019_BMj4c == 0 | _2019_BMj4c == 1 | _2019_BMj4c == 2) & _2019_BMj4c != .

* Certificate desire	
	rename _2019_BMGa4 certificate_desire
	lab var certificate_desire "Env. certification required" 
	
* Lack of finance
	tab k30
	tab k30, nolab
	gen finance_obst = 1 if (k30 == 3 | k30 == 4) & k30 != .
	replace finance_obst = 0 if (k30 == 0 | k30 == 1 | k30 == 2) & k30 != .
	
* Variable lables
	lab var adoptdummy "EI adotpion"	
	lab var fdidummy "FDI dummy"
	lab var _13_19_resdevdummy "R\&D dummy"
	lab var l_prod_int "log(Labor productivity)"
	lab var firmsize "Size"
	lab var env_regulation_obst "Obstacle: Envi. regulation (D)"
	lab var exportdummy "Exporter dummy" 
	lab var l_age "log(Age)" 
	lab var greenstrategy "Strategy Environment/Climate Issues" 
	lab var greenmanager "Manager Environment/Climate Issues" 
	lab var _2019_BMGc23a "Heating & cooling improvements"
	lab var _2019_BMGc23b "More climate-friendly energy generation on site"
	lab var _2019_BMGc23c "Machinery upgrades"
	lab var _2019_BMGc23d "Energy management"
	lab var _2019_BMGc23e "Waste minimization"
	lab var _2019_BMGc23f "Air pollution control measures"
	lab var _2019_BMGc23g "Water management"
	lab var _2019_BMGc23h "Upgrades of vehicles etc."
	lab var _2019_BMGc23i "Improvement of lighting systems"
	lab var _2019_BMGc23j "Other pollution control measures"
	lab var _2019_BMj4c   "Environm. regulation obstacle"
	lab var fo_change "New foreign owner"
	

* EPI weighted FDI instock shares
merge m:1 countrycode using	"${data_path_prep}epi_home_fdi.dta"
drop _merge	


* panel definition
sort panelid time
xtset panelid time
keep if time==2	

drop if  countrycode=="XKX"   /* No EPI data for Kosovo */


* Gen Dummy for manufacturing and service sector
gen sectordummy=.
replace sectordummy=0 if sector<=37
replace sectordummy=1 if sector>37 & sector!=.

* Variable lables	
label define firmsize 1 "Medium-sized (D)" 2 "Large-sized (D)"
label values firmsize firmsize

lab var fdidummy50 "FDI (D)"
lab var exportdummy "Exporter (D)"
lab var _13_19_resdevdummy "R\&D (D)"
lab var l_prod_int "log(Labor productivity)"
lab var externalknowledge "External knowledge (D)"
lab var finance_obst "Obstacle: Access finance (D)"
lab var env_regulation_obst "Obstacle: Env. regulation (D)"
lab var LossWeather "Losses: Extreme weather (D)"
lab var LossPollution "Losses: Pollution (D)"
lab var certificate_desire "Env. certification (D)"



save "${data_path_prep}WBES_panel_prep.dta", replace		
	
 
 
* Gen list of countries in sample
clear
input str22 country 
Croatia 
Albania 
"Egypt, Arab Rep." 
"Czech Republic" 
Armenia 
"Kyrgyz Republic" 
Estonia 
Azerbaijan 
Moldova 
Hungary
"Bosnia and Herzegovina" 
Mongolia 
Latvia 
Bulgaria
Morocco 
Lithuania 
Georgia 
Tajikistan 
Poland 
Kazakhstan 
Tunisia 
"Slovak Republic" 
Lebanon 
Ukraine 
Slovenia 
"Macedonia, FYR" 
Uzbekistan 
Romania 
"Russian Federation" 
Serbia
Turkey	 	
end

kountry country, from(other) marker stuck
rename _ISO3N_ ncountry
kountry ncountry, from(iso3n) to(iso3c) 
duplicates report ncountry
save "${data_path_prep}sample.dta", replace 

