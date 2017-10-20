import java.sql.*;

public class DBConnectionTest {
    public static void main(String[] args) {
        // make a new DatabaseConnection object. Defaults to args[0]
        DatabaseConnection dbc = new DatabaseConnection();

        Statement stmt = null;
        ResultSet rs = null;
        ResultSetMetaData rsmd = null;
        try {
            // get connection with username = args[0] password = args[1]
            Connection conn = DatabaseConnection.getConnection(args[0], args[1], args[2]);
            DatabaseMetaData meta = conn.getMetaData();
            // stmt = conn.createStatement();
            // stmt.setFetchSize(1000);
            // rs = stmt.executeQuery("SELECT * FROM classics");
            // rsmd = rs.getMetaData();

            System.out.println("Connection to " + args[0] + " successful");
            System.out.println("Driver Name : " + meta.getDriverName());

        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException sqlEx) {
                } // ignore

                rs = null;
            }

            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException sqlEx) {
                } // ignore

                stmt = null;
            }
        }
    }
}
