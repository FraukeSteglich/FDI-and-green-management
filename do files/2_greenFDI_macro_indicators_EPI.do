/*
Green gifts from abroad? FDI and firms' green management
Authors: Peter Kannen, Finn Ole Semrau, Frauke Steglich

Replication files for the accepted manuscript
Journal of International Business Policy

EPI scores
28.08.2025
*/


***************************
* FDI data for 2019
***************************
use "${data_path}bilateral_fdi_2019.dta", clear
rename sending_country_code source
gsort host_country_code  -fdi

drop if fdi<=0
bysort host_country_code: keep if _n<=10     /* 10 largest FDI home countries*/

save "${data_path_prep}epi_fdi_bilateral.dta", replace


use "${data_path_prep}epi.dta", clear	
* Used for "EPI weighted FDI instock shares": Analysis on home country characteristics EPI split 

rename countrycode source

merge 1:m source  using "${data_path_prep}epi_fdi_bilateral.dta"
drop if host_country==""
drop if _merge==2 /* No EPI data for British Virgin Islands, Cayman Islands, Hong Kong China, Libya, Bermuda*/
drop _merge
sort host_country -fdi
drop gap
gen weight= epi/82.5
gen epi_weighted_fdi = fdi*weight

bysort host_country_code year: egen double sum_fdi=total(fdi) 
bysort host_country_code year: egen double sum_epi_fdi=total(epi_weighted_fdi) 

gen share_epifdi_totalfdi=(sum_epi_fdi/sum_fdi)*100
keep host_country_code share_epifdi_totalfdi
rename host_country_code countrycode
duplicates drop

save "${data_path_prep}epi_home_fdi.dta", replace

