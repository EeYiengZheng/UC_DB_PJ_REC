package helpers;

import java.sql.*;

public class DatabaseConnector {
    private Connection con;

    public DatabaseConnector() {
        try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CS157A", "root", "");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
    }

    public ResultSet query(String query) {
        Statement stmt;
		try {
			stmt = con.createStatement();
	        return stmt.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }

}