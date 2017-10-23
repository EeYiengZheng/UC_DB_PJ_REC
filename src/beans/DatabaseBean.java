package beans;

import java.sql.*;

public class DatabaseBean {
    private Connection conn;
    private Statement stmt;
    private String databaseName;
    private String username;
    private String password;
    private String tableName;

    public DatabaseBean() {

    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setTable(String table) {
        this.tableName = table;
    }

    public String getTable() {
        return tableName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getDatabaseName() {
        return databaseName;
    }

    public void setDatabaseName(String databaseName) {
        this.databaseName = databaseName;
    }

    public void setConn() {
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/publications?user=" + getUsername() + "&password=" + getPassword());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public ResultSet query(String query) throws SQLException {
        //test
        stmt = conn.createStatement();
        return stmt.executeQuery(query);
    }
}
