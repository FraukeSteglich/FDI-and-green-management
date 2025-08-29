********************************************************************************
/*
Green gifts from abroad? FDI and firms' green management
Authors: Peter Kannen, Finn Ole Semrau, Frauke Steglich

Replication files for the accepted manuscript
Journal of International Business Policy

Master file
28.08.2025
*/

/*
*** Packages needed
ssc install labutil
ssc install spmap
ssc install shp2dta
ssc install mif2dta
ssc install psmatch2
ssc install estout
ssc install wbopendata
ssc install combomarginsplot
ssc install norm
ssc install violinplot, replace
ssc install dstat, replace
ssc install moremata, replace
ssc install palettes, replace
ssc install colrspace, replace
ssc install vioplot, replace
ssc install ivreg2h
ssc install ivreg2
ssc install ranktest 
ssc install ivhettest
ssc install kountry
ssc install spmap
ssc install shp2dta
ssc install mif2dta
ssc install egenmore
*ssc install tabmiss // installed manually via search
*/

set scheme plotplain

********************************************************************************
version 18.0
clear
clear matrix
clear mata

set maxvar  32000
set	matsize	11000
set more 	off

********************************************************************************

/* 
* Set global paths
global 		master_path			"..."
global		dofiles_path		"...\do files\"
global		results_path		"...\output\"
global 		data_path			"...\input\"
global 		data_path_prep		"...\input\prepared_data\"
global 		log_path			"...\output\log files\"
*/
 
********************************************************************************
cap log close
global sysdata=c(current_date)
log using "${log_path}00_master", replace
********************************************************************************
clear


********************************
*** Run all relevant do-files
********************************
*** Preparation of external macro indicators
do "${dofiles_path}1_greenFDI_macro_indicators.do"
do "${dofiles_path}2_greenFDI_macro_indicators_EPI.do"

*** Preparation of the WBES data, merging & variable preparation
do "${dofiles_path}3_greenFDI_WBES_merging.do"
do "${dofiles_path}4_greenFDI_data_prep.do"

*** Analysis
do "${dofiles_path}5_greenFDI_analysis_baseline.do"
do "${dofiles_path}6_greenFDI_analysis_robustness.do"
do "${dofiles_path}7_greenFDI_onlineappendix.do"


********************************************************************************
cap log close
exit

