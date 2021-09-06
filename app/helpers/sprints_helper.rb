module SprintsHelper
  def sprint_start_date_label
    if !@sprint.start_date.nil? && @sprint.start_date < Date.today
      t('shared.started_on')
    else
      t('shared.starting_on')
    end
  end

  def sprint_end_date_label
    if !@sprint.end_date.nil? && @sprint.end_date < Date.today
      t('shared.ended_on')
    else
      t('shared.due_on')
    end
  end
end
