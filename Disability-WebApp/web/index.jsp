<%-- 
    Document   : index
    Created on : Dec 16, 2016, 7:00:57 PM
    Author     : declanbarnes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
        <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'>
    </head>
    <body>
    <center>
        <h2>
            Disability Application
        </h2>
    </center>

    <table>
        <thead>

        </thead>
        <tbody>
            <tr>
                <td><h3>Please select an option below:</h3> </td>
            </tr>
            <tr>
                <td>
                    <div id="wrapper">
                        <ul class="nav">
                            <li class="fb" onclick="location.href = 'chart.jsp';">
                                <a href="chart.jsp"><img class="icon" src="Images/location.png" width="80px" height="50px" alt=""></a>
                                <span>Identify new HSE support centres</span>
                            </li>
                            <li class="gp" onclick="location.href = 'Analysis.jsp';">
                                <a href="chart.jsp"><img class="icon" src="Images/analysis.png" width="80px" height="50px" alt=""></a>
                                <span>Disability Analysis</span>
                            </li>
                        </ul>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
    <h4>Created By Declan Barnes</h4>
</body>
</html>
