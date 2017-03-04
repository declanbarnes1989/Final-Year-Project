package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class chart_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">\n");
      out.write("        <title>Disability Chart</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("    <center><h1>Disabilities by County:</h1></center>\n");
      out.write("    <div id=\"my_chart\" style=\"width: 1100px; height: 400px\">\n");
      out.write("    </div>\n");
      out.write("    <script type=\"text/javascript\" src=\"https://www.google.com/jsapi\"></script> \n");
      out.write("    <script>\n");
      out.write("        google.load(\"visualization\", \"1\", {packages: [\"corechart\"]});\n");
      out.write("        google.setOnLoadCallback(drawChart);\n");
      out.write("        function drawChart() {\n");
      out.write("            // Create and populate the data table.\n");
      out.write("            var data = google.visualization.arrayToDataTable([\n");
      out.write("                ['County', 'Amount'],\n");
      out.write("                ['Dublin', 164339],\n");
      out.write("                ['Kildare', 24369],\n");
      out.write("                ['Kilkenny', 11939],\n");
      out.write("                ['Laois', 10217],\n");
      out.write("                ['Longford', 5404],\n");
      out.write("                ['Louth', 15932],\n");
      out.write("                ['Meath', 19669],\n");
      out.write("                ['Offaly', 10253],\n");
      out.write("                ['Westmeath', 11303],\n");
      out.write("                ['Wexford', 20134],\n");
      out.write("                ['Wicklow', 17616],\n");
      out.write("                ['Clare', 14775],\n");
      out.write("                ['Cork', 68372],\n");
      out.write("                ['Kerry', 19168],\n");
      out.write("                ['Limerick', 27343],\n");
      out.write("                ['Waterford', 15635]\n");
      out.write("            ]);\n");
      out.write("            var options = {\n");
      out.write("                title: ''\n");
      out.write("            };\n");
      out.write("            // Create and draw the visualization.\n");
      out.write("            new google.visualization.BarChart(\n");
      out.write("                    document.getElementById('my_chart')).draw(data, options);\n");
      out.write("        }\n");
      out.write("    </script>\n");
      out.write("    <center>\n");
      out.write("        <a href=\"index.jsp\" class=\"myButton\">Return</a>\n");
      out.write("    </center>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
      out.write("\n");
      out.write("\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
