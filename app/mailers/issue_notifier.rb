class IssueNotifier < ActionMailer::Base
  helper :issues

  def marked_as_complete(issue)
    @issue = issue

    mail(to: issue.setter.email, from: issue.assignee.email, subject: issue_subject(issue))
  end

  def new_task(issue)
    @issue = issue

    mail(to: issue.assignee.email, from: issue.setter.email, subject: issue_subject(issue))
  end

  def new_comment(comment, watcher)
    @issue = comment.issue
    @comment = comment
    mail(to: watcher.email, from: 'noreply@yesl.info', subject: issue_subject(comment.issue))
  end

  def issue_subject(issue)
    "[YeSL] Issue #{issue}"
  end
end
