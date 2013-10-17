class IssueNotifier < ActionMailer::Base
  def marked_as_complete(issue)
    @issue = issue

    mail(to: issue.setter.email, from: issue.assignee.email, subject: 'Issue complete: ' + issue.title)
  end

  def new_task(issue)
    @issue = issue

    mail(to: issue.assignee.email, from: issue.setter.email, subject: 'Issue: ' + issue.title)
  end
end
