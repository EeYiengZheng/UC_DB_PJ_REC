import java.sql.*;

public class DBConnectionTest {
    public static void main(String[] args) {
        // make a new DatabaseConnection object. Defaults to args[0]
        DatabaseConnection dbc = new DatabaseConnection();

        Statement stmt = null;
        ResultSet rs = null;
        ResultSetMetaData rsmd;
        try {
            // get connection with username = args[0] password = args[1]
            Connection conn = DatabaseConnection.getConnection(args[0], args[1], args[2]);
            DatabaseMetaData meta = conn.getMetaData();
            stmt = conn.createStatement();
            stmt.setFetchSize(1000);
            rs = stmt.executeQuery("SELECT * FROM classics");
            rsmd = rs.getMetaData();

            System.out.println("Connection to " + args[0] + " successful");
            System.out.println("Driver Name : " + meta.getDriverName());

            // get DATABASE name
            ResultSet dbName = stmt.executeQuery("SELECT DATABASE()");
            dbName.next();
            System.out.println("Inside " + dbName.getString(1) + "." + rsmd.getTableName(1));

            // printing out everything from the SELECT query
            int columnsNumber = rsmd.getColumnCount();
            while (rs.next()) {
                for (int i = 1; i <= columnsNumber; i++) {
                    if (i > 1) System.out.print(",  ");
                    String columnValue = rs.getString(i);
                    System.out.print(rsmd.getColumnName(i) + " = " + columnValue);
                }
                System.out.println("");
            }

        } catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ignored) {
                } // ignore

                rs = null;
            }

            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException ignored) {
                } // ignore

                stmt = null;
            }
        }
    }
}
