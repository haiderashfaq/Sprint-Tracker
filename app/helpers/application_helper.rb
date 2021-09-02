module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type

    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-success'
    else
      flash_type.to_s
    end
  end
end
