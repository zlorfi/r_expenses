module ApplicationHelper
  def nav_bar
    content_tag(:div, class: 'navbar-nav float-right') do
      yield
    end
  end

  def nav_link(text, path)
    link_class = current_page?(path) ? "nav-item nav-link active" : "nav-item nav-link"
    link_to text, path, class: link_class
  end
end
