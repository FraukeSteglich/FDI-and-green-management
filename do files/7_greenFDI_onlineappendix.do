********************************************************************************
/*
FDI and firms' green management
Authors: Peter Kannen, Finn Ole Semrau, Frauke Steglich

Replication files for the accepted manuscript
Journal of International Business Policy

Online Appendix
28.08.2025
*/

*** Content
* Descriptive statistics
	* Figure A.1: Growth in GDP per capita and CO2 emissions per capita-50
	* Table A.2: Cross-tabulation of green strategy and green manager	
	* Table A.3: Correlation matrix
	* Table A.4: Summary statistics of generic management score by FDI and firm size
	* Table A.5: Country coverage and Environmental Performance Index (EPI), 2020 and 2010
	* Figure A.2: Green strategy & green manager by FDI and income group
	* Figure A.3: Marginal effects of FDI by GNI per capita and sectors
	* Figure A.4: Green strategy & green manager by FDI and median share of EPI-weighted FDI
	* Table A.6: FDI instocks, FDI as percentage of GDP, and top 5 investor countries
	* Table A.7: Share of FDI firms by industries and FDI home country income classifications
	
* Robustness checks in the online appendix
	* Table A.10: Alternative measure of green management practices: Firms that have both green strategy and a green manager
	* Table A.11: Stepwise inclusion of control variables: Green strategy
	* Table A.12: Stepwise inclusion of control variables: Green manager
	* Table A.13: Replacing country fixed effects by the FDI host country's EPI
	
	
********************************************************************************
cap log close
global sysdata=c(current_date)
log using "${log_path}online_appendix", replace
********************************************************************************

use "${data_path_prep}WBES_panel_prep.dta", clear

* baseline controls
global controls2019 "i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy  l_prod_int  i.externalknowledge i.finance_obst i.env_regulation_obst  i.LossWeather i.LossPollution i.certificate_desire "   


***************************************
*** Figure A.1: Growth in GDP per capita and CO2 emissions per capita-50
***************************************

***********************************************
*** How was the environmental performance of these countries in the last years? 
***********************************************
** Carbon intensity: CO2 emissions per dollar of GDP
***********************************************
import excel using "${data_path}owid-co2-data.xlsx", clear firstrow
//keep if year == 2000 | year == 2005 | year == 2010 | year == 2015 | year == 2020
keep if year == 2010 | year == 2015 | year == 2020


* keep only our countries
rename iso_code _ISO3C_
merge m:1 _ISO3C_ using "${data_path_prep}sample.dta"
keep if _merge == 3 | country == "World"
drop _merge

* keep variables of interest
keep country year co2_per_gdp // share_global_co2
sort country year 

reshape wide co2_per_gdp , i(country) j(year)
rename co2_per_gdp2010 Y_2010
rename co2_per_gdp2015 Y_2015
rename co2_per_gdp2020 Y_2020

export excel using "${data_path_prep}owid-co2-data_tab1.xlsx", replace firstrow(variables)


** Illustrating the decoupling of growth and CO2 emissions
** Change in per capita CO₂ emissions and GDP
import delimited using "${data_path}co2-emissions-and-gdp-per-capita.csv", clear varnames(1)

* keep only our countries
rename code _ISO3C_
merge m:1 _ISO3C_ using "${data_path_prep}sample.dta"
keep if _merge == 3 
drop _merge ncountry MARKER

* keep variables of interest
keep entity year gdppercapitapppconstant2017inter annualcoemissionspercapita 
rename entity country
keep if year >=1995 & year != .

sort country year
by country: egen gdp_1995 = total(cond(year == 1995, gdppercapitapppconstant2017inter, .))
gen GDPchange = (gdppercapitapppconstant2017inter-gdp_1995)/gdp_1995*100

sort country year
by country: egen CO2_1995 = total(cond(year == 1995, annualcoemissionspercapita, .))
gen CO2change = (annualcoemissionspercapita-CO2_1995)/CO2_1995*100


* Illustrate the development for the groups HI, UMI, and LMI (two each)
encode country, gen(country_nbr)
xtset country_nbr year
keep country country_nbr year GDPchange CO2change

* High-income countries: Croatia, Estonia
preserve
keep if country == "Croatia"

twoway (line GDPchange year, lcolor(darkgreen) lwidth(medium)) ///
       (line CO2change year, lcolor(ltgreen) lwidth(medium) lpattern(dash)), ///
       legend(order(1 "GDP Change" 2 "CO2 Change") ///
              position(1) col(1) ring(0)) ///
       ytitle("Percentage Change (in %)") xtitle("Year") ///
       title("Croatia") ///
       subtitle("Changes in per capita GDP and CO2 emissions over time") ///
       xscale(range(1995 2025)) xlabel(1995(10)2025) yscale(range(-50 200)) ylabel(-50(50)200)
	   
graph export "${results_path}graphs\Figure_A1a_Croatia.pdf", replace
restore

preserve
keep if country == "Estonia"

twoway (line GDPchange year, lcolor(darkgreen) lwidth(medium)) ///
       (line CO2change year, lcolor(ltgreen) lwidth(medium) lpattern(dash)), ///
       legend(order(1 "GDP Change" 2 "CO2 Change") ///
              position(1) col(1) ring(0)) ///
       ytitle("Percentage Change (in %)") xtitle("Year") ///
       title("Estonia") ///
       subtitle("Changes in per capita GDP and CO2 emissions over time") ///
       xscale(range(1995 2025)) xlabel(1995(10)2025) yscale(range(-50 200)) ylabel(-50(50)200)

graph export "${results_path}graphs\Figure_A1b_Estonia.pdf", replace
restore

* Upper-Middle income countries: Albania and Georgia
preserve
keep if country == "Albania"

twoway (line GDPchange year, lcolor(darkgreen) lwidth(medium)) ///
       (line CO2change year, lcolor(ltgreen) lwidth(medium) lpattern(dash)), ///
       legend(order(1 "GDP Change" 2 "CO2 Change") ///
              position(1) col(1) ring(0)) ///
       ytitle("Percentage Change (in %)") xtitle("Year") ///
       title("Albania") ///
       subtitle("Changes in per capita GDP and CO2 emissions over time") ///
       xscale(range(1995 2025)) xlabel(1995(10)2025) yscale(range(-50 700)) ylabel(-50(100)700)

graph export "${results_path}graphs\Figure_A1c_Albania.pdf", replace
restore


preserve
keep if country == "Georgia"

twoway (line GDPchange year, lcolor(darkgreen) lwidth(medium)) ///
       (line CO2change year, lcolor(ltgreen) lwidth(medium) lpattern(dash)), ///
       legend(order(1 "GDP Change" 2 "CO2 Change") ///
              position(1) col(1) ring(0)) ///
       ytitle("Percentage Change (in %)") xtitle("Year") ///
       title("Georgia") ///
       subtitle("Changes in per capita GDP and CO2 emissions over time") ///
       xscale(range(1995 2025)) xlabel(1995(10)2025) yscale(range(-50 700)) ylabel(-50(100)700)

graph export "${results_path}graphs\Figure_A1d_Georgia.pdf", replace
restore


* Lower-Middle income countries: Kyrgyz and Morocco

preserve
keep if country == "Kyrgyzstan"

twoway (line GDPchange year, lcolor(darkgreen) lwidth(medium)) ///
       (line CO2change year, lcolor(ltgreen) lwidth(medium) lpattern(dash)), ///
       legend(order(1 "GDP Change" 2 "CO2 Change") ///
              position(1) col(1) ring(0)) ///
       ytitle("Percentage Change (in %)") xtitle("Year") ///
       title("Kyrgyzstan") ///
       subtitle("Changes in per capita GDP and CO2 emissions over time") ///
       xscale(range(1995 2025)) xlabel(1995(10)2025) yscale(range(-50 200)) ylabel(-50(50)200)

graph export "${results_path}graphs\Figure_A1e_Kyrgyzstan.pdf", replace
restore

preserve
keep if country == "Morocco"

twoway (line GDPchange year, lcolor(darkgreen) lwidth(medium)) ///
       (line CO2change year, lcolor(ltgreen) lwidth(medium) lpattern(dash)), ///
       legend(order(1 "GDP Change" 2 "CO2 Change") ///
              position(1) col(1) ring(0)) ///
       ytitle("Percentage Change (in %)") xtitle("Year") ///
       title("Morocco") ///
       subtitle("Changes in per capita GDP and CO2 emissions over time") ///
       xscale(range(1995 2025)) xlabel(1995(10)2025) yscale(range(-50 200)) ylabel(-50(50)200)

graph export "${results_path}graphs\Figure_A1f_Morocco.pdf", replace
restore



***************************************
*** Table A.2: Cross-tabulation of green strategy and green manager
***************************************
use "${data_path_prep}WBES_panel_prep.dta", clear
  
logit greenstrategy $controls2019 i.sector i.country  , vce(cluster sec_coun) 
keep if e(sample) ==1
 
tab greenstrategy greenmanager 
bys fdidummy50: tab greenstrategy greenmanager




***************************************
*** Table A.3: Correlation matrix
***************************************
use "${data_path_prep}WBES_panel_prep.dta", clear

logit greenstrategy i.fdidummy50  $controls2019 i.sector i.country  , vce(cluster sec_coun) 
gen sample_str = e(sample)

logit greenmanager i.fdidummy50  $controls2019 i.sector i.country  , vce(cluster sec_coun) 
gen sample_ma = e(sample)


* Correlation matrix
pwcorr greenstrategy greenmanager fdidummy50 exportdummy firmsize _13_19_resdevdummy  l_prod_int  externalknowledge finance_obst env_regulation_obst LossWeather LossPollution certificate_desire if sample_ma == 1

estpost corr greenstrategy greenmanager fdidummy50 exportdummy firmsize _13_19_resdevdummy l_prod_int externalknowledge finance_obst env_regulation_obst LossWeather LossPollution certificate_desire if sample_ma == 1, matrix
esttab . using "${results_path}tables/Table_A.3.tex", replace not unstack compress noobs ///
		nonumber nomtitles ///
         varlabels(greenstrategy "Green strategy" greenmanager "Green manager" fdidummy50 "FDI (D)" exportdummy "Exporter (D)" _13_19_resdevdummy "R\&D (D)" l_prod_int "log(Labor productivity)" ///
		 externalknowledge "External knowledge (D)" finance_obst "Obstacle: Access finance (D)" env_regulation_obst "Obstacle: Env. regulation (D)" LossWeather "Losses: Extreme weather (D)" LossPollution "Losses: Pollution (D)" certificate_desire "Env. certification (D)")   



***************************************
*** Table A.4: Summary statistics of generic management score by FDI and firm size
***************************************

tab firmsize, gen(size_)
label var size_1 "Small-sized"
label var size_2 "Medium-sized"
label var size_3 "Large-sized"


preserve
logit greenstrategy $controls2019 managementscore_z i.sector i.country , vce(robust) 
keep if e(sample)		

logit greenmanager $controls2019 managementscore_z i.sector i.country , vce(robust) 
keep if e(sample)		

// summary statistics MScore
estpost summarize greenstrategy greenmanager managementscore_z  if fdidummy50==0 & firmsize==1
esttab using "${results_path}tables/Table_A.4.tex", cells("count mean sd min max") replace
estpost summarize greenstrategy greenmanager managementscore_z  if fdidummy50==1 & firmsize==1
esttab using "${results_path}tables/Table_A.4.tex", cells("count mean sd min max") append
estpost summarize greenstrategy greenmanager managementscore_z  if fdidummy50==0 & firmsize==2
esttab using "${results_path}tables/Table_A.4.tex", cells("count mean sd min max") append
estpost summarize greenstrategy greenmanager managementscore_z  if fdidummy50==1 & firmsize==2
esttab using "${results_path}tables/Table_A.4.tex", cells("count mean sd min max") append

restore



***************************************
*** Table A.5: Country coverage and Environmental Performance Index (EPI), 2020 and 2010
***************************************
** Development of EPI
import excel using "${data_path}EPI_development.xlsx", clear firstrow sheet("2020")
save "${data_path}EPI_development_2020.dta", replace

import excel using "${data_path}EPI_development.xlsx", clear firstrow sheet("2016")
save "${data_path}EPI_development_2016.dta", replace

import excel using "${data_path}EPI_development.xlsx", clear firstrow sheet("2010")

merge 1:1 ISO3 using "${data_path}EPI_development_2016.dta"
drop _merge 
merge 1:1 ISO3 using "${data_path}EPI_development_2020.dta"
drop _merge 


kountry ISO3, from(iso3c) to(iso3n) 
rename _ISO3N_ ncountry

merge 1:1 ncountry using "${data_path_prep}sample.dta"
keep if _merge == 3
drop _merge

export excel using "${results_path}tables/Table_A.5.xlsx", firstrow(variable) sheet("joint generated in Stata", replace)

erase "${data_path}EPI_development_2020.dta"
erase "${data_path}EPI_development_2016.dta"







***************************************
*** Figure A.2: Green strategy & green manager by FDI and income group
***************************************
use "${data_path_prep}WBES_panel_prep.dta", clear



	preserve
	logit greenstrategy $controls2019  i.sector i.country , vce(robust) 
	keep if e(sample)

	sum greenstrategy if fdidummy50==0 & classification==0
	gen str_m0_nofdi=r(mean)*100
	sum greenstrategy if fdidummy50==1 & classification==0
	gen str_m0_fdi=r(mean)*100

	sum greenstrategy if fdidummy50==0 & classification==1
	gen str_m1_nofdi=r(mean)*100
	sum greenstrategy if fdidummy50==1 & classification==1
	gen str_m1_fdi=r(mean)*100

	sum greenstrategy if fdidummy50==0 & classification==2
	gen str_m2_nofdi=r(mean)*100
	sum greenstrategy if fdidummy50==1 & classification==2
	gen str_m2_fdi=r(mean)*100



	graph bar (mean) str_m0_nofdi (mean) str_m0_fdi (mean) str_m1_nofdi (mean) str_m1_fdi (mean) str_m2_nofdi (mean) str_m2_fdi , blabel(total, format(%12.2fc)) ///
	bar(1, fcolor( gray) fintensity(40)) bar(2, fcolor(green) fintensity(40)) bar(3, fcolor(gray) fintensity(70)) bar(4, fcolor(green) fintensity(70)) bar(5, fcolor(gray) fintensity(100)) ///
	bar(6, fcolor(green) fintensity(100))  nolabel legend(off) bargap(10) title( "Share of green strategy") ///
	text(1.5 10.5 "no FDI") text(1.5 26.5 "FDI")  text(1.5 42.5 "no FDI") text(1.5 58.5 "FDI") text(1.5 74 "no FDI") text(1.5 89.5 "FDI") ///
	text(-1.5 18.3 "|           LM income           ")  text( -1.5 48.3 " |           UM income        ") text( -1.5 81.7 "|             H income           |")  note("") caption(  " " " "  ) ylab(0(10)50, nogrid) ytitle("Percent")
 	graph export "${results_path}graphs/Figure_A.2a.pdf", as(pdf) replace

 
	restore


preserve
	logit greenmanager $controls2019  i.sector i.country , vce(robust) 
	keep if e(sample)

	sum greenmanager if fdidummy50==0 & classification==0
	gen str_m0_nofdi=r(mean)*100
	sum greenmanager if fdidummy50==1 & classification==0
	gen str_m0_fdi=r(mean)*100

	sum greenmanager if fdidummy50==0 & classification==1
	gen str_m1_nofdi=r(mean)*100
	sum greenmanager if fdidummy50==1 & classification==1
	gen str_m1_fdi=r(mean)*100

	sum greenmanager if fdidummy50==0 & classification==2
	gen str_m2_nofdi=r(mean)*100
	sum greenmanager if fdidummy50==1 & classification==2
	gen str_m2_fdi=r(mean)*100



	graph bar (mean) str_m0_nofdi (mean) str_m0_fdi (mean) str_m1_nofdi (mean) str_m1_fdi (mean) str_m2_nofdi (mean) str_m2_fdi , blabel(total, format(%12.2fc)) ///
	bar(1, fcolor( gray) fintensity(40)) bar(2, fcolor(green) fintensity(40)) bar(3, fcolor(gray) fintensity(70)) bar(4, fcolor(green) fintensity(70)) bar(5, fcolor(gray) fintensity(100)) ///
	bar(6, fcolor(green) fintensity(100))  nolabel legend(off) bargap(10) title( "Share of green manager") ///
	text(1.5 10.5 "no FDI") text(1.5 26.5 "FDI")  text(1.5 42.5 "no FDI") text(1.5 58.5 "FDI") text(1.5 74 "no FDI") text(1.5 89.5 "FDI") ///
	text(-1.5 18.3 "|           LM income           ")  text( -1.5 48.3 " |           UM income        ") text( -1.5 81.7 "|             H income           |")  note("") caption(  " " " "  ) ylab(0(10)50, nogrid) ytitle("Percent")
    graph export "${results_path}graphs/Figure_A.2b.pdf", as(pdf) replace
  
	restore








***************************************
*** Figure A.4: Green strategy & green manager by FDI and median share of EPI-weighted FDI
***************************************


* EPI weighted FDI

*duplicates drop countrycode share_greenfdi, force
gen epifdi2levels=.
replace epifdi2levels=0 if share_epifdi_totalfdi<=86.55283
replace epifdi2levels=1 if share_epifdi_totalfdi>86.55283 &  share_epifdi_totalfdi!=.

	
	

preserve
	logit greenstrategy $controls2019  i.sector i.country if epifdi2levels!=. , vce(robust) 
	keep if e(sample)

	sum greenstrategy if fdidummy50==0 & epifdi2levels==0
	gen str_m0_nofdi=r(mean)*100
	sum greenstrategy if fdidummy50==1 & epifdi2levels==0
	gen str_m0_fdi=r(mean)*100

	sum greenstrategy if fdidummy50==0 & epifdi2levels==1
	gen str_m1_nofdi=r(mean)*100
	sum greenstrategy if fdidummy50==1 & epifdi2levels==1
	gen str_m1_fdi=r(mean)*100



	graph bar (mean) str_m0_nofdi (mean) str_m0_fdi (mean) str_m1_nofdi (mean) str_m1_fdi  , blabel(total, format(%12.2fc)) ///
	bar(1, fcolor( gray) fintensity(100)) bar(2, fcolor(green) fintensity(100)) bar(3, fcolor(gray) fintensity(100)) bar(4, fcolor(green) fintensity(100)) nolabel legend(off) bargap(20) title( "Share of green strategy") ///
	text(1.5 14.5 "no FDI")  text( 1.5 38.5 "FDI") text(1.5 62.5 "no FDI")  text(1.5 86.5 "FDI")  ///
 	text(-1.5 25.5 "|                 below median               ")  text( -1.5 72.5 "  |                   above median                |")  note("") caption(  " " " " "By median share of EPI-weighted FDI" ) ylab(0(10)45, nogrid) ytitle("Percent")

	graph export "${results_path}graphs/Figure_A.4a.pdf", as(pdf) replace

 
	restore

	
preserve
	logit greenmanager $controls2019  i.sector i.country if epifdi2levels!=. , vce(robust) 
	keep if e(sample)

	sum greenmanager if fdidummy50==0 & epifdi2levels==0
	gen str_m0_nofdi=r(mean)*100
	sum greenmanager if fdidummy50==1 & epifdi2levels==0
	gen str_m0_fdi=r(mean)*100

	sum greenmanager if fdidummy50==0 & epifdi2levels==1
	gen str_m1_nofdi=r(mean)*100
	sum greenmanager if fdidummy50==1 & epifdi2levels==1
	gen str_m1_fdi=r(mean)*100



	graph bar (mean) str_m0_nofdi (mean) str_m0_fdi (mean) str_m1_nofdi (mean) str_m1_fdi  , blabel(total, format(%12.2fc)) ///
	bar(1, fcolor( gray) fintensity(100)) bar(2, fcolor(green) fintensity(100)) bar(3, fcolor(gray) fintensity(100)) bar(4, fcolor(green) fintensity(100)) nolabel legend(off) bargap(20) title( "Share of green manager") ///
	text(1.5 14.5 "no FDI")  text( 1.5 38.5 "FDI") text(1.5 62.5 "no FDI")  text(1.5 86.5 "FDI")  ///
 	text(-1.5 25.5 "|                 below median               ")  text( -1.5 72.5 "  |                   above median                |")  note("") caption(  " " " " "By median share of EPI-weighted FDI" ) ylab(0(10)40, nogrid) ytitle("Percent")
 	graph export "${results_path}graphs/Figure_A.4b.pdf", as(pdf) replace

 
	restore
	
		





***************************************
*** Table A.6: FDI instocks, FDI as percentage of GDP, and top 5 investor countries
***************************************


* Overall FDI instocks and top 5 investors by country
*use "${data_path}FDI_origin_sector/bilateral_fdi_instocks.dta", clear
*sort host3 year fdi_instocks

use "${data_path}bilateral_fdi_2019.dta", clear
rename sending_country_code source
gsort host_country_code  -fdi

drop if fdi<=0

* keep last reporting year (2019)
bys host_country: egen max_reporting = max(year)
keep if max_reporting == year
drop year max_reporting

gen ofc=0
replace ofc=1 if sending_country=="Bahamas" | sending_country=="Bermuda"  | sending_country=="Belize"  | sending_country=="British Virgin Islands"  | sending_country=="Hong Kong, China"  | ///
sending_country=="Liberia"  | sending_country=="Singapore" | sending_country=="Jersey" | sending_country=="Cayman Islands" | sending_country=="Gibraltar" |  sending_country=="Saint Kitts and Nevis" | ///
sending_country=="Seychelles" |  sending_country=="Liechtenstein" | sending_country=="Barbados" |  sending_country=="Guernsey" | sending_country=="Panama" | sending_country == "Virgin Islands (U.S.)"

drop if ofc == 1

* gen total FDI instocks
bys host_country: egen FDI_instock = total(fdi)


* keep top 5 investor countries
*bysort host_country_code: keep if _n<=10     /* 10 largest source countries*/
sort host_country fdi
kountry host_country_code, from(iso3c) to(iso3n) geo(undet)
rename _ISO3N_ ncountry
/*
gen host3_upper = ustrupper(host3)
kountry host3_upper, from(iso3c) to(iso3n) geo(undet)
rename _ISO3N_ ncountry
*/

merge m:1 ncountry using "${data_path_prep}sample.dta"
keep if _merge == 3 // no FDI data for Uzbekistan
drop _merge MARKER

bys host_country : egen rank = rank(-fdi)
sort host_country rank

drop if fdi == . 

* keep top 5 investor countries
keep if rank >= 1 & rank <= 5


* generate string variable with top 5 investor countries
*list source
rename source source_code
rename sending_country source
gen aux_1 = source if rank == 1
gen aux_2 = source if rank == 2
gen aux_3 = source if rank == 3
gen aux_4 = source if rank == 4
gen aux_5 = source if rank == 5

rename host_country host3
bysort host3 (aux_1) : replace aux_1 = aux_1[_N] if missing(aux_1) 
bysort host3 (aux_2) : replace aux_2 = aux_2[_N] if missing(aux_2) 
bysort host3 (aux_3) : replace aux_3 = aux_3[_N] if missing(aux_3) 
bysort host3 (aux_4) : replace aux_4 = aux_4[_N] if missing(aux_4) 
bysort host3 (aux_5) : replace aux_5 = aux_5[_N] if missing(aux_5) 

gen top_investors = aux_1 + ", " + aux_2 + ", " + aux_3 + ", " + aux_4 + ", " + aux_5

gen shareFDI = fdi/FDI_instock*100 
format %2.1f shareFDI

gen share_1 = shareFDI if rank == 1
gen share_2 = shareFDI if rank == 2
gen share_3 = shareFDI if rank == 3
gen share_4 = shareFDI if rank == 4
gen share_5 = shareFDI if rank == 5

bysort host3: egen share_1_tot = total(share_1)
bysort host3: egen share_2_tot = total(share_2)
bysort host3: egen share_3_tot = total(share_3)
bysort host3: egen share_4_tot = total(share_4)
bysort host3: egen share_5_tot = total(share_5)

format %2.0f share_1_tot // Don't know but rounding doesn't remain when converting into string... 
format %2.0f share_2_tot
format %2.0f share_3_tot
format %2.0f share_4_tot
format %2.0f share_5_tot

gen aux_symb = "("
gen aux_symb2 = ")"
egen investor_share_1 = concat(aux_1 aux_symb share_1_tot aux_symb2), punct(" ")
egen investor_share_2 = concat(aux_2 aux_symb share_2_tot aux_symb2), punct(" ")
egen investor_share_3 = concat(aux_3 aux_symb share_3_tot aux_symb2), punct(" ")
egen investor_share_4 = concat(aux_4 aux_symb share_4_tot aux_symb2), punct(" ")
egen investor_share_5 = concat(aux_5 aux_symb share_5_tot aux_symb2), punct(" ")


gen top_investors_sh = investor_share_1 + ", " + investor_share_2 + ", " + investor_share_3 + ", " + investor_share_4 + ", " + investor_share_5

keep host3 FDI_instock top_investors_sh 
duplicates drop host3, force
*gen host_iso3 = ustrupper(host3)

save "${results_path}tables/Table_A.6.dta", replace


***************************************
*** Table A.7: Share of FDI firms by industries and FDI home country income classifications
***************************************

use "${data_path_prep}WBES_panel_prep.dta", clear


logit greenstrategy i.fdidummy50  $controls2019 i.sector i.country  , vce(cluster sec_coun) 
gen sample_str = e(sample)

logit greenmanager i.fdidummy50  $controls2019 i.sector i.country  , vce(cluster sec_coun) 
gen sample_ma = e(sample)

keep if sample_ma
keep countrycode fdidummy50 sector classification

bys countrycode: egen tot_fdi = total(fdidummy50)
bys countrycode: gen tot_nbr = _N

gen sh_fdi_country = tot_fdi/tot_nbr*100

bys countrycode sector: egen tot_fdi_sec = total(fdidummy50)
bys countrycode sector: gen tot_nbr_sec = _N

gen sh_fdi_country_sector = tot_fdi_sec/tot_nbr_sec*100


bys classification sector: egen tot_fdi_class = total(fdidummy50)
bys classification sector: gen tot_nbr_class = _N

gen sh_fdi_class_sector = tot_fdi_class/tot_nbr_class*100

collapse sh_fdi_class_sector, by(classification sector)
sort classification sector

export excel using "${results_path}tables/Table_A.7.xlsx", firstrow(variable) sheet("class generated in Stata", replace)





***************************************
*** Table A.10: Alternative measure of green management practices: Firms that have both green strategy and a green manager
***************************************

use "${data_path_prep}WBES_panel_prep.dta", clear

*green strategy and no green management
gen greenstrategy_only = . // adopters of both remain excluded (biased by the presence of adopters of both dimensions)
	replace greenstrategy_only = 0 if greenstrategy == 0 & greenmanager == 0
	replace greenstrategy_only = 0 if greenstrategy == 0 & greenmanager == 1 // only a few
	replace greenstrategy_only = 1 if greenstrategy == 1 & greenmanager == 0	


*green management and no green strategy
gen greenmanager_only = . // adopters of both remain excluded (biased by the presence of adopters of both dimensions)
	replace greenmanager_only = 0 if greenmanager == 0 & greenstrategy == 0	
	replace greenmanager_only = 0 if greenmanager == 0 & greenstrategy == 1 
	replace greenmanager_only = 1 if greenmanager == 1 & greenstrategy == 0	

*both green strategy and green management
gen green_both = .
	replace green_both = 0 if greenstrategy == 0 & greenmanager == 0
	replace green_both = 0 if greenmanager == 0 & greenstrategy == 1 	
	replace green_both = 0 if greenstrategy == 0 & greenmanager == 1 
	replace green_both = 1 if greenstrategy == 1 & greenmanager == 1

	* Total sample	
		logit green_both $controls2019 i.sector i.country , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.10.tex", replace eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green both, odds ratio, total sample)  dec(3) lab nocons  tex keep($controls2019 ) 

	* Manufacturing
		logit green_both $controls2019 i.sector i.country if sectordummy==0, vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.10.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green both, odds ratio, manufacturing)  dec(3) lab nocons  tex keep($controls2019 ) 
	
	* Service
		logit green_both $controls2019 i.sector i.country if sectordummy==1, vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.10.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green both, odds ratio, service)  dec(3) lab nocons  tex keep($controls2019 ) 







***************************************
*** Table A.11: Stepwise inclusion of control variables: Green strategy
***************************************

* The stepwise model indicates that all controls are important.
global controls2019step " i.exportdummy i.firmsize i._13_19_resdevdummy  l_prod_int  i.externalknowledge i.finance_obst i.env_regulation_obst  i.LossWeather i.LossPollution i.certificate_desire "


*********************
* Total sample	

logit greenstrategy i.fdidummy50  $controls2019step i.sector i.country  , vce(cluster sec_coun) 
gen sample_str = e(sample)

logit greenmanager i.fdidummy50  $controls2019step i.sector i.country  , vce(cluster sec_coun) 
gen sample_ma = e(sample)

	* green strategy
		logit greenstrategy i.fdidummy50  ///
		i.sector i.country  if sample_str == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.11.tex", replace  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy i.fdidummy50) 

		logit greenstrategy i.fdidummy50 i.exportdummy ///
		i.sector i.country if sample_str == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.11.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy i.fdidummy50 i.exportdummy) 

		logit greenstrategy i.fdidummy50 i.exportdummy i.firmsize i.sector ///
		i.country if sample_str == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.11.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy i.fdidummy50 i.exportdummy i.firmsize) 
		
		logit greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy ///
		i.sector i.country if sample_str == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.11.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy) 
		
		logit greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int ///
		i.sector i.country if sample_str == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.11.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int) 
		
		logit greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge ///
		i.sector i.country if sample_str == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.11.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge) 
		
		logit greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst ///
		i.sector i.country  if sample_str == 1, vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.11.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst) 
		
		logit greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst ///
		i.env_regulation_obst ///
		i.sector i.country  if sample_str == 1, vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.11.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst i.env_regulation_obst) 
		
		logit greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst ///
		i.env_regulation_obst i.LossWeather ///
		i.sector i.country if sample_str == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.11.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst i.env_regulation_obst i.LossWeather) 
		
		logit greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst ///
		i.env_regulation_obst i.LossWeather i.LossPollution  ///
		i.sector i.country  if sample_str == 1, vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.11.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst i.env_regulation_obst i.LossWeather i.LossPollution ) 
		
		logit greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst ///
		i.env_regulation_obst i.LossWeather i.LossPollution i.certificate_desire ///
		i.sector i.country  , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.11.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst i.env_regulation_obst i.LossWeather i.LossPollution i.certificate_desire)
		

		
*************************************** 	
*** Table A.12: Stepwise inclusion of control variables: Green manager
***************************************		
	* green manager	
		logit greenmanager i.fdidummy50  ///
		i.sector i.country  if sample_ma == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.12.tex", replace  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager i.fdidummy50) 

		logit greenmanager i.fdidummy50 i.exportdummy ///
		i.sector i.country if sample_ma == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.12.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager i.fdidummy50 i.exportdummy) 

		logit greenmanager i.fdidummy50 i.exportdummy i.firmsize i.sector ///
		i.country if sample_ma == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.12.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager i.fdidummy50 i.exportdummy i.firmsize) 
		
		logit greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy ///
		i.sector i.country if sample_ma == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.12.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy) 
		
		logit greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int ///
		i.sector i.country if sample_ma == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.12.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int) 
		
		logit greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge ///
		i.sector i.country if sample_ma == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.12.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge) 
		
		logit greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst ///
		i.sector i.country  if sample_ma == 1, vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.12.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst) 
		
		logit greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst ///
		i.env_regulation_obst ///
		i.sector i.country  if sample_ma == 1, vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.12.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst i.env_regulation_obst) 
		
		logit greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst ///
		i.env_regulation_obst i.LossWeather ///
		i.sector i.country if sample_ma == 1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.12.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst i.env_regulation_obst i.LossWeather) 
		
		logit greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst ///
		i.env_regulation_obst i.LossWeather i.LossPollution  ///
		i.sector i.country  if sample_ma == 1, vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.12.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst i.env_regulation_obst i.LossWeather i.LossPollution ) 
		
		logit greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst ///
		i.env_regulation_obst i.LossWeather i.LossPollution i.certificate_desire ///
		i.sector i.country  , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.12.tex", append  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, Yes) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager i.fdidummy50 i.exportdummy i.firmsize i._13_19_resdevdummy l_prod_int i.externalknowledge i.finance_obst i.env_regulation_obst i.LossWeather i.LossPollution i.certificate_desire)
		
		
		
		
		
***************************************
*** Table A.13: Replacing country fixed effects by the FDI host country's EPI
***************************************

	
* Total sample	
	* green strategy
		logit greenstrategy $controls2019 c.epi i.sector  , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.13.tex", replace  eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, No) ctitle(Green strategy, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenstrategy $controls2019 c.epi) 
		
		
	* green manager	
		logit greenmanager $controls2019 c.epi i.sector  , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.13.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, No) ctitle(Green manager, odds ratio, total sample)  dec(3) lab nocons  tex keep(greenmanager $controls2019 c.epi) 
				

* Manufacturing sample	
	
	* green strategy
		logit greenstrategy $controls2019 c.epi i.sector if sectordummy==0 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.13.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, No) ctitle(Green strategy, odds ratio, manufacturing)  dec(3) lab nocons  tex keep(greenstrategy $controls2019 c.epi) 
				
	* green manager	
		logit greenmanager $controls2019 c.epi  i.sector if sectordummy==0 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.13.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, No) ctitle(Green manager, odds ratio, manufacturing)  dec(3) lab nocons  tex keep(greenmanager $controls2019 c.epi ) 
		
		
* Service sample	
	
	* green strategy
		logit greenstrategy $controls2019 c.epi  i.sector if sectordummy==1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.13.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, No) ctitle(Green strategy, odds ratio, service )  dec(3) lab nocons  tex keep(greenstrategy $controls2019 c.epi ) 		
		
	* green manager
		logit greenmanager $controls2019 c.epi i.sector  if sectordummy==1 , vce(cluster sec_coun) 
		outreg2 using "${results_path}tables/Table_A.13.tex", append eform addstat("Pseudo R$^2$", e(r2_p)) addtext(Sector FE, Yes, Country FE, No) ctitle(Green manager, odds ratio, service)  dec(3) lab nocons  tex keep(greenmanager $controls2019 c.epi ) 
		
			
			
			
cap log close			