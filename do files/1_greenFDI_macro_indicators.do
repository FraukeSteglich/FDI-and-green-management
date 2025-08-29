/*
Green gifts from abroad? FDI and firms' green management
Authors: Peter Kannen, Finn Ole Semrau, Frauke Steglich

Replication files for the accepted manuscript
Journal of International Business Policy

Macro indicator preparation
28.08.2025
*/

	
* GNI: Needed for host country characteristics GNI split	
	wbopendata, language(en - English) country(ALB;ARM;AZE;BGR;BIH;EGY;EST;CZE;GEO;HRV;HUN;KAZ;KGZ;LBN;LVA;LTU;MAR;MDA;MKD;MNG;POL;ROU;RUS;SRB;SVK;SVN;TJK;TUN;TUR;UKR;UZB;XKX;) ///
	topics() indicator(NY.GNP.PCAP.CD) clear long
	keep if year==2009 | year==2012 | year==2018
	gen time=0
	replace time=1 if year==2012
	replace time=2 if year==2018
	drop year
	rename ny_gnp_pcap_cd gni_pcap
	
	save "${data_path_prep}macro_gni_panel.dta", replace	

	
* Exchange rate to standardize labour productivity in USD
	wbopendata, language(en - English) country(ALB;ARM;AZE;BGR;BIH;EGY;EMU;EST;CZE;GEO;HRV;HUN;KAZ;KGZ;LBN;LVA;LTU;MAR;MDA;MKD;MNG;POL;ROU;RUS;SRB;SVK;SVN;TJK;TUN;TUR;UKR;UZB;XKX;) ///  *EMU=Euro
	topics() indicator(PA.NUS.FCRF) clear long
	
	gen eurofx=.
	replace eurofx=pa_nus_fcrf if countrycode=="EMU"
	bysort year: egen eurofxtotal=total(eurofx)
	rename pa_nus_fcrf fx
	replace fx=eurofxtotal if (fx==. & countrycode=="EST") | (fx==. & countrycode=="LVA") | (fx==. & countrycode=="LTU") | (fx==. & countrycode=="SVK") | (fx==. & countrycode=="SVN") 
	
	* No data for UZB for several years, extrapolation might be plausible given the chart
	ipolate fx year if countrycode=="UZB", gen(fx_int) /*https://fxtop.com/en/historical-exchange-rates-graph-zoom.php?C1=USD&C2=UZS&A=1&DD1=&MM1=&YYYY1=&DD2=12&MM2=10&YYYY2=2020&LARGE=1&LANG=en&VAR=0&MM1M=0&MM3M=0&MM1Y=0&LOG=&TR=&INDICE=*/
	replace fx=fx_int if countrycode=="UZB"	

	keep if year==2009 | year==2012 | year==2018
	gen time=0
	replace time=1 if year==2012
	replace time=2 if year==2018
	
	replace fx=4.845877 if countrycode=="TUR" & time==2
	save "${data_path_prep}macro_fx_panel.dta", replace	

	
* EPI: Used to proxy environmental policy stringency
	import excel "${data_path}EPI.xlsx", clear firstrow
	drop rank
	kountry country, from(other) stuck

	rename _ISO3N_ iso3
	kountry iso3, from (iso3n) to(iso3c)
	drop iso3 
	rename _ISO3C_ iso3
	replace iso="MKD" if country=="North Macedonia" 
	rename iso3 countrycode
	drop country
	drop if countrycode==""
	save "${data_path_prep}epi.dta", replace	

	
	

	
		
