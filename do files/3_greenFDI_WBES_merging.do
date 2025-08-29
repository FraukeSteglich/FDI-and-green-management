/*
Green gifts from abroad? FDI and firms' green management
Authors: Peter Kannen, Finn Ole Semrau, Frauke Steglich

Replication files for the accepted manuscript
Journal of International Business Policy

WBES merging
28.08.2025
*/


********************************************************************************
*** Preparation of single WBES panel files
********************************************************************************  
  
* Albania    
use "${data_path}WBES/Albania_2009_2013_2019.dta", clear  
	
	keep idstd panelid panel a4a a4b year a6b a1 b2a b2b b2c b2d b6b b8 d1a2  d2  d3c l1 	_2009_ECAo3	///
	/*_2013_h6*/ _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///				
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6   _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	/*_2013_2019_h5*/ _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3  _2019_h5 _2013_h5  _2013_2019_k3bc _2013_2019_k3e   _2013_2019_h8	_2019_BMGa3	_2013_2019_BMr9	_2019_BMr2 _2013_2019_BMr3	///	
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3	///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11   _2019_a7b a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
	
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
	
	gen _2019_h8=.
	replace _2019_h8=_2013_2019_h8 if year==2019
	
	gen _2013_h6=.
	replace _2013_h6=_2013_2019_h8 if year==2013
	
	gen _2013_2019_h5=.
	replace _2013_2019_h5= _2013_h5 if year==2013
	replace _2013_2019_h5= _2019_h5 if year==2019
	
	drop _2019_h5 _2013_h5 _2013_2019_h8
	
	drop if panel==1 | panel==2 | panel==4
	
	save "${data_path_prep}Albania_panel.dta", replace


* Armenia    
use "${data_path}WBES/Armenia_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8 _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b	  _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy

	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
	
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
	
	drop if panel==1 | panel==2 | panel==4
	
	
	save "${data_path_prep}Armenia_panel.dta", replace

	
* Azerbaijan    
use "${data_path}WBES/Azerbaijan_2009_2013_2019.dta", clear  
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	/*_2013_h6*/ _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2013_2019_h8 _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
	
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
	
	
	gen _2019_h8=.
	replace _2019_h8=_2013_2019_h8 if year==2019
	
	gen _2013_h6=.
	replace _2013_h6=_2013_2019_h8 if year==2013
	
	
	drop if panel==1 | panel==2 | panel==4
	
	
	save "${data_path_prep}Azerbaijan_panel.dta", replace
		

* Bosnia and Herzegovina
use "${data_path}WBES/BosniaandHerzegovina_2009_2013_2019.dta", clear  
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	

	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy

	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
	
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	drop if panel==1 | panel==2 | panel==4
		
	save "${data_path_prep}BosniaHerzegovina_panel.dta", replace


* Bulgaria   
use "${data_path}WBES/Bulgaria_2009_2013_2019.dta", clear  
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy

	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
			
	drop if panel==1 | panel==2 | panel==4
	
	save "${data_path_prep}Bulgaria_panel.dta", replace


* Croatia
use "${data_path}WBES/Croatia_2009_2013_2019.dta", clear  
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy

	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Croatia_panel.dta", replace


* Czech Republic 
use "${data_path}WBES/Czech Republic_2009_2013_2019.dta", clear  
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	drop if panel==1 | panel==2 | panel==4
		
	save "${data_path_prep}CzechRepublic_panel.dta", replace


* Egypt
use "${data_path}WBES/Egypt_2004_2007_2008_2013_2016_2020.dta", clear  

	keep idstd panelid panel _2020_a4a _2016_a4a _2013_a4a _2020_a4b _2016_a4b _2013_a4b year _2013_2016_2020_a6b _2013_2016_2020_a1 _2008_2013_2016_2020_b2a _2008_2013_2016_2020_b2b _2008_2013_2016_2020_b2c _2008_2013_2016_2020_b2d _2013_2016_2020_b6b _2008_2013_2016_2020_b8 _2008_2013_2016_2020_d1a2 _2008_2013_2016_2020_d2 _2008_2013_2016_2020_d3c _2008_2013_2016_2020_l1 	///
	_2020_BMGa1 _2020_BMGa2 _2020_BMGc22 _2020_BMGc23* _2020_BMGd6 _2016_2020_h8  _2020_BMj4a _2020_BMj4b _2020_BMj4c  ///
	_2013_2016_2020_h5 _2020_BMh1 _2020_BMh2 _2020_BMh3 _2020_BMGa3 _2020_BMr9 _2020_BMr2 _2020_BMr3 _2008_2016_2020_k3bc _2008_2013_2016_2020_k3e _2020_BMb3 ///
	_2013_2016_2020_e1 _2020_BMl1a _2008_2013_2016_2020_k30 _2008_2013_2016_2020_m1a _2020_BMGb1 _2020_BMGb2 _2008_2013_2016_2020_d12a _2007_2008_2013_2016_2020_d12b _2008_2013_2016_2020_d3a _2008_2013_2016_2020_d3b _2020_BMGa4 ///
	_2020_BMr*  _2016_2020_a7b  _2013_2016_2020_a11  _2013_2016_2020_a7 _2013_2016_2020_a3
	
	drop if year<2013
	drop if panel==28 | panel==26 | panel==24  | panel==23  | panel==22  | panel==21  | panel==19  | panel==18 | panel==17  | panel==16  | panel==15 | panel==14  | panel==12  | panel==11  | panel==10  | panel==9  | panel==8 | panel==7 | panel==5  | panel==4  | panel==3  | panel==2  | panel==1
	
	replace panel=3 if panel==6 /*2020 only*/
	replace panel=6 if panel==30 /*2004-2007-2008-2013-2016-2020*/
	replace panel=6 if panel==29 /*2007-2008-2013-2016-2020*/
	replace panel=6 if panel==25 /*2008-2013-2016-2020*/
	replace panel=6 if panel==20 /*2013-2016-2020*/
	replace panel=5 if panel==13 /*2016-2020*/	
	
	label define panelvalue 6 "2009, 2013 and 2019" 5 "2013 and 2019 only" 3 "2019 only"
	label value panel panelvalue	
	
	rename _2020_a4b sector
	label var sector "two digit"
	replace sector=_2016_a4b if year==2016
	replace sector=_2013_a4b if year==2013
	replace sector = 15 if _2016_a4b == 10 
	drop _2016_a4b _2013_a4b
	
	rename _2013_2016_2020_a3 a3
	
	gen _2019_h8=.
	replace _2019_h8=_2016_2020_h8 if year==2020
	
	gen _2013_h6=.
	replace _2013_h6=_2016_2020_h8 if year==2016
	
	rename _2013_2016_2020_a7 a7
	rename _2013_2016_2020_a11 a11
	rename _2016_2020_a7b _2019_a7b
	rename _2013_2016_2020_a6b size
	rename _2013_2016_2020_a1 countrycode
	rename _2008_2013_2016_2020_b2a owned_domestic
	rename _2008_2013_2016_2020_b2b fdi
	rename _2008_2013_2016_2020_b2c owned_gov
	rename _2008_2013_2016_2020_b2d owned_other
	rename _2013_2016_2020_b6b yrestablished
	rename _2008_2013_2016_2020_b8 certification
	rename _2008_2013_2016_2020_d1a2 ISIC
	label var ISIC "four digit"
	rename _2008_2013_2016_2020_d2 sales
	rename _2008_2013_2016_2020_d3c exports
	rename _2008_2013_2016_2020_l1 employees
	rename _2020_BMb3 businessstrategy

	rename _2008_2013_2016_2020_d12a input_domestic
	rename _2007_2008_2013_2016_2020_d12b input_foreign
	rename _2008_2013_2016_2020_d3a sales_national
	rename _2008_2013_2016_2020_d3b exports_indirec
			
	rename _2020_BMh1 _2013_2019_BMh1
	rename _2020_BMh2 _2013_2019_BMh2
	rename _2020_BMh3 _2013_2019_BMh3
	rename _2013_2016_2020_h5 _2013_2019_h5
	rename _2020_BMj4a _2019_BMj4a 
	rename _2020_BMj4b _2019_BMj4b 
	rename _2020_BMj4c _2019_BMj4c
	rename _2020_BMGd6 _2019_BMGd6
	rename _2020_BMGc23a _2019_BMGc23a        
	rename _2020_BMGc23b _2019_BMGc23b
	rename _2020_BMGc23c _2019_BMGc23c
	rename _2020_BMGc23d _2019_BMGc23d
	rename _2020_BMGc23e _2019_BMGc23e
	rename _2020_BMGc23f _2019_BMGc23f
	rename _2020_BMGc23g _2019_BMGc23g
	rename _2020_BMGc23h _2019_BMGc23h
	rename _2020_BMGc23i _2019_BMGc23i
	rename _2020_BMGc23j _2019_BMGc23j
	rename _2020_BMGa2 _2019_BMGa2
	rename _2020_BMGa1 _2019_BMGa1
	rename _2020_BMGc22 _2019_BMGc22
	rename _2020_BMGa3 _2019_BMGa3
	rename _2013_2016_2020_e1 e1
	rename _2020_BMl1a _2019_BMl1a
	rename _2008_2013_2016_2020_k30 k30
	rename _2008_2013_2016_2020_m1a m1a
	rename _2020_BMGb1 	_2019_BMGb1 	
	rename _2020_BMGb2 _2019_BMGb2
	rename _2020_BMGa4 _2019_BMGa4
	
	rename _2008_2016_2020_k3bc borrowed_bank
	rename _2008_2013_2016_2020_k3e borrowed_nonbank
		
	rename _2020_BMr1	_2013_2019_BMr1 
	rename _2020_BMr3 _2013_2019_BMr3 
	rename _2020_BMr2 _2019_BMr2
	rename _2020_BMr4 _2019_BMr4
	rename _2020_BMr5 _2013_2019_BMr5 
	rename _2020_BMr6 _2013_2019_BMr6 
	rename _2020_BMr7 _2013_2019_BMr7 
	rename _2020_BMr9 _2013_2019_BMr9 
	rename _2020_BMr8 _2019_BMr8
	rename _2020_BMr10 _2013_2019_BMr10 
	rename _2020_BMr11 _2013_2019_BMr11

	save "${data_path_prep}Egypt_panel.dta", replace	
	
		
* Estonia 
use "${data_path}WBES/Estonia_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
						
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Estonia_panel.dta", replace		
		
	
* Georgia
use "${data_path}WBES/Georgia_2008_2013_2019.dta", clear  
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2008_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2008_ECAo3 _2009_ECAo3  
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
			
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Georgia_panel.dta", replace		
		
	
* Hungary
use "${data_path}WBES/Hungary_2009_2013_2019.dta", clear  
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 _2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
			
	drop if panel==1 | panel==2 | panel==4

		
	save "${data_path_prep}Hungary_panel.dta", replace
	
	
* Kazakhstan
use "${data_path}WBES/Kazakhstan_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
			
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
			
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Kazakhstan_panel.dta", replace
		

* Kosovo
use "${data_path}WBES/Kosovo_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 /// 
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy

	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Kosovo_panel.dta", replace


* Kyrgyz Republic
use "${data_path}WBES/Kyrgyz Republic_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy

	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Kyrgyz_panel.dta", replace
	
	
* Latvia
use "${data_path}WBES/Latvia_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 	_2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Latvia_panel.dta", replace		
	
	
* Lebanon    
use "${data_path}WBES/Lebanon_2013_2019.dta", clear  
	
	keep idstd panelid panel _2019_a4a _2013_a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	///
		_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6  h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	h5 	 BMh1 BMh2 BMh3 _2019_BMGa3 BMr9 _2019_BMr2 BMr3 k3bc k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
    BMr1 BMr10 BMr11 BMr3 BMr5 BMr6 BMr7 BMr9 _2019_BMr2 _2019_BMr4 _2019_BMr8	a7b  a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	gen a4a=.
	replace a4a= _2013_a4a if year==2013
	replace a4a= _2019_a4a if year==2019
	drop _2013_a4a _2019_a4a
	
	rename BMh1 _2013_2019_BMh1
	rename BMh2 _2013_2019_BMh2
	rename BMh3 _2013_2019_BMh3
	rename h5 _2013_2019_h5
	rename a7b _2019_a7b
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
	rename _2019_BMb3 businessstrategy
		
	gen _2019_h8=.
	replace _2019_h8=h8 if year==2019
	
	gen _2013_h6=.
	replace _2013_h6=h8 if year==2013
	
	rename BMr1	_2013_2019_BMr1 
	rename BMr3 _2013_2019_BMr3 
	rename BMr5 _2013_2019_BMr5 
	rename BMr6 _2013_2019_BMr6 
	rename BMr7 _2013_2019_BMr7 
	rename BMr9 _2013_2019_BMr9 
	rename BMr10 _2013_2019_BMr10 
	rename BMr11 _2013_2019_BMr11   
	
	replace panel=5 if panel==3
	replace panel=3 if panel==2
	drop if panel==1
	
	label define panelvalue  5 "2013 and 2019 only" 3 "2019 only"
	label value panel panelvalue
		
	rename k3bc borrowed_bank
	rename k3e borrowed_nonbank
		
	save "${data_path_prep}Lebanon_panel.dta", replace		
			

* Lithuania    
use "${data_path}WBES/Lithuania_2009_2013_2019.dta", clear  
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 _2009_ECAo3		///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3	_2013_2019_BMr9	_2019_BMr2 _2013_2019_BMr3	_2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
	
	drop if panel==1 | panel==2 | panel==4	
	
	save "${data_path_prep}Lithuania_panel.dta", replace
	
		
* Moldova
use "${data_path}WBES/Moldova_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 _2009_ECAo3		///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3	_2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
	
	drop if panel==1 | panel==2 | panel==4
	
	save "${data_path_prep}Moldova_panel.dta", replace


* Mongolia
use "${data_path}WBES/Mongolia_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a  _2019_a4b _2009_2013_a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 _2009_ECAo3		///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 	_2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename _2009_2013_a4b a4b
	replace a4b=_2019_a4b if year==2019			
	drop _2019_a4b
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
	
	drop if panel==1 | panel==2 | panel==4
	
	save "${data_path_prep}Mongolia_panel.dta", replace


* Morocco
use "${data_path}WBES/Morocco_2013_2019.dta", clear
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 ///
	 _2013_eligible_for_innovation	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 h8 _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	h5 BMh1 BMh2 BMh3 	_2019_BMGa3 BMr9 _2019_BMr2 BMr3  k3bc k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
    BMr1 BMr10 BMr11 BMr3 BMr5 BMr6 BMr7 BMr9 _2019_BMr2 _2019_BMr4 _2019_BMr8	a7b  a11 a7 a3
	
	rename _2013_eligible_for_innovation _2013_innov
	
	gen _2019_h8=.
	replace _2019_h8=h8 if year==2019
	
	gen _2013_h6=.
	replace _2013_h6=h8 if year==2013
	
	rename h5 _2013_2019_h5 
	rename BMh1 _2013_2019_BMh1
	rename BMh2 _2013_2019_BMh2
	rename BMh3 _2013_2019_BMh3
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
	rename a7b _2019_a7b	
	
	replace panel=5 if panel==3
	replace panel=3 if panel==2
	drop if panel==1
	label define panelvalue  5 "2013 and 2019 only" 3 "2019 only"
	label value panel panelvalue
	
	rename k3bc borrowed_bank
	rename k3e borrowed_nonbank
	
	rename BMr1	_2013_2019_BMr1 
	rename BMr3 _2013_2019_BMr3 
	rename BMr5 _2013_2019_BMr5 
	rename BMr6 _2013_2019_BMr6 
	rename BMr7 _2013_2019_BMr7 
	rename BMr9 _2013_2019_BMr9 
	rename BMr10 _2013_2019_BMr10 
	rename BMr11 _2013_2019_BMr11   

	save "${data_path_prep}Morocco_panel.dta", replace


* North Macedonia
use "${data_path}WBES/North Macedonia_2009_2013_2019.dta", clear  
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}NorthMacedonia_panel.dta", replace		
	
	
* Poland
use "${data_path}WBES/Poland_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3	_2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy

	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	drop if panel==1 | panel==2 | panel==4
	
	save "${data_path_prep}Poland_panel.dta", replace
	
	
* Romania
use "${data_path}WBES/Romania_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 	_2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy

	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	drop if panel==1 | panel==2 | panel==4
	
	save "${data_path_prep}Romania_panel.dta", replace
		

* Russia
use "${data_path}WBES/Russia_2009_2012_2019.dta", clear 
		
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 _2009_ECAo3		///
	_2012_h6 _2012_ECAr16a _2012_ECAr17a _2012_ECAr17b _2012_ECAr17c _2012_ECAr18 	_2012_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2012_2019_h5 _2012_2019_BMh1 _2012_2019_BMh2 _2012_2019_BMh3 	_2019_BMGa3 _2012_2019_BMr9 _2019_BMr2 _2012_2019_BMr3  _2012_2019_k3bc _2012_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2012_2019_BMr1 _2012_2019_BMr3 _2012_2019_BMr5 _2012_2019_BMr6 _2012_2019_BMr7 _2012_2019_BMr9 _2012_2019_BMr10 _2012_2019_BMr11 _2019_BMr2 _2019_BMr4 _2019_BMr8	 _2019_a7b a11 a7 a3
	
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
	rename _2019_BMb3 businessstrategy
		
	rename _2012_innov _2013_innov			
	rename _2012_h6 _2013_h6 				
	rename _2012_ECAr16a _2013_ECAr16a 	
	rename _2012_ECAr17a _2013_ECAr17a	
	rename _2012_ECAr17b _2013_ECAr17b		
	rename _2012_ECAr17c _2013_ECAr17c	
	rename _2012_ECAr18 _2013_ECAr18	
	rename _2012_2019_h5 _2013_2019_h5		
	rename _2012_2019_BMh1 _2013_2019_BMh1	
	rename _2012_2019_BMh2 _2013_2019_BMh2	
	rename _2012_2019_BMh3 _2013_2019_BMh3	
	
	label define panelvalue 6 "2009, 2013 and 2019" 5 "2013 and 2019 only" 3 "2019 only"
	label value panel panelvalue
		
	rename _2012_2019_k3bc borrowed_bank
	rename _2012_2019_k3e borrowed_nonbank
	rename _2012_2019_BMr1 _2013_2019_BMr1
	rename _2012_2019_BMr3 _2013_2019_BMr3
	rename _2012_2019_BMr5 _2013_2019_BMr5
	rename _2012_2019_BMr6 _2013_2019_BMr6
	rename _2012_2019_BMr7 _2013_2019_BMr7
	rename _2012_2019_BMr9 _2013_2019_BMr9
	rename _2012_2019_BMr10 _2013_2019_BMr10
	rename _2012_2019_BMr11 _2013_2019_BMr11
			             
	drop if panel==1 | panel==2 | panel==4
	
	save "${data_path_prep}Russia_panel.dta", replace	
	
	
* Serbia
use "${data_path}WBES/Serbia_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a  _2019_a4b _2009_2013_a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 _2009_ECAo3		///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 	_2019_BMGa3 _2013_2019_BMr9 _2013_2019_BMr3 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename _2009_2013_a4b a4b
	replace a4b=_2019_a4b if year==2019	
	drop _2019_a4b
	
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Serbia_panel.dta", replace		
	

* Slovakia
use "${data_path}WBES/Slovakia_2009_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2013_2019_BMr3 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Slovakia_panel.dta", replace		
		

* Slovenia
use "${data_path}WBES/Slovenia_2009_2013_2019.dta", clear  
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2009_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 _2019_BMGa3 _2013_2019_BMr9 _2013_2019_BMr3 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Slovenia_panel.dta", replace		
		
	
* Tajikistan 
use "${data_path}WBES/Tajikistan_2008_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2008_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 	_2019_BMGa3 _2013_2019_BMr9 _2013_2019_BMr3 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2008_ECAo3 _2009_ECAo3
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	label define panelvalue 6 "2009, 2013 and 2019" 5 "2013 and 2019 only" 3 "2019 only"
	label value panel panelvalue
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
			
	drop if panel==1 | panel==2 | panel==4
	
	save "${data_path_prep}Tajikistan_panel.dta", replace		
		

* Tunisia    
use "${data_path}WBES/Tunisia_2013_2020.dta", clear  
	
	keep idstd panelid panel  _2020_a4a _2013_a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	///
	_2020_BMGa1 _2020_BMGa2 _2020_BMGc22 _2020_BMGc23* _2020_BMGd6 /*_2019_h8*/ h8  _2020_BMj4a _2020_BMj4b _2020_BMj4c  ///
	 h5 BMh1 BMh2 BMh3 _2020_BMGa3 BMr9 BMr3 _2020_BMr2 k3bc k3e ///
	e1 _2020_BMl1a _2020_BMGb1 _2020_BMGb2 k30 m1a	 d12a d12b d3a d3b _2020_BMGa4 _2020_BMGa4 _2020_BMb3 ///
	BMr1 _2020_BMr2 BMr3 _2020_BMr4 BMr5 BMr6 BMr7 _2020_BMr8 BMr9 BMr10 BMr11  a7b  a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2020_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
	rename a7b _2019_a7b	
	gen a4a=.
	replace a4a= _2013_a4a if year==2013
	replace a4a= _2020_a4a if year==2020
	drop _2013_a4a _2020_a4a
	
	rename BMh1 _2013_2019_BMh1
	rename BMh2 _2013_2019_BMh2
	rename BMh3 _2013_2019_BMh3
	rename h5 _2013_2019_h5
	rename _2020_BMGa1 _2019_BMGa1
	rename _2020_BMGa2 _2019_BMGa2 
	rename _2020_BMGc22 _2019_BMGc22
	rename _2020_BMGc23a _2019_BMGc23a 
	rename _2020_BMGc23b _2019_BMGc23b
	rename _2020_BMGc23c _2019_BMGc23c
	rename _2020_BMGc23d _2019_BMGc23d
	rename _2020_BMGc23e _2019_BMGc23e
	rename _2020_BMGc23f _2019_BMGc23f
	rename _2020_BMGc23g _2019_BMGc23g
	rename _2020_BMGc23h _2019_BMGc23h
	rename _2020_BMGc23i _2019_BMGc23i
	rename _2020_BMGc23j _2019_BMGc23j
	rename _2020_BMGd6 _2019_BMGd6
	rename _2020_BMj4a _2019_BMj4a
	rename _2020_BMj4b _2019_BMj4b
	rename _2020_BMj4c _2019_BMj4c
	rename _2020_BMGa3 _2019_BMGa3
	rename _2020_BMl1a _2019_BMl1a
	rename _2020_BMGb1 _2019_BMGb1
	rename _2020_BMGb2 _2019_BMGb2
	
	rename _2020_BMGa4 _2019_BMGa4
	gen _2019_h8=.
	replace _2019_h8=h8 if year==2020
	replace panel=5 if panel==3
	replace panel=3 if panel==2
	drop if panel==1
	
	label define panelvalue  5 "2013 and 2019 only" 3 "2019 only"
	label value panel panelvalue
	
	rename k3bc borrowed_bank
	rename k3e borrowed_nonbank
		
	rename	BMr1  _2013_2019_BMr1        
	rename	_2020_BMr2	_2019_BMr2				             
	rename BMr3 _2013_2019_BMr3
	rename _2020_BMr4 _2019_BMr4
	rename BMr5 _2013_2019_BMr5
	rename BMr6 _2013_2019_BMr6
	rename BMr7 _2013_2019_BMr7
	rename _2020_BMr8 _2019_BMr8
	rename BMr9 _2013_2019_BMr9
	rename BMr10 _2013_2019_BMr10
	rename BMr11 _2013_2019_BMr11
	
	save "${data_path_prep}Tunisia_panel.dta", replace		
		
	
* Turkey
use "${data_path}WBES/Turkey_2008_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2008_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 	_2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	 
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2008_ECAo3 _2009_ECAo3 
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	
	label define panelvalue 6 "2009, 2013 and 2019" 5 "2013 and 2019 only" 3 "2019 only"
	label value panel panelvalue
	
	drop if panel==1 | panel==2 | panel==4
	
	save "${data_path_prep}Turkey_panel.dta", replace

	
* Ukraine    
use "${data_path}WBES/Ukraine_2008_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2008_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 	_2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
	
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2008_ECAo3 _2009_ECAo3 
	rename _2019_BMb3 businessstrategy
	
	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	label define panelvalue 6 "2009, 2013 and 2019" 5 "2013 and 2019 only" 3 "2019 only"
	label value panel panelvalue
	
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		

	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Ukraine_panel.dta", replace


* Uzbekistan
use "${data_path}WBES/Uzbekistan_2008_2013_2019.dta", clear 
	
	keep idstd panelid panel a4a a4b year a6b a1  b2a b2b b2c b2d b6b b8 d1a2 d2 d3c l1 	_2008_ECAo3	///
	_2013_h6 _2013_ECAr16a _2013_ECAr17a _2013_ECAr17b _2013_ECAr17c _2013_ECAr18 	_2013_innov	///
	_2019_BMGa1 _2019_BMGa2 _2019_BMGc22 _2019_BMGc23* _2019_BMGd6 _2019_h8  _2019_BMj4a _2019_BMj4b _2019_BMj4c  ///
	_2013_2019_h5 _2013_2019_BMh1 _2013_2019_BMh2 _2013_2019_BMh3 	_2019_BMGa3 _2013_2019_BMr9 _2019_BMr2 _2013_2019_BMr3 _2013_2019_k3bc _2013_2019_k3e ///
	e1 	_2019_BMl1a k30 m1a	_2019_BMGb1 _2019_BMGb2	d12a d12b d3a d3b _2019_BMGa4 _2019_BMb3 ///
	_2013_2019_BMr1 _2019_BMr2 _2013_2019_BMr3 _2019_BMr4 _2013_2019_BMr5 _2013_2019_BMr6 _2013_2019_BMr7 _2019_BMr8 _2013_2019_BMr9 _2013_2019_BMr10 _2013_2019_BMr11    _2019_a7b a11 a7 a3
		
	rename a4b sector
	label var sector "two digit"
	rename a6b size
	rename a1 countrycode
	rename b2a owned_domestic
	rename b2b fdi
	rename b2c owned_gov
	rename b2d owned_other
	rename b6b yrestablished
	rename b8 certification
	rename d1a2 ISIC
	label var ISIC "four digit"
	rename d2 sales
	rename d3c exports
	rename l1 employees
	rename _2008_ECAo3 _2009_ECAo3 
	rename _2019_BMb3 businessstrategy

	rename d12a input_domestic
	rename d12b input_foreign
	rename d3a sales_national
	rename d3b exports_indirec
		
	rename _2013_2019_k3bc borrowed_bank
	rename _2013_2019_k3e borrowed_nonbank
		
	label define panelvalue 6 "2009, 2013 and 2019" 5 "2013 and 2019 only" 3 "2019 only"
	label value panel panelvalue
	
	drop if panel==1 | panel==2 | panel==4

	save "${data_path_prep}Uzbekistan_panel.dta", replace			
	

********************************************************************************
*** Integrating single country files
********************************************************************************
use "${data_path_prep}BosniaHerzegovina_panel.dta", clear
	append using "${data_path_prep}Albania_panel.dta"
	append using "${data_path_prep}Armenia_panel.dta"
	append using "${data_path_prep}Azerbaijan_panel.dta"
	append using "${data_path_prep}Bulgaria_panel.dta"
	append using "${data_path_prep}Croatia_panel.dta"
	append using "${data_path_prep}CzechRepublic_panel.dta"
	append using "${data_path_prep}Egypt_panel.dta"
	append using "${data_path_prep}Estonia_panel.dta"
	append using "${data_path_prep}Georgia_panel.dta"
	append using "${data_path_prep}Hungary_panel.dta"
	append using "${data_path_prep}Kazakhstan_panel.dta"
	append using "${data_path_prep}Kosovo_panel.dta"
	append using "${data_path_prep}Kyrgyz_panel.dta"
	append using "${data_path_prep}Latvia_panel.dta"
	append using "${data_path_prep}Lithuania_panel.dta"
	append using "${data_path_prep}Lebanon_panel.dta"
	append using "${data_path_prep}Moldova_panel.dta"
	append using "${data_path_prep}Mongolia_panel.dta"
	append using "${data_path_prep}Morocco_panel.dta"
	append using "${data_path_prep}NorthMacedonia_panel.dta"
	append using "${data_path_prep}Poland_panel.dta"
	append using "${data_path_prep}Romania_panel.dta"
	append using "${data_path_prep}Russia_panel.dta"
	append using "${data_path_prep}Serbia_panel.dta"
	append using "${data_path_prep}Slovakia_panel.dta"
	append using "${data_path_prep}Slovenia_panel.dta"
	append using "${data_path_prep}Tajikistan_panel.dta"
	append using "${data_path_prep}Tunisia_panel.dta"
	append using "${data_path_prep}Turkey_panel.dta"
	append using "${data_path_prep}Ukraine_panel.dta"
	append using "${data_path_prep}Uzbekistan_panel.dta"

gen time=0
	replace time=1 if year>2009  & countrycode!=92
	replace time=2 if year>2013 & countrycode!=92
	replace time=1 if year==2016 & countrycode==92
	replace time=2 if year==2020 & countrycode==92

	
save "${data_path_prep}WBES_panel.dta", replace	
	
  



