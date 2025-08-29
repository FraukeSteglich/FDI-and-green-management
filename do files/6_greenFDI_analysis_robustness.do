********************************************************************************
/*
FDI and firms' green management
Authors: Peter Kannen, Finn Ole Semrau, Frauke Steglich

Replication files for the accepted manuscript
Journal of International Business Policy

Robustness
28.08.2025
*/

*** Content
/*
* Robustness checks as in the paper
	* 1) Controlling for generic management practices
		* Figure 2: Green strategy and green manager by FDI and management score
		* Table 5: Controlling for generic management score
		* Table A.8: Controlling for generic management score with control variables
	* 2) Addressing reverse causality/IV
		* Table 6: IV approach: results
		* Table A.9: IV results with control variables
	* 3) Controlling for different classifications of foreign ownership
		* Table 7: Baseline with 10% and 100% FDI threshold
	* 4) Controlling for unobserved confounding factors
		* Table 8: Robustness, randomized FDI
*/
	
********************************************************************************
cap log close
global sysdata=c(current_date)
log using "${log_path}3_robustness", replace
********************************************************************************

use "${data_path_prep}WBES_panel_prep.dta", clear

* baseline controls
global controls2019 "i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy  l_prod_int  i.externalknowledge i.finance_obst i.env_regulation_obst  i.LossWeather i.LossPollution i.certificate_desire "   

* including management score
global controls2019m "i.fdidummy50 managementscore_z i.exportdummy i.firmsize i._13_19_resdevdummy  l_prod_int  i.externalknowledge i.finance_obst i.env_regulation_obst  i.LossWeather i.LossPollution i.certificate_desire " 

***************************************
* 1) Controlling for generic management practices
		* Figure 2: Green strategy and green manager by FDI and management score
		* Table 5: Controlling for generic management score
		* Table A.8: Controlling for generic management score with control variables
***************************************
* Gen ordinal variable for management score
	qui logit greenstrategy $controls2019 managementscore_z i.sector i.country  , vce(cluster sec_coun) 
	sum managementscore_z if e(sample), detail
	gen bar_sample_str = e(sample)
	

 * Generate quantiles directly (if not using percentiles from sum)
xtile managescoredummy = managementscore_z if bar_sample_str ==1, nq(4)
label define manageq 1 "Q1" 2 "Q2" 3 "Q3" 4 "Q4"
label values managescoredummy manageq

label define FDI 0 "no FDI" 1 "FDI"
label value fdidummy50 FDI

label define greenstrategy 0 "no green strategy" 1 "green strategy"
label value greenstrategy greenstrategy

label define greenmanager 0 "no green manager" 1 "green manager"
label value greenmanager greenmanager


graph dot (p10) managementscore_z (p50) managementscore_z (p90) managementscore_z if bar_sample_str ==1, ///
	over(fdidummy50)  over(greenstrategy)  legend( label (1 "p10") label (2 "Median") label (3 "p90") ) ///
	ascategory ///
	marker(1, mcolor(forest_green) msymbol(square) msize(medium)) ///
	marker(2, mcolor(green) msymbol(circle) msize(medium)) ///
	marker(3, mcolor(forest_green) msymbol(diamond) msize(medium)) ///
	ytitle("Management score (normalized)") ///
	name(gr1, replace)
graph export "${results_path}graphs/Figure_2a.pdf", as(pdf) replace


graph dot (p10) managementscore_z (p50) managementscore_z (p90) managementscore_z if bar_sample_str ==1, ///
over(fdidummy50) over(greenmanager) legend( label (1 "p10") label (2 "Median") label (3 "p90") ) ///
	ascategory ///
	marker(1, mcolor(forest_green) msymbol(square) msize(medium)) ///
	marker(2, mcolor(green) msymbol(circle) msize(medium)) ///
	marker(3, mcolor(forest_green) msymbol(diamond) msize(medium)) ///
	ytitle("Management score (normalized)") ///
	name(gr2, replace)
graph export "${results_path}graphs/Figure_2b.pdf", as(pdf) replace

 
graph combine gr1 gr2, col(1) iscale(1)
graph export "${results_path}graphs/Figure_2.pdf", as(pdf) replace


erase "${results_path}graphs/Figure_2a.pdf"
erase "${results_path}graphs/Figure_2b.pdf"  
  

*********************************
* Table 5 and A.8) Controlling for generic management practices
*********************************

* Total sample	
	* green strategy
		logit greenstrategy $controls2019m i.sector i.country  , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", replace eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy $controls2019m ) 
		
		logit greenstrategy $controls2019 i.sector i.country if e(sample) , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", append eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy $controls2019 ) 
		
	* green manager	
		logit greenmanager $controls2019m i.sector i.country , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", append eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager $controls2019m ) 
		
		logit greenmanager $controls2019 i.sector i.country if e(sample), vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", append eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager $controls2019 ) 
		
* Manufacturing sample	
	
	* green strategy
		logit greenstrategy $controls2019m i.sector i.country if sectordummy==0 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", append eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green strategy, odds ratio, manufacturing )  dec(3) lab nocons  tex keep(greenstrategy $controls2019m ) 
		
		logit greenstrategy $controls2019 i.sector i.country if e(sample) , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", append eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green strategy, odds ratio, manufacturing )  dec(3) lab nocons  tex keep(greenstrategy $controls2019 ) 
		
	* green manager	
		logit greenmanager $controls2019m i.sector i.country if sectordummy==0 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", append eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green manager, odds ratio, manufacturing )  dec(3) lab nocons  tex keep(greenmanager $controls2019m ) 
		
		logit greenmanager $controls2019 i.sector i.country if e(sample) , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", append eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green manager, odds ratio, manufacturing )  dec(3) lab nocons  tex keep(greenmanager $controls2019 ) 
		
* Service sample	
	
	* green strategy
		logit greenstrategy $controls2019m i.sector i.country if sectordummy==1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", append eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green strategy, odds ratio, service )  dec(3) lab nocons  tex keep(greenstrategy $controls2019m ) 
		
		logit greenstrategy $controls2019 i.sector i.country if e(sample) , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", append eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green strategy, odds ratio, service )  dec(3) lab nocons  tex keep(greenstrategy $controls2019 ) 
		
	* green manager	
		logit greenmanager $controls2019m i.sector i.country if sectordummy==1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", append eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green manager, odds ratio, service )  dec(3) lab nocons  tex keep(greenmanager $controls2019m ) 
		
		logit greenmanager $controls2019 i.sector i.country if e(sample) , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_5.tex", append eform  addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green manager, odds ratio, service )  dec(3) lab nocons  tex keep(greenmanager $controls2019 ) 
			

*********************************
* 2) Table 6 and A.9 - Controlling for reverse causality/IV
*********************************
rename _13_19_resdevdummy RandD
rename externalknowledge exknow
rename env_regulation_obst regenv
rename certificate_desire cert

global controls2019IV " exportdummy firmsize RandD  l_prod_int  exknow finance_obst regenv  LossWeather LossPollution cert "   

tab sector, gen(sec)
tab country, gen(c)

	
//Lewbel (2016) shows that the assumptions required for Lewbel's (2012) estimator can indeed be satisfied when an endogenous regressor is binary
	
* Total sample	
	* green strategy	
	ivreg2h greenstrategy $controls2019IV sec1-sec27 c1-c31 (fdidummy50=), robust cluster(sec_coun) first ffirst savefirst  savefprefix(fi_str_)
		// eret list
		outreg2 using "${results_path}tables/Table_6.tex", replace  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, IV, total sample)  ///
		addstat("Hansen J", e(j), "Hansen J p-value", e(jp), "Hansen J dof", e(jdf), "K-P rk LM test statistic", e(idstat), "K-P rk LM p-value", e(idp), "-P rk Wald F test", e(rkf))  /// 
		dec(3) lab nocons  tex keep(greenstrategy fdidummy50 $controls2019IV )  
		/*
		est restore fi_str_fdidummy50
		outreg2 using "${results_path}tables/Table_6_IVfirst.tex", replace  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, IV first, total sample, FDI (D))  addstat("Nbr clusters", e(N_clust)) dec(3) lab nocons  tex  //keep(greenstrategy fdidummy50 $controls2019 )  
		*/

	* green manager	
	ivreg2h greenmanager $controls2019IV sec1-sec27 c1-c31  (fdidummy50=), robust cluster(sec_coun) first ffirst savefirst  savefprefix(fi_man_)
		outreg2 using "${results_path}tables/Table_6.tex", append  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, IV, total sample) ///
		addstat("Hansen J", e(j), "Hansen J p-value", e(jp), "Hansen J dof", e(jdf), "K-P rk LM test statistic", e(idstat), "K-P rk LM p-value", e(idp), "-P rk Wald F test", e(rkf)) ///
		dec(3) lab nocons  tex keep(greenmanager fdidummy50 $controls2019IV ) 
	/*
		est restore fi_man_fdidummy50
		outreg2 using "${results_path}tables/Table_6_IVfirst.tex", append  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, IV first, total sample, FDI (D))  addstat("Nbr clusters", e(N_clust)) dec(3) lab nocons  tex  //keep(greenmanager fdidummy50 $controls2019 )  
	*/
	
	
	
* Manufacturing sample	
	preserve
	keep if sectordummy==0 
	* green strategy
		//logit greenstrategy $controls2019 i.sector i.country if sectordummy==0 , vce(cluster sec_coun) 
		ivreg2h greenstrategy $controls2019IV sec1-sec27 c1-c31 (fdidummy50=) , robust cluster(sec_coun) first ffirst savefirst  savefprefix(fi_str_m_)
		outreg2 using "${results_path}tables/Table_6.tex", append  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, IV, manufacturing) ///
		addstat("Hansen J", e(j), "Hansen J p-value", e(jp), "Hansen J dof", e(jdf), "K-P rk LM test statistic", e(idstat), "K-P rk LM p-value", e(idp), "-P rk Wald F test", e(rkf))  ///
		dec(3) lab nocons  tex keep(greenstrategy fdidummy50 $controls2019IV ) 
		/*
		est restore fi_str_m_fdidummy50
		outreg2 using "${results_path}tables/Table_6_IVfirst.tex", append  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, IV first, manufacturing, FDI (D))  addstat("Nbr clusters", e(N_clust)) dec(3) lab nocons  tex  //keep(greenstrategy fdidummy50 $controls2019 )
		*/
		
	* green manager	
		//logit greenmanager $controls2019 i.sector i.country if sectordummy==0 , vce(cluster sec_coun)
		ivreg2h greenmanager $controls2019IV sec1-sec27 c1-c31 (fdidummy50=), robust cluster(sec_coun) first ffirst savefirst  savefprefix(fi_man_m_)
		outreg2 using "${results_path}tables/Table_6.tex", append  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, IV, manufacturing) ///
		addstat("Hansen J", e(j), "Hansen J p-value", e(jp), "Hansen J dof", e(jdf), "K-P rk LM test statistic", e(idstat), "K-P rk LM p-value", e(idp), "-P rk Wald F test", e(rkf))  ///
		dec(3) lab nocons  tex keep(greenmanager fdidummy50 $controls2019IV ) 
	restore
		/*
		est restore fi_man_m_fdidummy50
		outreg2 using "${results_path}tables/Table_6_IVfirst.tex", append  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, IV first, manufacturing, FDI (D))  addstat("Nbr clusters", e(N_clust)) dec(3) lab nocons  tex  //keep(greenmanager fdidummy50 $controls2019 )
		*/
		
		
		
* Service sample	
	preserve
	keep if sectordummy==1
	* green strategy
		//logit greenstrategy $controls2019 i.sector i.country if sectordummy==1 , vce(cluster sec_coun) 
		ivreg2h greenstrategy $controls2019IV sec1-sec27 c1-c31 (fdidummy50=) , robust cluster(sec_coun) first ffirst savefirst  savefprefix(fi_str_s_)
		outreg2 using "${results_path}tables/Table_6.tex", append  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, IV, service) ///
			addstat("Hansen J", e(j), "Hansen J p-value", e(jp), "Hansen J dof", e(jdf), "K-P rk LM test statistic", e(idstat), "K-P rk LM p-value", e(idp), "-P rk Wald F test", e(rkf))  ///
			dec(3) lab nocons  tex keep(greenstrategy fdidummy50 $controls2019IV ) 
		/*
		est restore fi_str_s_fdidummy50
		outreg2 using "${results_path}tables/Table_6_IVfirst.tex", append  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, IV first, service, FDI (D))  ///
			addstat("Nbr clusters", e(N_clust)) dec(3) lab nocons  tex  //keep(greenstrategy fdidummy50 $controls2019 )
		*/
	* green manager	
		//logit greenmanager $controls2019 i.sector i.country if sectordummy==1 , vce(cluster sec_coun) 
		ivreg2h greenmanager $controls2019IV sec1-sec27 c1-c31 (fdidummy50=), robust cluster(sec_coun) first ffirst savefirst  savefprefix(fi_man_s_)
		outreg2 using "${results_path}tables/Table_6.tex", append  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, IV, service) ///
		addstat("Hansen J", e(j), "Hansen J p-value", e(jp), "Hansen J dof", e(jdf), "K-P rk LM test statistic", e(idstat), "K-P rk LM p-value", e(idp), "-P rk Wald F test", e(rkf))  ///
		dec(3) lab nocons  tex keep(greenmanager fdidummy50 $controls2019IV ) 
	restore
		/*
		est restore fi_man_s_fdidummy50
		outreg2 using "${results_path}tables/Table_6_IVfirst.tex", append  addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, IV first, service, FDI (D))  ///
			addstat("Nbr clusters", e(N_clust)) dec(3) lab nocons  tex  //keep(greenmanager fdidummy50 $controls2019 )
		*/
	

		



*********************************
* 3) Controlling for different classifications of foreign ownership
		* Table 7: Baseline with 10% and 100% FDI threshold
*********************************

use "${data_path_prep}WBES_panel_prep.dta", clear



		
*****************
* 10% FDI
*****************		
// Final set of controls for 10% fdi dummy	
global controls10 "i.fdidummy i.exportdummy i.firmsize i._13_19_resdevdummy  l_prod_int  i.externalknowledge i.finance_obst i.env_regulation_obst  i.LossWeather i.LossPollution i.certificate_desire "   


* Total sample	

	* green strategy
		logit greenstrategy $controls10 i.sector i.country  , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7a.tex", replace  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep( $controls10 ) 

		
	* green manager	
		logit greenmanager $controls10 i.sector i.country , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7a.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep( $controls10 ) 


		
* Manufacturing sample	
	
	* green strategy
		logit greenstrategy $controls10 i.sector i.country if sectordummy==0 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7a.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, manufacturing)  dec(3) lab nocons  tex keep( $controls10 ) 


			
	* green manager	
		logit greenmanager $controls10 i.sector i.country if sectordummy==0 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7a.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, manufacturing)  dec(3) lab nocons  tex keep( $controls10 ) 
		

		
* Service sample	
	
	* green strategy
		logit greenstrategy $controls10 i.sector i.country if sectordummy==1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7a.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, service )  dec(3) lab nocons  tex keep( $controls10 ) 
		

			
	* green manager	
		logit greenmanager $controls10 i.sector i.country if sectordummy==1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7a.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, service)  dec(3) lab nocons  tex keep( $controls10 ) 
		

			
	


*****************
* 100% FDI
*****************

gen fdi100=.		
replace fdi100=1 if fdi==100		
replace fdi100=0 if fdi<100 & fdi!=.		

global controls100 "i.fdi100 i.exportdummy i.firmsize i._13_19_resdevdummy  l_prod_int  i.externalknowledge i.finance_obst i.env_regulation_obst  i.LossWeather i.LossPollution i.certificate_desire "   


		

* Total sample	

	* green strategy
		logit greenstrategy $controls100 i.sector i.country  , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7b.tex", replace  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy $controls100 ) 

	* green manager	
		logit greenmanager $controls100 i.sector i.country , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7b.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager $controls100 ) 

* Manufacturing sample	
	
	* green strategy
		logit greenstrategy $controls100 i.sector i.country if sectordummy==0 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7b.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, manufacturing)  dec(3) lab nocons  tex keep(greenstrategy $controls100 ) 
	
	* green manager	
		logit greenmanager $controls100 i.sector i.country if sectordummy==0 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7b.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, manufacturing)  dec(3) lab nocons  tex keep(greenmanager $controls100 ) 

* Service sample	
	
	* green strategy
		logit greenstrategy $controls100 i.sector i.country if sectordummy==1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7b.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, service )  dec(3) lab nocons  tex keep(greenstrategy $controls100 ) 
	
	* green manager	
		logit greenmanager $controls100 i.sector i.country if sectordummy==1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_7b.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, service)  dec(3) lab nocons  tex keep(greenmanager $controls100 ) 

		
*********************************
* 4) Table 8 - Random assignment of FDI
*********************************

* Random assignment is not fixed - hence the numbers change slightly for every time the script is run

generate randomnr = .
bysort panelid: replace randomnr = cond(_n==1,uniform(),randomnr[1])

egen group=cut(randomnr), at(0.0,0.49,0.949, 1) 
gen randomfdi=1 if group>0 & group<=0.491
replace randomfdi=0 if randomfdi==.

global controls2019_r "i.randomfdi i.exportdummy i.firmsize i._13_19_resdevdummy  l_prod_int  i.externalknowledge i.env_regulation_obst  i.LossWeather i.LossPollution i.certificate_desire "     

	* green strategy
		logit greenstrategy $controls2019_r i.sector i.country  , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_8.tex", replace eform addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green strategy, odds ratio, randomized FDI)  dec(3) lab nocons  tex keep(greenstrategy $controls2019_r ) 

	* green manager
		logit greenmanager $controls2019_r i.sector i.country  , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_8.tex", append eform addtext(Sector FE, Yes, Country FE, Yes) addstat("Pseudo R$^2$", e(r2_p), "P-value for model test", e(p), "Log Pseudol.", e(ll)) ctitle(Green manager, odds ratio, randomized FDI)  dec(3) lab nocons  tex keep(greenmanager $controls2019_r ) 

	
	
cap log close
	
	