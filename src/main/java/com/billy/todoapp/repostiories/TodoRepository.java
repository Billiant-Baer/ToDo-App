package com.billy.todoapp.repostiories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
 

import com.billy.todoapp.models.Todo;
import com.billy.todoapp.models.TodoStatus;

@Repository
public interface TodoRepository extends CrudRepository<Todo, Long> {
	List<Todo> findAll();

	List<Todo> findByStatus(TodoStatus status);
	

	List<Todo> findByUserId(Long userId);

	
}



