class ToDoNotifier < ActionMailer::Base
  def marked_as_complete(to_do)
    @to_do = to_do

    mail(to: to_do.setter.email, from: to_do.assignee.email, subject: 'To-do complete: ' + to_do.title)
  end

  def new_task(to_do)
    @to_do = to_do

    mail(to: to_do.assignee.email, from: to_do.setter.email, subject: 'To-do: ' + to_do.title)
  end
end
