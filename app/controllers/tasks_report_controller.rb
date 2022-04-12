class TasksReportController < ApplicationController
  def index
    @tasks = Task.where(user_id: current_user.id).order(comments: :asc)
  end

  def report
    @tasks = Task.where(user_id: current_user.id)
    respond_to do |format|
      format.html

      format.pdf { 
        render pdf: 'tasks-list-report',
        layout: 'application.pdf.erb',
        template: 'tasks_report/report.pdf.erb'
      }
    end
  end
end
