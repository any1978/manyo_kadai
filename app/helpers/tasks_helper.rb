module TasksHelper
  def sort_asc(column_to_be_sorted)
    link_to "▲", {:column => column_to_be_sorted, :direction => "asc"}
  end

  def sort_desc(column_to_be_sorted)
    link_to "▼", {:column => column_to_be_sorted, :direction => "desc"}
  end

  def sort_direction
    %W[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def sort_column
    Task.column_names.include?(params[:column]) ? params[:column] : ("end_date" && "priority")
    # Task.column_priorities.include?(params[:column]) ? params[:column] : "priority"
  end

end
