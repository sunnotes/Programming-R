Title
========================================================




```r
suppressPackageStartupMessages(library(googleVis))
T <- gvisTable(Exports, options = list(width = 200, height = 280))
G <- gvisGeoChart(Exports, locationvar = "Country", colorvar = "Profit", options = list(width = 360, 
    height = 280, dataMode = "regions"))
TG <- gvisMerge(T, G, horizontal = TRUE, tableOptions = "bgcolor=\"#CCCCCC\" cellspacing=10")

print(TG, "chart")
```

```
## <!-- Table generated in R 3.0.2 by googleVis 0.4.5 package -->
## <!-- Sat Oct 05 15:07:51 2013 -->
## 
## 
## <!-- jsHeader -->
## <script type="text/javascript">
##  
## // jsData 
## function gvisDataTableID23f43c794942 () {
## var data = new google.visualization.DataTable();
## var datajson =
## [
##  [
##  "Germany",
## 3,
## true 
## ],
## [
##  "Brazil",
## 4,
## false 
## ],
## [
##  "United States",
## 5,
## true 
## ],
## [
##  "France",
## 4,
## true 
## ],
## [
##  "Hungary",
## 3,
## false 
## ],
## [
##  "India",
## 2,
## true 
## ],
## [
##  "Iceland",
## 1,
## false 
## ],
## [
##  "Norway",
## 4,
## true 
## ],
## [
##  "Spain",
## 5,
## true 
## ],
## [
##  "Turkey",
## 1,
## false 
## ] 
## ];
## data.addColumn('string','Country');
## data.addColumn('number','Profit');
## data.addColumn('boolean','Online');
## data.addRows(datajson);
## return(data);
## }
## 
## 
## // jsData 
## function gvisDataGeoChartID23f416ea1b2f () {
## var data = new google.visualization.DataTable();
## var datajson =
## [
##  [
##  "Germany",
## 3 
## ],
## [
##  "Brazil",
## 4 
## ],
## [
##  "United States",
## 5 
## ],
## [
##  "France",
## 4 
## ],
## [
##  "Hungary",
## 3 
## ],
## [
##  "India",
## 2 
## ],
## [
##  "Iceland",
## 1 
## ],
## [
##  "Norway",
## 4 
## ],
## [
##  "Spain",
## 5 
## ],
## [
##  "Turkey",
## 1 
## ] 
## ];
## data.addColumn('string','Country');
## data.addColumn('number','Profit');
## data.addRows(datajson);
## return(data);
## }
##  
## // jsDrawChart
## function drawChartTableID23f43c794942() {
## var data = gvisDataTableID23f43c794942();
## var options = {};
## options["allowHtml"] = true;
## options["width"] =    200;
## options["height"] =    280;
## 
## 
##     var chart = new google.visualization.Table(
##     document.getElementById('TableID23f43c794942')
##     );
##     chart.draw(data,options);
##     
## 
## }
##   
## 
## 
## // jsDrawChart
## function drawChartGeoChartID23f416ea1b2f() {
## var data = gvisDataGeoChartID23f416ea1b2f();
## var options = {};
## options["width"] =    360;
## options["height"] =    280;
## options["dataMode"] = "regions";
## 
## 
##     var chart = new google.visualization.GeoChart(
##     document.getElementById('GeoChartID23f416ea1b2f')
##     );
##     chart.draw(data,options);
##     
## 
## }
##   
##  
## // jsDisplayChart
## (function() {
## var pkgs = window.__gvisPackages = window.__gvisPackages || [];
## var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
## var chartid = "table";
##   
## // Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
## var i, newPackage = true;
## for (i = 0; newPackage && i < pkgs.length; i++) {
## if (pkgs[i] === chartid)
## newPackage = false;
## }
## if (newPackage)
##   pkgs.push(chartid);
##   
## // Add the drawChart function to the global list of callbacks
## callbacks.push(drawChartTableID23f43c794942);
## })();
## function displayChartTableID23f43c794942() {
##   var pkgs = window.__gvisPackages = window.__gvisPackages || [];
##   var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
##   window.clearTimeout(window.__gvisLoad);
##   // The timeout is set to 100 because otherwise the container div we are
##   // targeting might not be part of the document yet
##   window.__gvisLoad = setTimeout(function() {
##   var pkgCount = pkgs.length;
##   google.load("visualization", "1", { packages:pkgs, callback: function() {
##   if (pkgCount != pkgs.length) {
##   // Race condition where another setTimeout call snuck in after us; if
##   // that call added a package, we must not shift its callback
##   return;
## }
## while (callbacks.length > 0)
## callbacks.shift()();
## } });
## }, 100);
## }
## 
## 
## // jsDisplayChart
## (function() {
## var pkgs = window.__gvisPackages = window.__gvisPackages || [];
## var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
## var chartid = "geochart";
##   
## // Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
## var i, newPackage = true;
## for (i = 0; newPackage && i < pkgs.length; i++) {
## if (pkgs[i] === chartid)
## newPackage = false;
## }
## if (newPackage)
##   pkgs.push(chartid);
##   
## // Add the drawChart function to the global list of callbacks
## callbacks.push(drawChartGeoChartID23f416ea1b2f);
## })();
## function displayChartGeoChartID23f416ea1b2f() {
##   var pkgs = window.__gvisPackages = window.__gvisPackages || [];
##   var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
##   window.clearTimeout(window.__gvisLoad);
##   // The timeout is set to 100 because otherwise the container div we are
##   // targeting might not be part of the document yet
##   window.__gvisLoad = setTimeout(function() {
##   var pkgCount = pkgs.length;
##   google.load("visualization", "1", { packages:pkgs, callback: function() {
##   if (pkgCount != pkgs.length) {
##   // Race condition where another setTimeout call snuck in after us; if
##   // that call added a package, we must not shift its callback
##   return;
## }
## while (callbacks.length > 0)
## callbacks.shift()();
## } });
## }, 100);
## }
##  
## // jsFooter
## </script>
##  
## <!-- jsChart -->  
## <script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartTableID23f43c794942"></script>
## 
## 
## <!-- jsChart -->  
## <script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartGeoChartID23f416ea1b2f"></script>
##  
## <table bgcolor="#CCCCCC" cellspacing=10>
## <tr>
## <td>
## 
## <!-- divChart -->
##   
## <div id="TableID23f43c794942"
##   style="width: 200px; height: 280px;">
## </div>
## 
## </td>
## <td>
## 
## <!-- divChart -->
##   
## <div id="GeoChartID23f416ea1b2f"
##   style="width: 360px; height: 280px;">
## </div>
## 
## </td>
## </tr>
## </table>
```



This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **MD** toolbar button for help on Markdown).

When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
summary(cars)
```

```
##      speed           dist    
##  Min.   : 4.0   Min.   :  2  
##  1st Qu.:12.0   1st Qu.: 26  
##  Median :15.0   Median : 36  
##  Mean   :15.4   Mean   : 43  
##  3rd Qu.:19.0   3rd Qu.: 56  
##  Max.   :25.0   Max.   :120
```


You can also embed plots, for example:


```r
plot(cars)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


