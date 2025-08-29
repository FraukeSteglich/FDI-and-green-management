********************************************************************************
/*
Green gifts from abroad? FDI and firms' green management
Authors: Peter Kannen, Finn Ole Semrau, Frauke Steglich

Replication files for the accepted manuscript
Journal of International Business Policy

Baseline Analysis
28.08.2025
*/

*** Content
* 1) Baseline estimation by sectors
	* Table 1: Descriptives
	* Table 2: Baseline results
* 2) Host country characteristics: GNI split
	* Table 3: Total sample, split by income group
	* Figure 1: Marginal effects of FDI by GNI per capita
	* Figure A.3: Marginal effects of FDI by GNI per capita and sectors
* 3) Home country characteristics: EPI split
	* Table 4: Origin of FDI: Split by median share of EPI weighted FDI

********************************************************************************
cap log close
global sysdata=c(current_date)
log using "${log_path}analysis_baseline", replace
********************************************************************************

use "${data_path_prep}WBES_panel_prep.dta", clear

global controls2019 "i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy  l_prod_int  i.externalknowledge i.finance_obst i.env_regulation_obst  i.LossWeather i.LossPollution i.certificate_desire "   


***************************************
*** Table 1: Descriptive statistics by FDI status
***************************************
preserve	
logit greenstrategy $controls2019 i.sector i.country , vce(robust) 
keep if e(sample)	

tab firmsize, gen(size_)
label var size_1 "Small-sized"
label var size_2 "Medium-sized"
label var size_3 "Large-sized"	

// summary statistics
estpost summarize greenstrategy greenmanager   exportdummy size_1 size_2 size_3 _13_19_resdevdummy  l_prod_int  externalknowledge finance_obst env_regulation_obst LossWeather LossPollution  certificate_desire if fdidummy50==0
esttab using "${results_path}tables/Table_1.tex", cells("count mean sd") replace
estpost summarize greenstrategy greenmanager   exportdummy size_1 size_2 size_3 _13_19_resdevdummy  l_prod_int  externalknowledge finance_obst env_regulation_obst LossWeather LossPollution  certificate_desire if fdidummy50==1
esttab using "${results_path}tables/Table_1.tex", cells("count mean sd") append
restore

***************************************
* 1) Baseline estimation by sectors (Table 2)
***************************************

* Total sample	
	* green strategy
		logit greenstrategy $controls2019 i.sector i.country  , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_2.tex", replace  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy $controls2019 ) 

		
	* green manager	
		logit greenmanager $controls2019 i.sector i.country , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_2.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager $controls2019 ) 

		
* Manufacturing sample	
	* green strategy
		logit greenstrategy $controls2019 i.sector i.country if sectordummy==0 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_2.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, manufacturing)  dec(3) lab nocons  tex keep(greenstrategy $controls2019 ) 

		
	* green manager	
		logit greenmanager $controls2019 i.sector i.country if sectordummy==0 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_2.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, manufacturing)  dec(3) lab nocons  tex keep(greenmanager $controls2019 ) 
		
		
		
* Service sample	
	* green strategy
		logit greenstrategy $controls2019 i.sector i.country if sectordummy==1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_2.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, service )  dec(3) lab nocons  tex keep(greenstrategy $controls2019 ) 
		

	* green manager	
		logit greenmanager $controls2019 i.sector i.country if sectordummy==1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_2.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, service)  dec(3) lab nocons  tex keep(greenmanager $controls2019 ) 
		
		

***************************************		
* 2) Host country characteristics: GNI split (Table 3)
***************************************
* Total sample

capture erase "${results_path}tables\Table_3.tex"
capture erase "${results_path}tables\Table_3.txt"

levelsof classification, local(groups)
			foreach g of local groups {
			logit greenstrategy $controls2019  i.sector i.country if classification==`g' , vce(cluster sec_coun) 
			
			outreg2 using "${results_path}tables/Table_3.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, total sample, odds ratio, `g')  dec(3) lab nocons  tex keep(greenstrategy $controls2019 ) 
				}

levelsof classification, local(groups)
			foreach g of local groups {
			logit greenmanager $controls2019  i.sector i.country if classification==`g' , vce(cluster sec_coun) 
			outreg2 using "${results_path}tables/Table_3.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes)  ctitle(Green manager, total sample, odds ratio, `g')  dec(3) lab nocons  tex keep(greenmanager $controls2019 ) 			
			}
	

*** Margins plots by economic development
global controls2019x " i.exportdummy i.firmsize i._13_19_resdevdummy  l_prod_int  i.externalknowledge i.finance_obst i.env_regulation_obst  i.LossWeather i.LossPollution i.certificate_desire "   
	
gen gnipc=round(gni_pcap,1)


* total sample (Figure 1)
logit greenstrategy i.fdidummy50##c.gnipc $controls2019x i.sector i.country , vce(cluster sec_coun)
margins, dydx(fdidummy50) over(gnipc) saving("${results_path}margins1", replace)


logit greenmanager i.fdidummy50##c.gnipc $controls2019x i.sector i.country , vce(cluster sec_coun)
margins, dydx(fdidummy50) over(gnipc) saving("${results_path}margins2", replace)

preserve
use "${results_path}margins1", clear
rename (_margin _ci_lb _ci_ub _by1) (m1 lb1 ub1 x)

save "${results_path}ma1", replace

* Load margins2 and merge
use "${results_path}margins2", clear
rename (_margin _ci_lb _ci_ub _by1) (m2 lb2 ub2 x)

save "${results_path}ma2", replace

merge 1:1 x using "${results_path}ma1"

* Plot combined graph
twoway ///
    (rarea ub1 lb1 x, color(green%20)) ///
    (line m1 x, lcolor(green) lwidth(medthick)) ///
    (rarea ub2 lb2 x, color(blue%20)) ///
    (line m2 x, lcolor(blue) lwidth(medthick)) ///
    , ///
    xtitle("GNI per capita") ///
    ytitle("Effects on predictions") ///
    title("Average marginal effect of FDI, total sample") ///
    legend(order(2 "Green strategy" 4 "Green manager")) ///
    xlab(0(5000)25000, nogrid) ///
    tline(4045 12535) ///
    text(-0.04 1900 "LM") ///
    text(-0.04 8000 "UM") ///
    text(-0.04 19000 "H")
	
graph export "${results_path}/graphs/Figure_1.pdf", as(pdf) replace

 erase "${results_path}ma1.dta"
 erase "${results_path}ma2.dta"
 erase "${results_path}margins1.dta"
 erase "${results_path}margins2.dta"

restore


* manufacturing (Figure A.3a)
logit greenstrategy i.fdidummy50##c.gnipc $controls2019x i.sector i.country if sectordummy==0, vce(cluster sec_coun)
margins, dydx(fdidummy50) over(gnipc) saving("${results_path}margins1", replace)

logit greenmanager i.fdidummy50##c.gnipc $controls2019x i.sector i.country if sectordummy==0, vce(cluster sec_coun)
margins, dydx(fdidummy50) over(gnipc) saving("${results_path}margins2", replace)


* combine plots
preserve
use "${results_path}margins1", clear
rename (_margin _ci_lb _ci_ub _by1) (m1 lb1 ub1 x)
save "${results_path}ma1", replace

use "${results_path}margins2", clear
rename (_margin _ci_lb _ci_ub _by1) (m2 lb2 ub2 x)
save "${results_path}ma2", replace

merge 1:1 x using "${results_path}ma1"

twoway ///
    (rarea ub1 lb1 x, color(green%20)) ///
    (line m1 x, lcolor(green) lwidth(medthick)) ///
    (rarea ub2 lb2 x, color(blue%20)) ///
    (line m2 x, lcolor(blue) lwidth(medthick)) ///
    , ///
    xtitle("GNI per capita") ///
    ytitle("Effects on predictions") ///
    title("Average marginal effect of FDI") ///
    legend(order(2 "Green strategy" 4 "Green manager")) ///
    xlab(0(5000)25000, nogrid) ///
    tline(4045 12535) ///
    text(-0.04 1900 "LM") ///
    text(-0.04 8000 "UM") ///
    text(-0.04 19000 "H")
	
graph export "${results_path}/graphs/Figure_A.3a.pdf", as(pdf) replace

cap erase "${results_path}margins1.dta"
cap erase "${results_path}margins2.dta"
cap erase "${results_path}ma1.dta"
cap erase "${results_path}ma2.dta"
restore


* service (Figure A.3b)
logit greenstrategy i.fdidummy50##c.gnipc $controls2019x i.sector i.country if sectordummy==1, vce(cluster sec_coun)
margins, dydx(fdidummy50) over(gnipc) saving("${results_path}margins_serv_1", replace)

logit greenmanager i.fdidummy50##c.gnipc $controls2019x i.sector i.country if sectordummy==1, vce(cluster sec_coun)
margins, dydx(fdidummy50) over(gnipc) saving("${results_path}margins_serv_2", replace)

	
* combine plots
preserve
use "${results_path}margins_serv_1", clear
rename (_margin _ci_lb _ci_ub _by1) (m1 lb1 ub1 x)
save "${results_path}ma_serv_1", replace

use "${results_path}margins_serv_2", clear
rename (_margin _ci_lb _ci_ub _by1) (m2 lb2 ub2 x)
save "${results_path}ma_serv_2", replace

merge 1:1 x using "${results_path}ma_serv_1"
keep if _merge == 3

twoway ///
    (rarea ub1 lb1 x, color(green%20)) ///
    (line m1 x, lcolor(green) lwidth(medthick)) ///
    (rarea ub2 lb2 x, color(blue%20)) ///
    (line m2 x, lcolor(blue) lwidth(medthick))	///
    , ///
    xtitle("GNI per capita") ///
    ytitle("Effects on predictions") ///
    title("Average marginal effect of FDI") ///
    legend(order(2 "Green strategy" 4 "Green manager")) ///
    xlab(0(5000)25000, nogrid) ///
    tline(4045 12535) ///
    text(-0.04 1900 "LM") ///
    text(-0.04 8000 "UM") ///
    text(-0.04 19000 "H")
	
graph export "${results_path}/graphs/Figure_A.3b.pdf", as(pdf) replace

cap erase "${results_path}margins_serv_1.dta"
cap erase "${results_path}margins_serv_2.dta"
cap erase "${results_path}ma_serv_1.dta"
cap erase "${results_path}ma_serv_2.dta"	

restore


***************************************
*** 3) Home country characteristics: EPI split (Table 4)
***************************************
global controls2019 "i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy  l_prod_int  i.externalknowledge i.finance_obst i.env_regulation_obst  i.LossWeather i.LossPollution i.certificate_desire "   

gen epifdi2levels=.
replace epifdi2levels=0 if share_epifdi_totalfdi<=86.55283
replace epifdi2levels=1 if share_epifdi_totalfdi>86.55283 &  share_epifdi_totalfdi!=.

capture erase "${results_path}tables/Table_4.tex"	
capture erase "${results_path}tables/Table_4.txt"		
	
* If XKX (Kosovo) included:	86.39924	
	levelsof epifdi2levels, local(groups)
			foreach g of local groups {

* Total sample	
	* green strategy
		logit greenstrategy $controls2019 i.sector i.country if epifdi2levels==`g' , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_4.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample, source `g')  dec(3) lab nocons  tex keep(greenstrategy $controls2019 ) 

	* green manager	
		logit greenmanager $controls2019 i.sector i.country if epifdi2levels==`g', vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_4.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample, source `g')  dec(3) lab nocons  tex keep(greenmanager $controls2019 ) 	
	}	
/*
	Note that we report in the manuscript the country groups in the opposide order: Columns (1) and (2) refer to epifdi2levels == 1 
	and Columns (3) and (4) to epifdi2levels == 0 
*/
	
	
	
***********************************************************************************************	

cap log close	
	


	
	
	
	