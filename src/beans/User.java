package beans;

public class User {
	private String email = "";
	private String password = "";
	
	private String message = "";
	
	public String getMessage() {
		return message;
	}

	public User() {
		
	}
	
	public User(String email, String password) {
		this.email = email;
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public boolean validate() {
		
		if(email == null) {
			message = "Error! Invalid email address.";
			return false;
		}
		
		if(password == null) {
			message = "Error! Invalid password.";
			return false;
		}
		
		if(!email.matches("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"))
		{
			message = "Error! Invalid email address.";
			return false;
		}
		
		if(password.length() < 8) {
			message = "Error! Password must be at least 8 characters.";
			return false;
		}
		else if(password.matches("\\w*\\s+\\w*")) {
			message = "Error! Password cannot contain space.";
			return false;
		}
		
		return true;
	}

}