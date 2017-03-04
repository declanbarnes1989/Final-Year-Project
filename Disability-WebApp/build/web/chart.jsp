<%-- 
    Document   : chart
    Created on : Dec 16, 2016, 10:14:10 PM
    Author     : declanbarnes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>Disability Chart</title>
    </head>
    <body>
    <center><h2>Disabilities by County:</h2></center>
    <div id="my_chart" style="width: 1100px; height: 400px">
    </div>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script> 
    <script>
        google.load("visualization", "1", {packages: ["corechart"]});
        google.setOnLoadCallback(drawChart);
        function drawChart() {
            // Create and populate the data table.
            var data = google.visualization.arrayToDataTable([
                ['County', 'Amount'],
                ['Dublin', 164339],
                ['Kildare', 24369],
                ['Kilkenny', 11939],
                ['Laois', 10217],
                ['Longford', 5404],
                ['Louth', 15932],
                ['Meath', 19669],
                ['Offaly', 10253],
                ['Westmeath', 11303],
                ['Wexford', 20134],
                ['Wicklow', 17616],
                ['Clare', 14775],
                ['Cork', 68372],
                ['Kerry', 19168],
                ['Limerick', 27343],
                ['Waterford', 15635]
            ]);
            var options = {
                title: ''
            };
            // Create and draw the visualization.
            new google.visualization.BarChart(
                    document.getElementById('my_chart')).draw(data, options);
        }
    </script>
    <center>
        <a href="index.jsp" class="myButton">Back</a>
    </center>

</body>
</html>


