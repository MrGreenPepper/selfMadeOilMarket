$onText

$call gdxxrw.exe ModelInputData.xlsx par=region rng=Tabelle1!A1:A7 dim=1 cdim=1 rdim=0 log=region.txt
Set region
$gdxIn ModelInputData.gdx
$load region
$gdxIn
;

$offText


Sets
region                      /NorthAmerica,EU,Russia,OPEC,FarEast/
supplier(region)            /NorthAmerica,EU,Russia,OPEC,FarEast/
alias(region,regionB)
;



$call gdxxrw.exe ModelInputData.xlsx par=SlopeDemand rng=Tabelle1!A2:C7 dim=1 cdim=0 rdim=1 log=SlopeDemand.txt
Parameter SlopeDemand(region)
$gdxIn ModelInputData.gdx
$load SlopeDemand
$gdxIn
;

$call gdxxrw.exe ModelInputData.xlsx par=MaxConsumption rng=Tabelle1!A28:B32 dim=1 cdim=0 rdim=1 log=MaxConsumption.txt
Parameter MaxConsumption(region)
$gdxIn ModelInputData.gdx
$load MaxConsumption
$gdxIn
;


$call gdxxrw.exe ModelInputData.xlsx par=ProductionCosts rng=Tabelle1!A19:B23 dim=1 cdim=0 rdim=1 log=ProductionCosts.txt
Parameter ProductionCosts(region)
$gdxIn ModelInputData.gdx
$load ProductionCosts
$gdxIn
;

$call gdxxrw.exe ModelInputData.xlsx par=ProductionCap rng=Tabelle1!A38:B42 dim=1 cdim=0 rdim=1 log=ProductionCap.txt
Parameter ProductionCap(region)
$gdxIn ModelInputData.gdx
$load ProductionCap
$gdxIn
;

$call gdxxrw.exe ModelInputData.xlsx par=TransportationCosts rng=Tabelle1!A10:F15 dim=2 cdim=1 rdim=1 log=TransportationCosts.txt
Parameter TransportationCosts(region, regionB)
$gdxIn ModelInputData.gdx
$load TransportationCosts
$gdxIn
;

$call gdxxrw.exe ModelInputData.xlsx par=TransportationCap rng=Tabelle1!A47:F52 dim=2 cdim=1 rdim=1 log=TransportationCap.txt
Parameter TransportationCap(supplier, region)
$gdxIn ModelInputData.gdx
$load TransportationCap
$gdxIn
;


