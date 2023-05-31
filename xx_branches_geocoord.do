// replication for "Bank Presence and Health" (Kim Fe Cramer, LSE)

// 0. set local macros ---------------------------------------------------------
// in the final replication package set all local macros to 1

// 1. prepare pin code to longitude and latitude match -------------------------
import delimited "$data/09_other/pin_code_geocoord/IN.txt", clear 
// source: http://www.geonames.org/export/zip/ (data = IN.zip)
keep v2 v10 v11
rename v2 pin
rename v10 latitude
rename v11 longitude

sort pin latitude longitude
quietly by pin latitude longitude:  gen dup = cond(_N==1,0,_n)
drop if dup > 1
collapse (mean) latitude longitude, by(pin) 
// 19,097 of 19,101 pin codes 
save "$proc/pin_code_geocoord.dta", replace

// 2. load raw mof data --------------------------------------------------------
use "$data/01_rbi/rbi_branches_mof_for_geocoord.dta", clear
// 155,704 branches
gen pin = regexs(0) if(regexm(Address, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
destring pin, replace force

merge m:1 pin using "$proc/pin_code_geocoord.dta"
br if _merge != 3 & pin != .
tab _merge // why only match 89%?
tab _merge if pin != . // 95% this is actually okay -- not sure why though
drop if _merge != 3
// 141,391 branches

keep BranchOffice pin latitude longitude DateofOpen LicenseDate BankGroup District State PopulationGroup
gen branch_id = _n
order branch_id DateofOpen LicenseDate BranchOffice District State pin latitude longitude BankGroup PopulationGroup

gen open_year = substr(DateofOpen,-4,.)
gen lice_year = substr(LicenseDate,-4,.)
destring open_year, replace force
destring lice_year, replace force
drop DateofOpen LicenseDate
order branch_id open_year lice_year BranchOffice District State pin latitude longitude BankGroup PopulationGroup
gen private = 0
replace private = 1 if BankGroup ==  "PRIVATE SECTOR BANKS"
gen public = 0
replace public = 1 if private == 0

save "$proc/branch_coord.dta", replace
export delimited using "$proc/branch_coord", replace

// match this with the shape-file (coordinates)

geoinpoly latitude longitude using "$proc/maps_districts_2001_coord.dta", noprojection
rename _ID a_map_id
merge m:1 a_map_id using "$data/01_rbi/rbi.dta", keepusing(a_dist_id a_state a_dist b_* c_*) 
drop if _merge == 1

save "$proc/branch_coord_rbi.dta", replace
export delimited using "$proc/branch_coord_rbi", replace
