
package com.billy.todoapp.controllers;


import java.util.List;
import java.util.stream.Collectors;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import com.billy.todoapp.models.Todo;
import com.billy.todoapp.models.TodoPriority;
import com.billy.todoapp.models.TodoStatus;
import com.billy.todoapp.services.TodoService;
import com.billy.todoapp.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class TodoController {

    private final TodoService todoService;
    private final UserService userService;

    public TodoController(TodoService todoService, UserService userService) {
        this.todoService = todoService;
        this.userService = userService;
    }

    @GetMapping("/home")
    public String renderTododashboard(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/logout";
        }

        Long userId = (Long) session.getAttribute("userId");

        List<Todo> todos = todoService.findByUserId(userId);
        List<Todo> firstTodo = todos.stream()
                .filter(todo -> todo.getStatus() == TodoStatus.TODO)
                .collect(Collectors.toList());
        List<Todo> inProgressTodos = todos.stream()
                .filter(todo -> todo.getStatus() == TodoStatus.IN_PROGRESS)
                .collect(Collectors.toList());
        List<Todo> completedTodos = todos.stream()
                .filter(todo -> todo.getStatus() == TodoStatus.COMPLETED)
                .collect(Collectors.toList());

        model.addAttribute("todos", firstTodo);
        model.addAttribute("inProgressTodos", inProgressTodos);
        model.addAttribute("completedTodos", completedTodos);

        model.addAttribute("newTodo", new Todo());
        model.addAttribute("priorities", TodoPriority.values());

        return "home.jsp";
    }

    @GetMapping("/todo/create")
    public String renderCreateTodoForm(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        model.addAttribute("newTodo", new Todo());
        model.addAttribute("userId", userId);
        return "create.jsp";
    }

    @PostMapping("/todo/create")
    public String processCreateForm(
            @Valid @ModelAttribute("newTodo") Todo newTodo,
            BindingResult result,
            @RequestParam("priority") String todoPriority,
            @RequestParam("status") String todoStatus,
            HttpSession session) {
        if (result.hasErrors()) {
            return "create.jsp";
        } else {
            Long userId = (Long) session.getAttribute("userId");
            newTodo.setUser(userService.getUserById(userId));
            newTodo.setPriority(TodoPriority.valueOf(todoPriority));
            newTodo.setStatus(TodoStatus.valueOf(todoStatus)); // Set the status
            
            todoService.createTodo(newTodo);
            return "redirect:/home";
        }
    }


    @GetMapping("/todo/edit/{id}")
    public String renderEditPage(@PathVariable("id") Long id, Model model) {
        model.addAttribute("todo", todoService.oneTodo(id));
        return "editTodo.jsp";
    }

    @PostMapping("/todo/edit/{id}")
    public String processEditAndMoveToNextStatus(@PathVariable("id") Long id, @Valid @ModelAttribute("todo") Todo todo, BindingResult result) {
        if (result.hasErrors()) {
        	System.out.println(result.getAllErrors());
            return "editTodo.jsp";
        } else {
            Todo existingTodo = todoService.oneTodo(id);
            existingTodo.setDescription(todo.getDescription());
            existingTodo.setDueDate(todo.getDueDate());
            existingTodo.setPriority(todo.getPriority());
            existingTodo.setStatus(todo.getStatus());

            if (existingTodo.getStatus() != todo.getStatus()) {
                todoService.moveToNextStatus(id);
            }

            todoService.updateTodo(existingTodo);

            return "redirect:/home";
        }
    }

    @DeleteMapping("/todo/{id}/delete")
    public String processDelete(@PathVariable("id") Long id) {
        todoService.deleteTodo(id);
        return "redirect:/home";
    }
}

    

