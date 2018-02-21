package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import beans.User;
import database.Account;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DataSource ds;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller()
    {
        super();
        // TODO Auto-generated constructor stub
    }

    
    
    
    
    
	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException
	{
		try {
			InitialContext initContext = new InitialContext();
			
			Context env = (Context)initContext.lookup("java:comp/env");
			
			//now I can use this context to look up my data source (the mysql aws database)
			
			ds = (DataSource)env.lookup("jdbc/critiqueudb");
			
			
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			throw new ServletException();
		}
	}

	
	
	
	
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");

		if (action == null) {
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		}
		else if(action.equals("login")) {
			request.setAttribute("email", "");
			request.setAttribute("password", "");
			request.setAttribute("message", "");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
		else if(action.equals("createaccount")) {
			request.setAttribute("email", "");
			request.setAttribute("password", "");
			request.setAttribute("repeatpassword", "");
			request.setAttribute("message", "");
			request.getRequestDispatcher("/createaccount.jsp").forward(request, response);
		}
		else {
			out.println("unrecognized action");
			return;
		}
		//getServletContext().getRequestDispatcher("/home.jsp").forward(request, response);
	}

	
	
	
	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//use connection
				PrintWriter out = response.getWriter();
				
				String action = request.getParameter("action");
				
				if(action == null)
				{
					out.println("unrecognized action");
					return;
				}
				
				Connection conn = null;
				
				try
				{
					conn = ds.getConnection();
				}
				catch (SQLException e)
				{
					throw new ServletException();
				}
				
				Account account = new Account(conn);
				
				if(action.equals("dologin"))
				{
					String email = request.getParameter("email");
					String password = request.getParameter("password");
					
					User user = new User(email, password);
					
					request.setAttribute("email", email);
					request.setAttribute("password", "");
					
					//if we successfully log in, forward to the loginsuccess.jsp page
					try {
						if(account.login(email, password)) //Account object attempts authentication and returns boolean 
						{
							//set the User bean as a session variable
							// get the session object
							HttpSession mySession = request.getSession();
							
							String emailTemp = (String) mySession.getAttribute("email");
							
							if(emailTemp == null)
								emailTemp = email;
							
							mySession.setAttribute("email", email);
							request.getRequestDispatcher("/loginsuccess.jsp").forward(request, response);
						}
						else
						{
							//set an error message as an attribute "message"
							request.setAttribute("message", "Error! Email address or password is incorrect.");
							//and forward back to the login page
							request.getRequestDispatcher("/login.jsp").forward(request, response);
						}
					} catch (SQLException e) {
						// TODO: Do something sensible here, like forward to an error.jsp
						e.printStackTrace();
					}
					
					
					
					//TODO: if the users login info can be found in the db, then we go to the success page
						// if it can't, we go back to the form.
					//request.getRequestDispatcher("/loginsuccess.jsp").forward(request, response);
					
					
				}
				else if(action.equals("createaccount"))
				{
					String email = request.getParameter("email");
					String password = request.getParameter("password");
					String repeatPassword = request.getParameter("repeatpassword");
					
					request.setAttribute("email", email);
					request.setAttribute("password", "");
					request.setAttribute("repeatpassword", "");
					request.setAttribute("message", "");
					
					if(!password.equals(repeatPassword))
					{
						request.setAttribute("message", "Error! Passwords do not match.");
						request.getRequestDispatcher("/createaccount.jsp").forward(request, response);
					}
					else
					{
						User user = new User(email, password);
						
						if(!user.validate())
						{
							//the email or password is in the wrong format
							request.setAttribute("message", user.getMessage());
							request.getRequestDispatcher("/createaccount.jsp").forward(request, response);
						}
						else
						{
							try
							{
								if(account.exists(email))
								{
									//the email already exists in the user database
									request.setAttribute("message", "Error! An account with this email address already exists.");
									request.getRequestDispatcher("/createaccount.jsp").forward(request, response);
								}
								else
								{
									//passes all checks. Create the account
									account.create(email, password);
									
									//set the user's email as a session variable
									// get the session object
									HttpSession mySession = request.getSession();
									
									String emailTemp = (String) mySession.getAttribute("email");
									
									if(emailTemp == null)
										emailTemp = email;
									
									mySession.setAttribute("email", email);
									request.getRequestDispatcher("/createsuccess.jsp").forward(request, response);
								}
							}
							catch(SQLException e)
							{
								request.getRequestDispatcher("/error.jsp").forward(request, response);
							}
						}
					}
				}
				else
				{
					out.println("unrecognized action");
					return;
				}
	}

}
