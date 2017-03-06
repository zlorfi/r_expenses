module ApplicationHelper
  def nav_bar
    content_tag(:div, class: 'navbar-nav float-right') do
      yield
    end
  end

  def nav_link(text, path)
    link_class = current_page?(path.split('?').first) ? "nav-item nav-link active" : "nav-item nav-link"
    link_to text, path, class: link_class
  end

  def filter_nav_bar
    content_tag(:nav, class: 'nav nav-pills justify-content-center flex-column flex-lg-row') do
      yield
    end
  end

  def filter_links(text, path, additional_classes='')
    standard = 'flex-sm-fill text-sm-center nav-link'
    active = current_page?(path) ? 'active' : ''
    link_to text, path, class: [standard, active, additional_classes].join(' ')
  end

  def set_value(object)
    if object.new_record?
      Date.today
    else
      object.purchesed_on
    end
  end

  def set_alert_type(type)
    case type
    when 'notice'
      'info'
    when 'alert'
      'danger'
    else
      'warning'
    end
  end

  def set_alert_massage(type, msg)
    content_tag(:div, class: "alert alert-#{set_alert_type(type)} alert-dismissible fade show", role: 'alert') do
      concat content_tag(:button, content_tag(:span, '&times;'.html_safe, 'aria-hidden' => 'true'), class: 'close', type: 'button', data: {dismiss: 'alert'}, 'aria-label' => 'Close')
      concat msg
    end
  end
end
