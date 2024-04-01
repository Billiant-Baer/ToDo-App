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
   
 

<style>
        body {
            font-family: Arial, sans-serif;
            background-color: white;
            margin: 0;
            padding: 0;
        }

        .welcome-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .container {
            text-align: center;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
        }

        .todo-list {
            width: calc(33.33% - 20px);
            margin: 0 10px;
            box-sizing: border-box;
            height: 400px;
            overflow-y: auto;
        }

        .todo-tile {
            position: relative;
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
            overflow: hidden;
            transition: transform 0.2s ease;
        }

        .todo-tile:hover {
            transform: translateY(-5px);
        }

        .todo-tile:hover .todo-button-group {
            opacity: 1;
        }

        .todo-details {
            color: black;
        }

        .todo-priority-high {
            background-color: #F28C28;
        }

        .todo-priority-medium {
            background-color: #6495ED;
        }

        .todo-priority-low {
            background-color: #50C878;
        }

        .todo-description {
            font-size: 1.1em;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .todo-due-date {
            font-size: .8em;
            color: black;
        }

        .todo-button-group {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            justify-content: center;
            width: calc(100% - 40px);
            opacity: 0;
        }

        .todo-button-group button:hover {
            background-color: #ddd;
        }

        #createLink {
            display: block;
            width: 200px;
            margin: 10px auto;
            font-size: 15px;
        }

        /* Media query for mobile devices */
        @media only screen and (max-width: 600px) {
            .container {
                flex-direction: column;
            }

            .todo-list {
                width: calc(100% - 20px);
                margin: 0 10px;
            }
        }
    </style>
</head>
<body>
    <h1 style="text-align: center; margin: 15px;">Welcome, <c:out value="${userName}"/></h1>
    <div style="text-align: center;">
        <a class="btn btn-outline-primary" href="/todo/create" id="createLink">Create a To-Do list</a>
      <form action="/logout" method="get">
    <button type="submit" class="btn btn-outline-danger">Logout</button>
</form>
</div>
    <div class="container">
        <div class="todo-list">
            <h2>ToDo</h2>
            <c:forEach var="todo" items="${todos}">
               
                    <div class="todo-tile todo-priority-${todo.priority.toString().toLowerCase()}">
                        <div class="todo-details">
                            <div class="todo-description">${todo.description}</div>
                            	<div class="todo-due-date"> Due Date:  
                    				 <script>
       					 				var dueDate = new Date("${todo.dueDate}");
        									 var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
       											 document.write(dueDate.toLocaleDateString('en-US', options));
    									</script>
								</div>              
                        	<div class="todo-button-group">
                            <a class="btn btn-primary todo-button " href="/todo/edit/${todo.id}">Edit</a>
         				 </div>
                   	 	</div>
                	</div>
                
            </c:forEach>
        </div>
        
        <div class="todo-list">
            <h2>In Progress</h2>
            <c:forEach var="todo" items="${inProgressTodos}">
                <div class="todo-tile todo-priority-${todo.priority.toString().toLowerCase()}">
                    <div class="todo-details">
                        <div class="todo-description">${todo.description}</div>
                        	<div class="todo-due-date"> Due Date: 
                        		<script>
       				 				var dueDate = new Date("${todo.dueDate}");
       				 				var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
       				 				document.write(dueDate.toLocaleDateString('en-US', options));
    							</script>
							</div>
                        <div class="todo-button-group">
                            <a class="btn btn-primary" href="/todo/edit/${todo.id}">Edit</a>
                            
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <div class="todo-list">
            <h2>Completed </h2>
            <c:forEach var="todo" items="${completedTodos}">
                <div class="todo-tile todo-priority-${todo.priority.toString().toLowerCase()}">
                    <div class="todo-details">
                        <div class="todo-description">${todo.description}</div>
                        	<div class="todo-due-date">Due Date: 
                        		<script>
        							var dueDate = new Date("${todo.dueDate}");
        							var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
       					 			document.write(dueDate.toLocaleDateString('en-US', options));
    							</script>
							</div>
                        	<div class="todo-button-group">
                            	<form action="/todo/${todo.id}/delete" method="POST">
                                	<input type="hidden" name="_method" value="DELETE" />
                                	<button type="submit" class="btn btn-primary">Delete</button>
                            	</form>
                       		 </div>
                    	</div>
               	 </div>
            	</c:forEach>
       	 </div>
    	</div>
    
    
</body>

</html>









