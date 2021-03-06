require "date"

class Todo
  def initialize(text, due_date, completed)
    @text = text           #set the todo text to instance variable
    @due_date = due_date   #set the due_date to @due_date instance variable
    @completed = completed  #set the completed boolean value to @complete instance variable
  end

  def overdue?
    Date.today > @due_date  #check the due_date that date is today or not
  end

  def due_today?
    Date.today == @due_date  #check the due_date that date is today or not
  end

  def due_later?
    Date.today < @due_date  #check the due_date that date is today or later
  end

  def to_displayable_string
    display_status = @completed ? "[X]" : "[ ]" #check the complete if the complete is true [x] will show if complete is false it will show [] this
    display_date = due_today? ? "" : @due_date  # theck the date is today or not if is today date will not print if is not today date the given date will print
    return "#{display_status} #{@text} #{display_date}" # concat the all strings then return
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  def add(new_todo)
    @todos.push(new_todo) #add latest todo
  end

  def to_displayable_list
    @todos.map { |todo| todo.to_displayable_string } #display the todo
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)
todos_list.to_displayable_list
todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
