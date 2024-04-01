<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToDo - Edit</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
     <style>
        .status-bar {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: space-around;
            align-items: center;
            background-color: white;
            border: 1px solid black;
            border-radius: 8px;
            margin-top: 10px;
            margin-bottom: 10px;
        }

        .status-item {
            cursor: pointer;
            padding: 10px 10px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .status-item.active {
            background-color: #007bff; /* Set active button background color to blue */
            color: black; /* Set active button text color to white */
        }

        .status-item:hover:not(.active) {
            background-color: #f8f9fa; /* Set button hover background color */
        }

        /* Media query for mobile devices */
        @media only screen and (max-width: 600px) {
            .status-bar {
                flex-direction: column;
                height: auto; /* Adjust height to fit content */
            }

            .status-item {
                margin-bottom: 5px; /* Add spacing between buttons */
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="form-container">
                <h2>Edit ToDo</h2>
                <form:form action="/todo/edit/${id}" method="post" modelAttribute="todo" id="status-form">
                    <form:hidden path="id" />
                    <form:hidden path="user"/>
                    <form:hidden path="priority" />

                    <div class="form-group">
                        <label class="form-label" for="description">Description:</label>
                        <form:hidden path="description" />
                        <span>${todo.description}</span> <!-- Display description as plain text -->
                    </div>

                    <div class="status-bar" id="status-bar">
                        <button type="button" class="status-item" data-status="TODO">To-Do</button>
                        <button type="button" class="status-item" data-status="IN_PROGRESS">In Progress</button>
                        <button type="button" class="status-item" data-status="COMPLETED">Completed</button>

                        <input type="hidden" name="status" id="status-hidden" value="${todo.status}" />
                        
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const statusItems = document.querySelectorAll('.status-item');
    const statusHiddenInput = document.getElementById('status-hidden');

    // Function to remove 'active' class from all buttons
    function removeActiveClass() {
        statusItems.forEach(item => {
            item.classList.remove('active');
        });
    }

    statusItems.forEach(item => {
        item.addEventListener('click', (event) => {
            console.log('Button clicked!'); // Check if button click event is being triggered
            event.preventDefault(); // Prevent default form submission behavior
            
            // Remove 'active' class from all buttons
            removeActiveClass();
            
            // Add 'active' class to the clicked button
            item.classList.add('active');
            
            // Set the new status in the hidden input
            const newStatus = item.getAttribute('data-status');
            statusHiddenInput.value = newStatus;

            // Submit the form
            document.getElementById('status-form').submit();
        });
    });
});

</script>


</body>
</html>

