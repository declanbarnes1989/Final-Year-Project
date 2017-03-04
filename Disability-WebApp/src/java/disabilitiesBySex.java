
import java.sql.*;
import java.io.*;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartFrame;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.ChartUtilities;

public class disabilitiesBySex {

    public static void main(String[] args) throws Exception {

        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://mysql3.gear.host:3306/DisabilityDB?zeroDateTimeBehavior=convertToNull", "disabilitydb", "disability1989_");
        DefaultCategoryDataset my_bar_chart_dataset = new DefaultCategoryDataset();
        Statement stmt = conn.createStatement();
        try {
            JFreeChart BarChartObject;
            try (ResultSet query_set = stmt.executeQuery("SELECT Sex,Amount FROM disabilitydb.disabledsurvey WHERE Category='Total persons with a disability'")) {
                while (query_set.next()) {
                    String sex = query_set.getString("Sex");
                    int amount = query_set.getInt("Amount");
                    my_bar_chart_dataset.addValue(amount, "Amount", sex);
                }
                BarChartObject = ChartFactory.createBarChart("Disabilities - Both/Male/Female", "Sex", "Amount", my_bar_chart_dataset, PlotOrientation.VERTICAL, false, false, true);
            }
            ChartFrame frame = new ChartFrame("Results", BarChartObject);
            frame.pack();
            frame.setVisible(true);
            stmt.close();
            conn.close();
            int width = 1000;
            /* Width of the image */
            int height = 500;
            /* Height of the image */
            File BarChart = new File("disabilityBySex.png");
            ChartUtilities.saveChartAsPNG(BarChart, BarChartObject, width, height);
        } catch (Exception i) {
            System.out.println(i);
        }

    }
}
