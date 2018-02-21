<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<title>Critique U - Create Account</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/util.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
<!--===============================================================================================-->
<style>
	.my-login-error
	{
		color: red;
		text-align: center;
	}

</style>
</head>
<body>

	<div class="bg-contact2" style="background-image: url('${pageContext.request.contextPath}/images/bg-02.jpg');">
		<div class="container-contact2">
			<div class="wrap-contact2">
				<form class="contact2-form validate-form" method="post" action="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=createaccount") %>"">
					<span class="contact2-form-title" style="padding-bottom: 50px !important; font-size: 24px !important; font-family: Poppins-Regular !important;">
						<img src="${pageContext.request.contextPath}/images/critique-u-vector-serif.svg" height="80px" style="margin-bottom: 40px;"/>
						<br/>Create a New Account
						<p>Already have an account? <a href="<%= response.encodeUrl(request.getContextPath() + "/Controller?action=login") %>">Log in</a>.</p>
					</span>
					<input type="hidden" name="action" value="createaccount" />
					<div class="wrap-input2 validate-input">
						<input class="input2" type="text" name="email" value="<%= request.getAttribute("email") %>" autofocus/>
						<span class="focus-input2" data-placeholder="EMAIL"></span>
					</div>

					<div class="wrap-input2 validate-input">
						<input class="input2" type="password" name="password" value=""/>
						<span class="focus-input2" data-placeholder="PASSWORD"></span>
					</div>
					
					<div class="wrap-input2 validate-input" data-validate = "Please re-type your password.">
						<input class="input2" type="password" name="repeatpassword" value=""/>
						<span class="focus-input2" data-placeholder="REPEAT PASSWORD"></span>
					</div>
					<p class="my-login-error"><%= request.getAttribute("message") %></p>
					<div class="container-contact2-form-btn">
						<div class="wrap-contact2-form-btn">
							<div class="contact2-form-bgbtn"></div>
							<button type="submit" class="contact2-form-btn">CREATE MY ACCOUNT</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>




<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/popper.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/js/main.js"></script>

	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());

	  gtag('config', 'UA-23581568-13');
	</script>

</body>
</html>
