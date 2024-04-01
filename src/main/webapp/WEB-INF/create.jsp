<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToDo - Create </title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <style>
    .priority-select {
    flex-grow: 1;
    border: none;
    background-color: transparent;
    appearance: none;
    padding: 10px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 5px; /* Add border-radius for rounded corners */
    border: 1px solid #ced4da; /* Add border to provide visual distinction */
}

.priority-select:focus {
    outline: none;
    border-color: #007bff; /* Change border color on focus for better visibility */
}
   
  .priority-bar {
  
    display: flex;
    align-items: center;
    margin-bottom: 20px;
   
    border-radius: 5px;
    background-color: white;
    overflow: hidden;
    /* Add these lines to set initial background color and text color */
    background-color: #ffffff; /* default background color */
    color: #000000; /* default text color */
}

/* Adjust the style based on selected priority */
.priority-bar.priority-high {
    background-color: #F28C28;
    color: #000000;
}

.priority-bar.priority-medium {
    background-color: #6495ED;
    color: #000000;
}

.priority-bar.priority-low {
    background-color: #50C878;
    color: #000000;
}
  
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
            
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #007bff;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            font-weight: bold;
        }
      .status-bar {
            width: 100%;
            height: 60px;
            display: flex;
            justify-content: space-around;
            align-items: center;
            background-color: white;
            border-radius: 8px;
            margin-top: 20px;
            border: 1px solid black;
        }

     .status-item {
            cursor: pointer;
            padding: 10px 20px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            
        }
	.status-item.active {
    		background-color: transparent; /* Set active button background color to transparent */
    color: #007bff; /* Set active button text color */
}

.status-item:hover:not(.active) {
    background-color: #f8f9fa; /* Set button hover background color */
}
      
    </style>
    
    
    
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="form-container">
                <a class="btn btn-primary" href="/home">Home</a>
                <h2>Create New ToDo</h2>
                
                <form:form action="/todo/create" method="post" modelAttribute="newTodo">
                    <form:hidden path="id"/>
                    <form:hidden path="user" value="${userId}"/>

<!-- Description -->
                    <div class="form-group">
                        <label class="form-label" for="description">Description:</label>
                        <form:errors path="description" cssClass="error-message"/>
                        <form:input type="text" path="description" class="form-control"/>
                    </div>
<!-- Status Bar  -->

                    <div class="form-group">
                        <label class="form-label">Status:</label>
                        <div class="status-bar" id="status-bar">
                            <div class="status-item" data-status="TODO">ToDo</div>
                            <div class="status-item" data-status="IN_PROGRESS">In Progress</div>
                            <div class="status-item" data-status="COMPLETED">Completed</div>
                        </div>
                        <input type="hidden" id="status-hidden" name="status" value="">
                    </div>

<!-- Priority bar -->
                    <div class="priority-bar" id="priority-bar">
                        <select class="custom-select priority-select" id="priority" name="priority">
                            <option selected>Select Priority</option>
                            <option value="HIGH">High</option>
                            <option value="MEDIUM">Medium</option>
                            <option value="LOW">Low</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="dueDate">Due Date:</label>
                        <form:errors path="dueDate" cssClass="error-message"/>
                        <form:input type="date" path="dueDate" class="form-control"/>
                    </div>

                    <button class="btn btn-primary btn-block" type="submit">Submit</button>
                </form:form>
            </div>
        </div>
    </div>
</div>
                    

<script>
document.addEventListener("DOMContentLoaded", function() {
    const statusItems = document.querySelectorAll('.status-item');
    const statusHiddenInput = document.getElementById('status-hidden');
    const prioritySelect = document.getElementById('priority');

    statusItems.forEach(item => {
        item.addEventListener('click', () => {
            statusItems.forEach(otherItem => otherItem.classList.remove('active'));
            item.classList.add('active');
            statusHiddenInput.value = item.getAttribute('data-status');
        });
    });

    prioritySelect.addEventListener('change', () => {
        const selectedOption = prioritySelect.options[prioritySelect.selectedIndex];
        const priorityValue = selectedOption.value;
        
        // Remove existing priority classes
        const priorityBar = document.getElementById('priority-bar');
        priorityBar.classList.remove('priority-high', 'priority-medium', 'priority-low');

        // Add class based on selected priority
        if (priorityValue === 'HIGH') {
            priorityBar.classList.add('priority-high');
        } else if (priorityValue === 'MEDIUM') {
            priorityBar.classList.add('priority-medium');
        } else if (priorityValue === 'LOW') {
            priorityBar.classList.add('priority-low');
        }
    });
});


</script>
</body>
</html>


