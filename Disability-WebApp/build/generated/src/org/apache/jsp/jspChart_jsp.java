package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.File;
import javax.swing.ImageIcon;
import rcaller.RCaller;
import rcaller.RCode;;

public final class jspChart_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");


                try {
                    RCaller caller = new RCaller();
                    RCode code = new RCode();
                    caller.setRscriptExecutable("/Library/Frameworks/R.framework/Versions/3.3/Resources/Rscript");
                    caller.cleanRCode();
                    caller.setRCode(code);

                    // create some arrays in Java, which we'll send to R to manipulate            
                    double[] y = new double[]{1, 4, 3, 5, 6, 10};
                    double[] x = new double[]{3, 6, 5, 9, 8, 13};

                    // load the ggplot2 library into R
                    code.R_require("ggplot2");

                    // take the java arrays, x and y, and send them to R
                    code.addDoubleArray("x", x);
                    code.addDoubleArray("y", y);

                    // create a data frame in R using x and y variables
                    code.addRCode("df <- data.frame(x,y)");

                    // plot the relationship between x and y
                    File file = code.startPlot();
                    code.addRCode("ggplot(df, aes(x, y)) + geom_point() + geom_smooth(method='lm') + ggtitle('y = f(x)')");
                    caller.runOnly();
                    ImageIcon ii = code.getPlot(file);
                    code.showPlot(file);
                } catch (Exception e) {
                    System.out.println(e.toString());
                }
            }

        
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
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
