class ConstrainIssuePriorities < ActiveRecord::Migration
  def change
    if defined?(Issue)
      Issue.where('priority < 1').update_all('priority = 1')
      Issue.where('priority IS NULL').update_all('priority = 3')
      Issue.where('priority > 5').update_all('priority = 5')
    end
  end
end
