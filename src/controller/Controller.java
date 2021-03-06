package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.sql.DataSource;

import org.json.JSONException;
import org.json.JSONObject;

import beans.User;
import database.Account;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;

import java.util.List;
import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.PutObjectResult;

import org.apache.commons.io.FilenameUtils;

/**
 * Servlet implementation class Controller
 */
@MultipartConfig
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
		try
		{
			InitialContext initContext = new InitialContext();
			
			Context env = (Context)initContext.lookup("java:comp/env");
			
			//now I can use this context to look up my data source (the mysql aws database)
			
			ds = (DataSource)env.lookup("jdbc/critiqueudb");
			
			/***storage test***
			final AmazonS3 s3 = AmazonS3ClientBuilder.defaultClient();
	        List<Bucket> buckets = s3.listBuckets();
	        System.out.println("Your Amazon S3 buckets are:");
	        for (Bucket b : buckets) {
	            System.out.println("* " + b.getName());
	        }
			//***storage test***/
		}
		catch (NamingException e)
		{
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

		if (action == null)
		{
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		}
		else if(action.equals("login"))
		{
			request.setAttribute("email", "");
			request.setAttribute("password", "");
			request.setAttribute("message", "");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}
		else if(action.equals("createaccount"))
		{
			request.setAttribute("email", "");
			request.setAttribute("password", "");
			request.setAttribute("repeatpassword", "");
			request.setAttribute("message", "");
			request.getRequestDispatcher("/createaccount.jsp").forward(request, response);
		}
		else if(action.equals("myart"))
		{
			request.getRequestDispatcher("/loginsuccess.jsp").forward(request, response);
		}
		else if(action.equals("more"))
		{
			/*TODO:
			 * the idea here is to query the database to return json containing 9 additional image stems,
			 * extensions, and the email address associated with them. This data will then be looped through
			 * in the javascript function to create the html and append to the proper div
			 * 
			 * 
			 * select * from artwork
				where email='mike@email.com'
				order by datetime desc
				limit index, 9;
			 * 
			*/
			
		    //TODO: query the database and return data needed for the image grid and the modal (json)
		    
		    HttpSession mySession = request.getSession();
		    String emailTemp = (String) mySession.getAttribute("email");
		    String startIndex = request.getParameter("index");
		    //startIndex = "0"; //delete this! using for testing
		    
		    String sql = "SELECT * FROM artwork AS result WHERE email=? ORDER BY datetime DESC LIMIT " + startIndex +", 9"; // ? character is a wildcard
		    
		    //declare and initialize Json object to return
			JSONObject obj = new JSONObject();
		    
			PreparedStatement statement;
			try {
				Connection conn = null;
				conn = ds.getConnection();
				statement = conn.prepareStatement(sql);
				statement.setString(1, emailTemp);
				
				//the result of a SQL query gets returned to ResultSet type object
				ResultSet rs = statement.executeQuery();
				
				//declare inner Json to hold each of 9 new image data, one at at time
				JSONObject innerObj;
				
				//get context path. This will be included in the returned json so that it can then be used in
					//the javascript function in each artwork modal to link to that image's critique page
				String contextPath = request.getContextPath();
				
				//declare int to iterate over for json
				int jsonIndex = 0;
				
				//the result has an internal pointer that begins before the first entry, so we first must move it up
				while(rs.next())
				{
					innerObj = new JSONObject();
					innerObj.put("email", emailTemp);
					innerObj.put("title", rs.getString("title"));
					innerObj.put("description", rs.getString("description"));
					innerObj.put("contextPath", contextPath);
					innerObj.put("wip", rs.getBoolean("work_in_progress"));
					String url = rs.getString("image_stem") + "." + rs.getString("image_extension");
					innerObj.put("url", url);
					//System.out.println(rs.getString("title"));
					obj.put(jsonIndex+"", innerObj);
					jsonIndex++;
				}
				
				System.out.println(obj.toString());

				rs.close();
				statement.close();
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//System.out.println(request.getContextPath());
			
			//old test portion being returned to the javascript function
			//String index = request.getParameter("index");
			//String text = "<p>This was generated on the server with index "+index+"</p>";

		    response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
		    response.setCharacterEncoding("UTF-8"); 
		    response.getWriter().write(obj.toString());       // Write response body.
		    
		}
		else if(action.equals("browse"))
		{
			request.getRequestDispatcher("/browse.jsp").forward(request, response);
		}
		else if(action.equals("browsemore"))
		{
			/*TODO:
			 * the idea here is to query the database to return json containing 9 additional image stems,
			 * extensions, and the email address associated with them. This data will then be looped through
			 * in the javascript function to create the html and append to the proper div
			 * 
			 * 
			 * select * from artwork
				where email='mike@email.com'
				order by datetime desc
				limit index, 9;
			 * 
			*/
			
		    //TODO: query the database and return data needed for the image grid and the modal (json)
		    
		    HttpSession mySession = request.getSession();
		    //String emailTemp = (String) mySession.getAttribute("email");
		    String startIndex = request.getParameter("index");
		    //startIndex = "0"; //delete this! using for testing
		    
		    String sql = "SELECT * FROM artwork AS result ORDER BY datetime DESC LIMIT " + startIndex +", 9"; // ? character is a wildcard
		    
		    //declare and initialize Json object to return
			JSONObject obj = new JSONObject();
		    
			PreparedStatement statement;
			try {
				Connection conn = null;
				conn = ds.getConnection();
				statement = conn.prepareStatement(sql);
				//statement.setString(1, emailTemp);
				
				//the result of a SQL query gets returned to ResultSet type object
				ResultSet rs = statement.executeQuery();
				
				//declare inner Json to hold each of 9 new image data, one at at time
				JSONObject innerObj;
				
				//get context path. This will be included in the returned json so that it can then be used in
					//the javascript function in each artwork modal to link to that image's critique page
				String contextPath = request.getContextPath();
				
				//declare int to iterate over for json
				int jsonIndex = 0;
				
				//the result has an internal pointer that begins before the first entry, so we first must move it up
				while(rs.next())
				{
					innerObj = new JSONObject();
					System.out.println(rs.getString("email")); //test email for each image entry
					innerObj.put("email", rs.getString("email"));
					innerObj.put("title", rs.getString("title"));
					innerObj.put("description", rs.getString("description"));
					innerObj.put("contextPath", contextPath);
					innerObj.put("wip", rs.getBoolean("work_in_progress"));
					String url = rs.getString("image_stem") + "." + rs.getString("image_extension");
					innerObj.put("url", url);
					//System.out.println(rs.getString("title"));
					obj.put(jsonIndex+"", innerObj);
					jsonIndex++;
				}
				
				System.out.println(obj.toString());

				rs.close();
				statement.close();
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//System.out.println(request.getContextPath());
			
			//old test portion being returned to the javascript function
			//String index = request.getParameter("index");
			//String text = "<p>This was generated on the server with index "+index+"</p>";

		    response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
		    response.setCharacterEncoding("UTF-8"); 
		    response.getWriter().write(obj.toString());       // Write response body.
		    
		}
		else if(action.equals("image"))
		{
			/*If action is "image", we will grab artist and image parameters from the url
			*then forward to a new .jsp which will contain high-res image, plus the form
			*to complete a full critique. The idea is to do it this way so that any image url can be easily
			*shared publicly. The page should only allow critique submission if user is logged in and if the
			*the user is not the artist (use condition to render multiple versions in the jsp)
			 */
			
			request.setAttribute("message", "");
			
			String artist = request.getParameter("artist");
			String title = request.getParameter("title");
			
			System.out.println("Controller successfully accessed '"+ title + "' image data by artist: " + artist + ".");
			
			//example url: http://localhost:8080/CritiqueU/Controller?action=image&artist=mike@email.com&title=raccoon
			
			request.getRequestDispatcher("/imagecritique.jsp").forward(request, response);
		}
		else if(action.equals("browse"))
		{
			System.out.println("browse section accessed");
		}
		else
		{
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
		PrintWriter out = response.getWriter();
		
		String action = request.getParameter("action");
		
		if(action == null)
		{
			out.println("unrecognized action");
			return;
		}
		
		HttpSession mySession = request.getSession();
		
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
			
			//User user = new User(email, password);
			
			//set these request attributes. In case of login failure, they will
				//autopopulate in the form for a retry (empty string password is intended)
			request.setAttribute("email", email);
			request.setAttribute("password", "");
			
			//if we successfully log in, forward to the loginsuccess.jsp page
			try {
				if(account.login(email, password)) //Account object attempts authentication and returns boolean 
				{
					//set the User bean as a session variable
					// get the session object
					mySession = request.getSession();
					
					String emailTemp = (String) mySession.getAttribute("email");
					
					if(emailTemp == null)
						emailTemp = email;
					
					mySession.setAttribute("email", email);
					mySession.setAttribute("loggedin", "true");
					
					//close database connection
					try
					{
						conn.close();
						account.closeDBConnection();
					}
					catch (SQLException e)
					{
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					request.getRequestDispatcher("/loginsuccess.jsp").forward(request, response);
				}
				else
				{
					//set an error message as an attribute "message"
					request.setAttribute("message", "Error! Email address or password is incorrect.");
					
					//close database connection
					try
					{
						conn.close();
						account.closeDBConnection();
					}
					catch (SQLException e)
					{
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					//and forward back to the login page
					request.getRequestDispatcher("/login.jsp").forward(request, response);
				}
			}
			catch (SQLException e)
			{
				// TODO: Do something sensible here, like forward to an error.jsp
				e.printStackTrace();
			}
			finally
			{
				try
				{
					conn.close();
					account.closeDBConnection();
				}
				catch (SQLException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
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
				
				//close database connection
				try
				{
					conn.close();
					account.closeDBConnection();
				}
				catch (SQLException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				request.getRequestDispatcher("/createaccount.jsp").forward(request, response);
			}
			else
			{
				User user = new User(email, password);
				
				if(!user.validate())
				{
					//the email or password is in the wrong format
					request.setAttribute("message", user.getMessage());
					
					//close database connection
					try
					{
						conn.close();
						account.closeDBConnection();
					}
					catch (SQLException e)
					{
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					request.getRequestDispatcher("/createaccount.jsp").forward(request, response);
				}
				else
				{
					try
					{
						if(account.exists(email))
						{
							//the email already exists in the user database
							
							//close database connection
							try
							{
								conn.close();
								account.closeDBConnection();
							}
							catch (SQLException e)
							{
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							
							request.setAttribute("message", "Error! An account with this email address already exists.");
							request.getRequestDispatcher("/createaccount.jsp").forward(request, response);
						}
						else
						{
							//passes all checks. Create the account
							account.create(email, password);
							
							//close database connection
							try
							{
								conn.close();
								account.closeDBConnection();
							}
							catch (SQLException e)
							{
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							
							//set the user's email as a session variable
							// get the session object
							mySession = request.getSession();
							
							String emailTemp = (String) mySession.getAttribute("email");
							
							if(emailTemp == null)
								emailTemp = email;
							
							mySession.setAttribute("email", email);
							request.getRequestDispatcher("/createsuccess.jsp").forward(request, response);
						}
					}
					catch(SQLException e)
					{
						e.printStackTrace();
						//request.getRequestDispatcher("/error.jsp").forward(request, response);
					}
					finally
					{
						try
						{
							conn.close();
							account.closeDBConnection();
						}
						catch (SQLException e)
						{
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
			}
		}
		else if(action.equals("uploadimage"))
		{
//			//***storage test***
//			final AmazonS3 s3 = AmazonS3ClientBuilder.defaultClient();
//	        List<Bucket> buckets = s3.listBuckets();
//	        System.out.println("Your Amazon S3 buckets are:");
//	        for (Bucket b : buckets) {
//	            System.out.println("* " + b.getName());
//	        }
//			//***storage test***/
			
			
		    String emailTemp = (String) mySession.getAttribute("email");
	        
			System.out.println("inside upload image section");
			System.out.println(request.getParameter("title"));
			
			//System.out.println(request.getParameter("image-to-upload"));

			//****** happy coding!
			//get the file chosen by the user
			Part filePart = request.getPart("image-to-upload");
			String fileName = filePart.getSubmittedFileName();
			
			if(fileName.endsWith(".jpg") || fileName.endsWith(".png")){

			    InputStream fileInputStream = filePart.getInputStream();
			    
			    //String accessKeyId = "YOUR_ACCESS_KEY_ID";
			    //String secretAccessKey =  "YOUR_SECRET_ACCESS_KEY";
			    //String region = "YOUR_BUCKET REGION";
			    String bucketName = "critique-u";
			    String subdirectory = emailTemp + "/";
			    
			    //AWS Access Key ID and Secret Access Key
			    //BasicAWSCredentials awsCreds = new BasicAWSCredentials(accessKeyId, secretAccessKey);
			   
			    //This class connects to AWS S3 for us
			    //AmazonS3 s3client = AmazonS3ClientBuilder.standard().withRegion(region)
			    		//.withCredentials(new AWSStaticCredentialsProvider(awsCreds)).build();
			    @SuppressWarnings("deprecation")
				AmazonS3 s3client = new AmazonS3Client(new ProfileCredentialsProvider());
			    
			    //Specify the file's size
			    ObjectMetadata metadata = new ObjectMetadata();
			    metadata.setContentLength(filePart.getSize());

			    //Create the upload request, giving it a bucket name, subdirectory, filename, input stream, and metadata
			    PutObjectRequest uploadRequest = new PutObjectRequest(bucketName, subdirectory + fileName, fileInputStream, metadata);
			    //Make it public so we can use it as a public URL on the internet
			    uploadRequest.setCannedAcl(CannedAccessControlList.PublicRead);
			    
			    //Upload the file. This can take a while for big files!
			    s3client.putObject(uploadRequest);

			    
				//Create a URL using the bucket, subdirectory, and file name
				//String fileUrl = "http://s3.amazonaws.com/" + bucketName + "/" + subdirectory + "/" + fileName;			
				
				//get other data from the form to submit to the database
				String title = request.getParameter("title");
				String description = request.getParameter("artwork-description");
				String workInProgressString = request.getParameter("work-in-progress");
				String stem = FilenameUtils.removeExtension(fileName);
				String extension = FilenameUtils.getExtension(fileName);
				
				boolean workInProgress = false;
				if(workInProgressString != null)
				{
					if(workInProgressString.equals("on"))
					{
						workInProgress = true;
					}
				}
				
				
				
				//System.out.println(title + " " + stem + " " +  extension + " " +  emailTemp + " " +  description);
				
				///////////////////////
				String sql = "INSERT INTO artwork (email, title, description, datetime, work_in_progress, average_successfulness, image_stem, image_extension) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
				
				
				//This will execute an insert statement, even with nulls. In the future, this could be not allowed, and error message sent back (?)
				PreparedStatement statement;
				try {
					//java.util.Date today = new java.util.Date();
					//String now = new java.sql.Date(today.getTime()).toString();
					
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					java.util.Date date = new java.util.Date();
					
					String now = dateFormat.format(date);
					System.out.println(now);
					
					statement = conn.prepareStatement(sql);
					
					statement.setString(1, emailTemp);
					statement.setString(2, title);
					statement.setString(3, description);
					statement.setString(4, now);
					statement.setBoolean(5, workInProgress); //work in progress (should operate off of a checkbox in upload form)
					statement.setFloat(6, 0.0f);
					statement.setString(7, stem);
					statement.setString(8, extension);
					
					//the result of a SQL query gets returned to ResultSet type object
					statement.executeUpdate();
					
					statement.close();
					
					//set a flag to allow an alert to be displayed that the image was successfully uploaded
					mySession.setAttribute("uploadflag", "success");
					
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					mySession.setAttribute("uploadflag", "failure");
				} finally {
					request.getRequestDispatcher("/loginsuccess.jsp").forward(request, response);
				}
				
				
				
				
				//response.getOutputStream().println("<p>Thanks " + name + "! Here's the image you uploaded:</p>");
				//response.getOutputStream().println("<img src=\"" + fileUrl + "\" />");
				//response.getOutputStream().println("<p>Upload another image <a href=\"http://localhost:8080/index.html\">here</a>.</p>");	
			}
			else{
				//the file was not a JPG or PNG
				response.getOutputStream().println("<p>Please only upload JPG or PNG files.</p>");
				response.getOutputStream().println("<p>Upload another file <a href=\"http://localhost:8080/index.html\">here</a>.</p>");	
			}
			
		}
		else if(action.equals("submitcritique"))
		{
			response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
		    response.setCharacterEncoding("UTF-8"); 
			
		    String criticEmail = (String) mySession.getAttribute("email");
			
			String artistEmail = request.getParameter("artist-email");
			String title = request.getParameter("title");
			
			String compositionRating = request.getParameter("composition-rating");
			String lineRating = request.getParameter("line-rating");
			String formRating = request.getParameter("form-rating");
			String colorRating = request.getParameter("color-rating");
			String craftRating = request.getParameter("craft-rating");
			String successfulnessRating = request.getParameter("successfulness-rating");
			
			String compositionComments = request.getParameter("composition-comments");
			String lineComments = request.getParameter("line-comments");
			String formComments = request.getParameter("form-comments");
			String colorComments = request.getParameter("color-comments");
			String craftComments = request.getParameter("craft-comments");
			String successfulnessComments = request.getParameter("successfulness-comments");
			
			System.out.println("**********");
			System.out.println("critic email: " + criticEmail);
			System.out.println("artwork: " + title + " by " + "artist: " + artistEmail);
			System.out.println("composition: " + compositionRating + ": " + compositionComments);
			System.out.println("line: " + lineRating + ": " + lineComments);
			System.out.println("form: " + formRating + ": " + formComments);
			System.out.println("color: " + colorRating + ": " + colorComments);
			System.out.println("craft: " + craftRating + ": " + craftComments);
			System.out.println("Successfulness: " + successfulnessRating + ": " + successfulnessComments);
			
			
			//insert query into database here
				//first create a prepared statement in jdbc
				// this is a class that encapsulates a SQL statement
				// great thing about it is that wildcards can be used
				// don't ever concatenate this sql statement with username and password, because
				//it will open you up to SQL injection attacks.
		//String sql = "SELECT COUNT(*) AS count FROM user WHERE email=? AND password=?"; // ? character is a wildcard
		//String sql = "INSERT INTO user (email, password) VALUES(?, ?)";
		String sql = "INSERT INTO critique (email, title, criticEmail, composition, compositionComments, line, lineComments, form, formComments, color, colorComments, craft, craftComments, successfulness, comments, datetime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		
		//This will execute an insert statement, even with nulls. In the future, this could be not allowed, and error message sent back (?)
		PreparedStatement statement;
		try {
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			java.util.Date date = new java.util.Date();
			
			String now = dateFormat.format(date);
			
			statement = conn.prepareStatement(sql);
			
			statement.setString(1, artistEmail);
			statement.setString(2, title);
			statement.setString(3, criticEmail);
			statement.setString(4, compositionRating);
			statement.setString(5, compositionComments);
			statement.setString(6, lineRating);
			statement.setString(7, lineComments);
			statement.setString(8, formRating);
			statement.setString(9, formComments);
			statement.setString(10, colorRating);
			statement.setString(11, colorComments);
			statement.setString(12, craftRating);
			statement.setString(13, craftComments);
			statement.setString(14, successfulnessRating);
			statement.setString(15, successfulnessComments);
			statement.setString(16, now);
			
			//the result of a SQL query gets returned to ResultSet type object
			statement.executeUpdate();
			
			statement.close();
			
			//TODO: Now that the critique has been added to the database, 
			//call a helper function to return critiques (most recent first)
			//in JSON format. This will be appended to the bottom of the modal
			
		    response.getWriter().write("success");       // Write response body.
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.getWriter().write("failure");       // Write response body.
		}
		
			//response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
		    //response.setCharacterEncoding("UTF-8"); 
		    //test response
		    //response.getWriter().write("artist email: " + artistEmail);       // Write response body.
		    
		    //request.setAttribute("artist", artistEmail);
			//request.setAttribute("title", title);
			//System.out.println("line before the forward");
			//request.getRequestDispatcher("/imagecritique.jsp").forward(request, response);
		}

		else if(action.equals("logout"))
		{
			//close the database connection
			try
			{
				conn.close();
				account.closeDBConnection();
			}
			catch (SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//invalidate the session
			request.setAttribute("email", null);
			mySession.setAttribute("email", null);
			mySession.setAttribute("loggedin", "false");
			mySession.invalidate();
			request.getRequestDispatcher("/home.jsp").forward(request, response);
		}
		else
		{
			out.println("unrecognized action");
			try
			{
				conn.close();
				account.closeDBConnection();
			}
			catch (SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return;
		}
		
		try
		{
			conn.close();
			account.closeDBConnection();
		}
		catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	protected String loadCritiques(HttpServletRequest request, HttpServletResponse response, int startIndex, String artistEmail, String title)
	{
		String sql = "SELECT * FROM critique AS result WHERE email=? AND title=? ORDER BY datetime DESC LIMIT " + startIndex +", 5"; // ? character is a wildcard
	    
	    //declare and initialize Json object to return
		JSONObject obj = new JSONObject();
	    
		PreparedStatement statement;
		try {
			Connection conn = null;
			conn = ds.getConnection();
			statement = conn.prepareStatement(sql);
			//statement.setString(1, emailTemp);
			
			//the result of a SQL query gets returned to ResultSet type object
			ResultSet rs = statement.executeQuery();
			
			//declare inner Json to hold each of 9 new image data, one at at time
			JSONObject innerObj;
			
			//get context path. This will be included in the returned json so that it can then be used in
				//the javascript function in each artwork modal to link to that image's critique page
			String contextPath = request.getContextPath();
			
			//declare int to iterate over for json
			int jsonIndex = 0;
			
			//the result has an internal pointer that begins before the first entry, so we first must move it up
			while(rs.next())
			{
				innerObj = new JSONObject();
				//innerObj.put("email", emailTemp);
				innerObj.put("title", rs.getString("title"));
				innerObj.put("description", rs.getString("description"));
				innerObj.put("contextPath", contextPath);
				String url = rs.getString("image_stem") + "." + rs.getString("image_extension");
				innerObj.put("url", url);
				//System.out.println(rs.getString("title"));
				obj.put(jsonIndex+"", innerObj);
				jsonIndex++;
			}
			
			System.out.println(obj.toString());

			rs.close();
			statement.close();
			
		
		} catch (SQLException | JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "";
	}

}