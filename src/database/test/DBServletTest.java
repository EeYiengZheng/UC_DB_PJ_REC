package database.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DatabaseMetaData;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet(urlPatterns = "/testServlet", loadOnStartup = 1)
public class DBServletTest extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // You may use the following lines to initialize the context.
        // Obtain our environment naming context
        Context initCtx;
        try {
            initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");

            // A data source can be obtained by doing the following.
            // Look up our data source
            DataSource ds = (DataSource) envCtx.lookup("jdbc/test");

            // Allocate and use a connection from the pool

            // ... use this connection to access the database ...
            try (PrintWriter writer = resp.getWriter(); Connection conn = ds.getConnection();) {
                writer.println("connected: " + !conn.isClosed());
                DatabaseMetaData metadata = conn.getMetaData();
                writer.println("Database Product Name: " + metadata.getDatabaseProductName());
                writer.println("Database Product Version: " + metadata.getDatabaseProductVersion());
                writer.println("Logged User: " + metadata.getUserName());
                writer.println("JDBC Driver: " + metadata.getDriverName());
                writer.println("Driver Version: " + metadata.getDriverVersion());
                writer.println("\n");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}