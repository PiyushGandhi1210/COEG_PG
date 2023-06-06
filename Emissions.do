** Using Conversion Factors to estimate Emissions ** 


if strpos("`c(username)'","piyushgandhi")>0 {
	global coeg "/Users/piyushgandhi/Dropbox (Good Business Lab)/cost_of_economic_growth"
}


use "${coeg}/data/04_cmie_prowess/cmie_prowess_dist_proc.dta", clear


** Agricultural Waste conversion factors **
foreach x in d_con_agr_t {
forv v = 2000/2021 {
gen  `x'_CO2_`v' = `x'_`v'*975*0.9071847 
label var `x'_CO2_`v' "CO2 Emission (in kg)"
gen `x'_lt_CO2_`v'= log(`x'_CO2_`v')
label var `x'_lt_CO2_`v' "log total CO2 Emission (in kg)"

gen  `x'_CH4_`v' = `x'_`v'*264*0.9071847 
label var `x'_CH4_`v' "CH4 Emission (in g)"
gen `x'_lt_CH4_`v'= log(`x'_CH4_`v')
label var `x'_lt_CH4_`v' "log total CH4 Emission (in g)"


gen  `x'_N2O_`v' = `x'_`v'*35*0.9071847 
label var `x'_N2O_`v' "N2O Emission (in g)"
gen `x'_lt_N2O_`v'= log(`x'_N2O_`v')
label var `x'_lt_N2O_`v' "log total N2O Emission (in g)"

}
}

** Coal Conversion factors **
// In absence of type of coal, I have assumed the conversion factors of mixed (industrial sector)



foreach x in d_con_coal_t {
forv v = 2000/2021 {
gen  `x'_CO2_`v' = `x'_`v'*2116*0.9071847 
label var `x'_CO2_`v' "CO2 Emission (in kg)"
gen `x'_lt_CO2_`v'= log(`x'_CO2_`v')
label var `x'_lt_CO2_`v' "log total CO2 Emission (in kg)"

gen  `x'_CH4_`v' = `x'_`v'*246*0.9071847 
label var `x'_CH4_`v' "CH4 Emission (in g)"
gen `x'_lt_CH4_`v'= log(`x'_CH4_`v')
label var `x'_lt_CH4_`v' "log total CH4 Emission (in g)"


gen  `x'_N2O_`v' = `x'_`v'*36*0.9071847 
label var `x'_N2O_`v' "N2O Emission (in g)"
gen `x'_lt_N2O_`v'= log(`x'_N2O_`v')
label var `x'_lt_N2O_`v' "log total N2O Emission (in g)"

}
}



** Natural Gas Coversion Factors
** 1 kl = 35.31466 cu. foot. Conversion factor per std cubic foot
foreach x in d_con_gas_t {
forv v = 2000/2021 {
gen  `x'_CO2_`v' = `x'_`v'*0.05444*35.314666 
label var `x'_CO2_`v' "CO2 Emission (in kg)"
gen `x'_lt_CO2_`v'= log(`x'_CO2_`v')
label var `x'_lt_CO2_`v' "log total CO2 Emission (in kg)"

gen  `x'_CH4_`v' = `x'_`v'*0.00103*35.314666
label var `x'_CH4_`v' "CH4 Emission (in g)"
gen `x'_lt_CH4_`v'= log(`x'_CH4_`v')
label var `x'_lt_CH4_`v' "log total CH4 Emission (in g)"


gen  `x'_N2O_`v' = `x'_`v'*0.00010*35.314666 
label var `x'_N2O_`v' "N2O Emission (in g)"
gen `x'_lt_N2O_`v'= log(`x'_N2O_`v')
label var `x'_lt_N2O_`v' "log total N2O Emission (in g)"

}
}


** Electricity conversion factor is not given in US EPA file. Figures taken from their website: https://www.epa.gov/energy/greenhouse-gases-equivalencies-calculator-calculations-and-references#:~:text=Electricity%3A%2011%2C880%20kWh%20per%20home,metric%20tons%20CO2%2Fhome.
** 4.33 × 10-4 metric tons CO2/kWh = 0.433 kg/kWh
** Electricity N2O source: https://www.epa.gov/egrid/data-explorer: Used 2021 US average: 0.010 lb/MWh
**Electricity CH4 source: https://www.epa.gov/egrid/data-explorer: 0.071 lb/MWh average for USA 2021
foreach x in d_con_electr_t {
forv v = 2000/2021 {
gen  `x'_CO2_`v' = `x'_`v'*0.433
label var `x'_CO2_`v' "CO2 Emission (in kg)"
gen `x'_lt_CO2_`v'= log(`x'_CO2_`v')
label var `x'_lt_CO2_`v' "log total CO2 Emission (in kg)"

gen  `x'_CH4_`v' = `x'_`v'*0.071*0.453592
label var `x'_CH4_`v' "CH4 Emission (in g)"
gen `x'_lt_CH4_`v'= log(`x'_CH4_`v')
label var `x'_lt_CH4_`v' "log total CH4 Emission (in g)"


gen  `x'_N2O_`v' = `x'_`v'*0.010*0.453592
label var `x'_N2O_`v' "N2O Emission (in g)"
gen `x'_lt_N2O_`v'= log(`x'_N2O_`v')
label var `x'_lt_N2O_`v' "log total N2O Emission (in g)"

}
}



** Fuel Oil Conversion Factor
** Furnace oil synonyms show up as bunker fuel/fuel oil and match residual fuel oil no.6
foreach x in d_con_fuel_t {
forv v = 2000/2021 {
gen  `x'_CO2_`v' = `x'_`v'*11.27*264.172
label var `x'_CO2_`v' "CO2 Emission (in kg)"
gen `x'_lt_CO2_`v'= log(`x'_CO2_`v')
label var `x'_lt_CO2_`v' "log total CO2 Emission (in kg)"

gen  `x'_CH4_`v' = `x'_`v'*0.45*264.172
label var `x'_CH4_`v' "CH4 Emission (in g)"
gen `x'_lt_CH4_`v'= log(`x'_CH4_`v')
label var `x'_lt_CH4_`v' "log total CH4 Emission (in g)"


gen  `x'_N2O_`v' = `x'_`v'*0.09*264.172
label var `x'_N2O_`v' "N2O Emission (in g)"
gen `x'_lt_N2O_`v'= log(`x'_N2O_`v')
label var `x'_lt_N2O_`v' "log total N2O Emission (in g)"

}
}


** Wood Conversion Factor
foreach x in d_con_wood_t {
forv v = 2000/2021 {
gen  `x'_CO2_`v' = `x'_`v'*1640*0.9071847 
label var `x'_CO2_`v' "CO2 Emission (in kg)"
gen `x'_lt_CO2_`v'= log(`x'_CO2_`v')
label var `x'_lt_CO2_`v' "log total CO2 Emission (in kg)"

gen  `x'_CH4_`v' = `x'_`v'*126*0.9071847 
label var `x'_CH4_`v' "CH4 Emission (in g)"
gen `x'_lt_CH4_`v'= log(`x'_CH4_`v')
label var `x'_lt_CH4_`v' "log total CH4 Emission (in g)"


gen  `x'_N2O_`v' = `x'_`v'*63*0.9071847 
label var `x'_N2O_`v' "N2O Emission (in g)"
gen `x'_lt_N2O_`v'= log(`x'_N2O_`v')
label var `x'_lt_N2O_`v' "log total N2O Emission (in g)"

}
}
    


 save "${coeg}/data/04_cmie_prowess/cmie_prowess_dist_emissions_proc.dta", replace
 
 
 
 
 
 
 
 
 
 
