 <head>
<meta charset="UTF-8">
<title>Login Register Panel</title>
<script type="text/javascript">
	function loginValidation() {
		var email = document.getElementById("email").value;
		var password = document.getElementById("login-password").value;
		var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
		var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,12}$/;

		if (email === '') {
			alert("Please enter your email");
			document.getElementById("email").focus();
			return false;
		}
		if (!emailRegex.test(email)) {
			alert("Please enter a valid email");
			document.getElementById("email").focus();
			return false;
		}
		if (password === '') {
			alert("Please enter your password");
			document.getElementById("login-password").focus();
			return false;
		}
		if (!passwordRegex.test(password)) {
			alert("Password should contain at least 1 uppercase letter, 1 lowercase letter, 1 special character, and be 8-12 characters long");
			document.getElementById("login-password").focus();
			return false;
		}
		return true;
	}
	function registerValidation() {
	    var email = document.getElementById("register-email").value;
	    var phone = document.getElementById("register-phone").value;
	    var password = document.getElementById("register-password").value;
	    var confirmpassword = document.getElementById("confirmpassword").value;

	    var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
	    var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,12}$/;
	    var phoneRegex = /^[6-9]\d{9}$/;

	    if (email === '') {
	        alert("Please enter your email");
	        document.getElementById("register-email").focus();
	        return false;
	    }
	    if (!emailRegex.test(email)) {
	        alert("Please enter a valid email");
	        document.getElementById("register-email").focus();
	        return false;
	    }

	    if (phone === '') {
	        alert("Please enter your phone number");
	        document.getElementById("register-phone").focus();
	        return false;
	    }
	    if (!phoneRegex.test(phone)) {
	        alert("Please enter a valid 10-digit Indian phone number starting with 6, 7, 8, or 9");
	        document.getElementById("register-phone").focus();
	        return false;
	    }

	    if (password === '') {
	        alert("Please enter your password");
	        document.getElementById("register-password").focus();
	        return false;
	    }
	    if (!passwordRegex.test(password)) {
	        alert("Password should contain at least 1 uppercase letter, 1 lowercase letter, 1 special character, and be 8-12 characters long");
	        document.getElementById("register-password").focus();
	        return false;
	    }
	    if (confirmpassword === '') {
	        alert("Please re-enter your password");
	        document.getElementById("confirmpassword").focus();
	        return false;
	    }
	    if (confirmpassword !== password) {
	        alert("Passwords do not match");
	        document.getElementById("confirmpassword").focus();
	        return false;
	    }
	    return true;
	}


	function togglePassword(id) {
		const passwordField = document.getElementById(id);
		const icon = document.getElementById(id + '-toggle');

		if (passwordField.type === "password") {
			passwordField.type = "text";
			icon.classList.remove("fa-eye");
			icon.classList.add("fa-eye-slash");
		} else {
			passwordField.type = "password";
			icon.classList.remove("fa-eye-slash");
			icon.classList.add("fa-eye");
		}
	}
</script>
<!-- CSS and Libraries -->
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Mukta"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">

<style>
/* Theme Variables */
:root {
    --primary-bg: #dc3545; /* Updated to your requested color */
    --secondary-bg: rgba(255, 255, 255, 1); /* Light theme background */
    --text-color: rgba(50, 50, 50, 1); /* Darker text for light theme */
    --input-border: #b5b5b5; /* Light input border */
    --button-bg: #444444; /* Button background */
    --button-text: #f9f9f9; /* Button text color */
    --panel-shadow: 0 0 10px 3px rgba(0, 0, 0, 0.1); /* Lighter panel shadow */
    --danger-color: #dc3545; /* Danger color */
}

body.dark-theme {
    --primary-bg: #e60000; /* Lightened dark primary background */
    --secondary-bg: rgba(70, 70, 70, 1); /* Slightly lighter dark theme background */
    --text-color: rgba(240, 240, 240, 1); /* Lighter text color for dark theme */
    --input-border: #999999; /* Lighter border for input */
    --button-bg: #666666; /* Slightly lighter button background */
    --button-text: #ffffff; /* Button text remains white */
    --panel-shadow: 0 0 10px 3px rgba(255, 255, 255, 0.2); /* Lighter panel shadow for dark theme */
}

/* Body Styling */
body {
    font-family: 'Mukta', sans-serif;
    height: 100vh;
    min-height: 550px;
    background: var(--primary-bg)
        url(http://www.planwallpaper.com/static/images/Free-Wallpaper-Nature-Scenes.jpg)
        no-repeat center/cover;
    color: var(--text-color);
    overflow-y: hidden;
    transition: background-color 0.3s, color 0.3s;
}

/* Danger Class Styling */
.text-danger {
    color: var(--danger-color) !important;
}

.card-header, .btn-danger {
    background-color: var(--danger-color);
    border-color: var(--danger-color);
}

/* Link Styling */
a {
    text-decoration: none;
    color: var(--text-color);
}

/* Login/Register Panel Styling */
.login-reg-panel {
    position: relative;
    top: 50%;
    transform: translateY(-50%);
    text-align: center;
    width: 70%;
    right: 0;
    left: 0;
    margin: auto;
    height: 400px;
    background-color: var(--primary-bg);
    box-shadow: var(--panel-shadow);
    transition: background-color 0.3s, box-shadow 0.3s;
    border-radius: 15px; /* Rounded corners */
}

.white-panel {
    background-color: var(--secondary-bg);
    height: 500px;
    position: absolute;
    top: -50px;
    width: 50%;
    right: calc(50% - 50px);
    z-index: 0;
    box-shadow: var(--panel-shadow);
    transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
    border-radius: 15px; /* Rounded corners */
}

.login-reg-panel input[type="radio"] {
    position: relative;
    display: none;
}

.login-reg-panel {
    color: var(--text-color);
}

.login-reg-panel #label-login, .login-reg-panel #label-register {
    border: 1px solid var(--input-border);
    padding: 5px 5px;
    width: 150px;
    display: block;
    text-align: center;
    border-radius: 10px;
    cursor: pointer;
    font-weight: 600;
    font-size: 18px;
    transition: border-color 0.3s, color 0.3s;
}

.login-info-box, .register-info-box {
    width: 30%;
    padding: 0 50px;
    top: 20%;
    position: absolute;
    text-align: left;
    color: rgba(50, 50, 50, 1)
}

.login-info-box {
    left: 0;
}

.register-info-box {
    right: 0;
    color: rgba(50, 50, 50, 1);
}

.right-log {
    right: 50px !important;
}

.login-show, .register-show {
    z-index: 1;
    display: none;
    opacity: 0;
    color: var(--text-color);
    text-align: left;
    padding: 50px;
    transition: opacity 0.3s, transform 0.3s;
}

.show-log-panel {
    display: block;
    opacity: 1;
    transform: translateY(0);
}

.login-show input[type="text"], .login-show input[type="password"],
.register-show input[type="text"], .register-show input[type="password"] {
    width: 100%;
    display: block;
    margin: 20px 0;
    padding: 15px;
    border: 1px solid var(--input-border);
    outline: none;
    transition: border-color 0.3s;
    border-radius: 10px; /* Rounded corners for inputs */
}

.login-show input[type="button"], .register-show input[type="button"] {
    max-width: 150px;
    width: 100%;
    background: var(--button-bg);
    color: var(--button-text);
    border: none;
    padding: 10px;
    text-transform: uppercase;
    border-radius: 5px; /* Rounded corners for buttons */
    float: right;
    cursor: pointer;
    transition: background-color 0.3s, color 0.3s;
}

.login-show a {
    display: inline-block;
    padding: 10px 0;
}

/* Footer Credit */
.credit {
    position: absolute;
    bottom: 10px;
    left: 10px;
    color: var(--text-color);
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    text-transform: uppercase;
    font-size: 12px;
    font-weight: bold;
    letter-spacing: 1px;
    z-index: 99;
}

/* Password Container */
.password-container {
    position: relative;
    width: 100%;
}

.password-toggle {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: var(--text-color);
}

/* Animations */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.login-show, .register-show {
    animation: fadeIn 0.5s ease-in-out;
}

.white-panel {
    animation: fadeIn 0.5s ease-in-out;
}
 .text-danger {
            color: #dc3545 !important;
        }
        .forgot-password {
    display: block;
    text-align: right;
    margin-top: 10px;
}

.btn-rounded {
    background-color: #dc3545;
    color: white;
    width: 120px;
    height: 40px;
    border-radius: 20px; /* Rounded corners */
    border: none; /* Optional: removes border if you want */
}


</style>

</head>
<body style="background-color: white;">
	<div class="login-reg-panel">
		<div class="login-info-box" style="color: white;">
			<h2>Have an account?</h2>
			<p>Welcome back! Log in to continue.</p>
			<label id="label-register" for="log-reg-show">Login</label> <input
				type="radio" name="active-log-panel" id="log-reg-show"
				checked="checked">
		</div>

		<div class="register-info-box" style="color: white;">
			<h2>Don't have an account?</h2>
			<p>Create an account to get started.</p>
			<label id="label-login" for="log-login-show">Register</label> <input
				type="radio" name="active-log-panel" id="log-login-show">
		</div>

		<div class="white-panel">
			<!-- Login Form -->
			<form onsubmit="return loginValidation()" action="loginAction.jsp">
				<div class="login-show">
					<h2 class="text-danger">Login</h2>
					<input type="text" id="email" name="email" placeholder="Email">
					<div class="password-container">
						<input type="password" id="login-password" name="login-password"
							placeholder="Password"> <i id="login-password-toggle"
							class="fas fa-eye password-toggle"
							onclick="togglePassword('login-password')"></i>
					</div>
					<div style="text-align: right;"> <a class="text-danger" href="forgotpassword.jsp" style="text-align: right;">Forgot
						password?</a></div>
					<input type="submit" value="Login"
						style="background-color: #dc3545; color: white; width: 150px; height: 40px; border-radius: 10px">
						
						
				</div>
			</form>

			<!-- Register Form -->
			<form action="regiesterAction.jsp" onsubmit="return registerValidation()">
				<div class="register-show">
					<h2 class="text-danger">Register</h2>
					<input type="text" id="register-email" name="register-email"
						placeholder="Email"> 
						<input type="text"
						id="register-phone" name="register-phone"
						placeholder="Phone Number">

					<div class="password-container">
						<input type="password" id="register-password" name="register-password"
							placeholder="Password"> <i id="register-password-toggle"
							class="fas fa-eye password-toggle"
							onclick="togglePassword('register-password')"></i>
					</div>
					<div class="password-container">
						<input type="password" id="confirmpassword" name="confirmpassword"
							placeholder="Confirm Password"> <i
							id="confirmpassword-toggle" class="fas fa-eye password-toggle"
							onclick="togglePassword('confirmpassword')"></i>
					</div>
					<input type="submit" value="Register" style="background-color: #dc3545; color: white; width: 150px; height: 40px; border-radius: 10px">
				</div>
			</form>
		</div>
	</div>

	<!-- jQuery for toggling panels -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script>
		$(document).ready(function() {
			$('.login-info-box').fadeOut();
			$('.login-show').addClass('show-log-panel');
		});

		$('.login-reg-panel input[type="radio"]').on('change', function() {
			if ($('#log-login-show').is(':checked')) {
				$('.register-info-box').fadeOut();
				$('.login-info-box').fadeIn();
				$('.white-panel').addClass('right-log');
				$('.register-show').addClass('show-log-panel');
				$('.login-show').removeClass('show-log-panel');
			} else if ($('#log-reg-show').is(':checked')) {
				$('.register-info-box').fadeIn();
				$('.login-info-box').fadeOut();
				$('.white-panel').removeClass('right-log');
				$('.login-show').addClass('show-log-panel');
				$('.register-show').removeClass('show-log-panel');
			}
		});
	</script>
</body>
</html>
