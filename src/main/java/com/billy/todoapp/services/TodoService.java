package com.billy.todoapp.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.billy.todoapp.models.Todo;
import com.billy.todoapp.models.TodoPriority;
import com.billy.todoapp.models.TodoStatus;
import com.billy.todoapp.repostiories.TodoRepository;



	@Service
	public class TodoService {
		private final TodoRepository todoRepo;
		public TodoService(TodoRepository todoRepo) {
			this.todoRepo = todoRepo;
			
			
		}
		

		// FIND ALL
			public List<Todo> getAllTodos(){
				return todoRepo.findAll();
			}
			
			// Create a todo
			public Todo createTodo(Todo newTodo) {
				return todoRepo.save(newTodo);
			}

			// find one
			public Todo oneTodo(Long id) {
				Optional<Todo> optionalTodo = todoRepo.findById(id);
				if(optionalTodo.isPresent()) {
					return optionalTodo.get();
				}else {
					return null;
				}	
			}
			
			// Update
			public Todo updateTodo(Todo oneTodo) {
				return todoRepo.save(oneTodo);
			}
			
			// DELETE
			public void deleteTodo(Long id) {
				todoRepo.deleteById(id);
			}
//			find todo by status 
			public List<Todo> getTodosByStatus(TodoStatus status) {
		        return todoRepo.findByStatus(status);
		    }
			
			public void moveToNextStatus(Long todoId) {
			    Todo todo = todoRepo.findById(todoId).orElseThrow();

			    if (todo.getStatus() == TodoStatus.TODO) {
			        todo.setStatus(TodoStatus.IN_PROGRESS);
			        // Check the priority and update it if necessary
			        if (todo.getPriority() == TodoPriority.HIGH) {
			            todo.setPriority(TodoPriority.MEDIUM);
			        }
			    } else if (todo.getStatus() == TodoStatus.IN_PROGRESS) {
			        todo.setStatus(TodoStatus.COMPLETED);
			        // Update priority to low when moving from IN PROGRESS to COMPLETED
			        todo.setPriority(TodoPriority.LOW);
			    }

			    // Instead of saving a new todo, update the existing one
			    todoRepo.save(todo);
			}


			 public List<Todo> findByUserId(Long userId) {
			        return todoRepo.findByUserId(userId);
			    }


			
			
			}
	

	
	
	

