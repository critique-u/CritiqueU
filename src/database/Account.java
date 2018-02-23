package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Account
{
	private Connection conn;
	
	public Account(Connection conn)
	{
		this.conn = conn;
	}
	
	public boolean login(String email, String password) throws SQLException
	{
		//first create a prepared statement in jdbc
			// this is a class that encapsulates a SQL statement
			// great thing about it is that wildcards can be used
			// don't ever concatenate this sql statement with username and password, because
			//it will open you up to SQL injection attacks.
		String sql = "SELECT COUNT(*) AS count FROM user WHERE email=? AND password=?"; // ? character is a wildcard
		
		PreparedStatement statement = conn.prepareStatement(sql);
		
		statement.setString(1, email);
		statement.setString(2, password);
		
		//the result of a SQL query gets returned to ResultSet type object
		ResultSet rs = statement.executeQuery();
		
		int count = 0;
		
		//the result has an internal pointer that begins before the first entry, so we first must move it up
		if(rs.next())
			count = rs.getInt("count"); //using the named label of the result. Ordered integers can also be used
		
		rs.close();
		statement.close();
		
		if(count == 0)
			return false;
		else
			return true;
	}
	
	public void create(String email, String password) throws SQLException
	{
		String sql = "INSERT INTO user (email, password) VALUES(?, ?)";
		
		PreparedStatement statement = conn.prepareStatement(sql);
		
		statement.setString(1,  email);
		statement.setString(2, password);
		
		statement.executeUpdate();
		
		statement.close();
	}
	
	public boolean exists(String email) throws SQLException
	{
		System.out.println("checking to see if account already exists...");
		
		String sql = "SELECT COUNT(*) AS count FROM user WHERE email=?";
		
		PreparedStatement statement = conn.prepareStatement(sql);
		
		statement.setString(1, email);
		
		ResultSet rs = statement.executeQuery();
		
		int count = 0;
		
		if(rs.next())
		{
			count = rs.getInt("count");
		}
		
		rs.close();
		statement.close();
		
		if(count == 0)
			return false;
		else
			return true;
	}
	
	public void closeDBConnection()
	{
		try
		{
			conn.close();
		}
		catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}