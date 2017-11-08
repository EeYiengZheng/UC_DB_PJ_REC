package controllers;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import helpers.DatabaseConnector;

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DatabaseConnector dbConn;

	public LoginController() {
		super();
		dbConn = new DatabaseConnector();
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");  
        String password = request.getParameter("password");
        
        ResultSet rs = dbConn.query("SELECT * FROM users WHERE username='" + username + "' AND password='" + password + "'");
        try {
			if (rs.first()) {
				response.sendRedirect("index.jsp");
			}
			else {
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				request.setAttribute("errorMessage", "Invalid user or password");
		        rd.forward(request, response); 
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	}
}