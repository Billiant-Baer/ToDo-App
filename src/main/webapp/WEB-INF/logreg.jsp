<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToDo - Home</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/style.css">
</head>
<body>
<div class="header" id="header">
    Your Best ToDo Planner Ever 
</div>

<div class="welcome-section">
    <div class="welcome-text">
        <span class="main-text">Welcome to ToDo List</span>
        <br>
        <span class="sub-text">Your Personal Organizer for Daily, Weekly, and Yearly Tasks</span>
        <br>
    </div>
</div>


<div class="scroll-down" onclick="scrollToContent()">
    &#8595;
</div>

<div class="container mt-5" id="content">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <!-- Login Form -->
            <form:form action="/login" method="post" modelAttribute="newLogin">
                <div class="custom-card slide-down" id="authCard">
                    <div class="card-body">
                        <h2 class="text-center mb-4" id="authTitle">Log In</h2>
                        <p>
                            <form:label path="email">Email:</form:label>
                            <form:errors path="email"/>
                            <form:input type="email" path="email" class="form-control"/>
                        </p>
                        <p>
                            <form:label path="password">Password:</form:label>
                            <form:errors path="password"/>
                            <form:password path="password" class="form-control"/>
                        </p>
                        <button type="submit" class="btn btn-primary btn-block">Log In</button>
                        <p class="mt-3">Don't have an account? <a id="registerLink" href="/register">Register here.</a></p>
                    </div>
                </div>
            </form:form>

            <!-- Registration Form -->
            <form:form action="/register" method="post" modelAttribute="newUser">
                <div class="custom-card slide-down" id="registerCard">
                    <div class="card-body">
                        <h2 class="text-center mb-4" id="registerTitle">Register</h2>
                        <p>Please make sure that passwords match,</p> 
                        <p>If not you will be redirected to home and have to click register again to see errors</p>
                       
                        <p>
                            <form:label path="userName">User Name:</form:label>
                            <form:errors path="userName"/>
                            <form:input type="text" path="userName" class="form-control"/>
                        </p>
                        <p>
                            <form:label path="email">Email:</form:label>
                            <form:errors path="email"/>
                            <form:input type="email" path="email" class="form-control"/>
                        </p>
                        <p>
                            <form:label path="password">Password:</form:label>
                            <form:errors path="password"/>
                            <form:password path="password" class="form-control"/>
                        </p>
                        <p>
                            <form:label path="confirm">Confirm Password:</form:label>
                            <form:errors path="confirm"/>
                            <form:password path="confirm" class="form-control"/>
                        </p>
                        <button type="submit" class="btn btn-primary btn-block">Register</button>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>


<div class="banner">
    Bottom Banner Content Here
</div>

<script>
    function scrollToContent() {
        const content = document.getElementById('content');
        content.scrollIntoView({ behavior: 'smooth' });
    }

    document.addEventListener('DOMContentLoaded', function() {
        const authTitle = document.getElementById('authTitle');
        const authCard = document.getElementById('authCard');
        const registerCard = document.getElementById('registerCard');
        const registerLink = document.getElementById('registerLink');

        // Initially hide the register form
        registerCard.classList.add('hidden');

        // Add click event listener to the register link
        registerLink.addEventListener('click', function(event) {
            event.preventDefault(); // Prevent the default action of the link

            if (registerCard.classList.contains('hidden')) {
                // Show register form
                registerCard.classList.remove('hidden');
                authCard.classList.add('hidden');
                authTitle.innerText = "Register";
                registerLink.innerText = "Back to Log In";
            } else {
                // Show login form
                registerCard.classList.add('hidden');
                authCard.classList.remove('hidden');
                authTitle.innerText = "Log In";
                registerLink.innerText = "Don't have an account? Register here.";
            }
        });
    }); 

</script>


</body>
</html>



