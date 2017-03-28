package webJava;

import java.io.File;
import javax.swing.ImageIcon;
import rcaller.RCaller;
import rcaller.RCode;

public class TestR {

    public static void main(String args[]) {
       
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
}