import java.sql.*;
import java.util.*; 
public class SalaryStdDev {

	private Connection con = null;
	private PreparedStatement pstmt = null;
	
	public void setDBConnection(String url, String user, String password) {
		try {
			Class.forName("com.ibm.db2.jcc.DB2Driver").getDeclaredConstructor().newInstance();
			;
			con = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static double calculateSD(List<Integer> numArray)
    {
		double total = 0.0;
		double std = 0.0;
        int length = numArray.size();

        for(Integer num : numArray) {
            total += num;
        }

        double mean = total/length;

        for(Integer num: numArray) {
            std += (num - mean)*(num - mean);
        }

        return Math.sqrt(std/length);
	}
	
	public void testPrep(String sql, String col) {
		try {
			pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			List<Integer> list=new ArrayList<Integer>();
			while(rs.next()){
				int salary  = rs.getInt("SALARY");
				list.add(salary);
	   		}
			double sd = calculateSD(list);
        	System.out.println("Standard Deviation = "+sd);
			rs.close();
			pstmt.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		String db = args[0];
		String dbURL = "jdbc:db2://localhost:50000/" + db;
		String tablename = args[1];
		String user = args[2];
		String password = args[3];
		String col = "SALARY";
		String sql = "SELECT " + col + " FROM " + db + "." + tablename;

		SalaryStdDev demo = new SalaryStdDev();
		demo.setDBConnection(dbURL, user, password);		
		demo.testPrep(sql, col);
	}
}