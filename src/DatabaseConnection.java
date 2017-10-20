

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * get a connection from a database
 * construct using databaseName(database name);
 * defaults to localhost for now
 * startup your XAMPP first
 */
public class DatabaseConnection {
    /**
     * make a connection to a database with only a username
     * use this is you're logging in a user without password
     *
     * @param username your username
     * @return type Connection; a connection to the database
     * @throws SQLException if there is an error
     */
    public static Connection getConnection(String databaseName, String username) throws SQLException {
        return DriverManager.getConnection(String.format(
                "jdbc:mariadb://localhost:3306/%s?user=%s", databaseName, username));
    }

    /**
     * make a connection to a database with a username and password
     * use this most of the time
     *
     * @param username your username
     * @return type Connection; a connection to the database
     * @throws SQLException if there is an error
     */
    public static Connection getConnection(String databaseName, String username, String password) throws SQLException {
        return DriverManager.getConnection(String.format(
                "jdbc:mariadb://localhost:3306/%s?user=%s&password=%s", databaseName, username, password));
    }
}
