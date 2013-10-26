module ApplicationHelper

  def markdown(text)
    options = { hard_wrap: true, filter_html: true, autolink: true,
               no_intraemphasis: true, fenced_code: true, gh_blockcode: true }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("/" + association.to_s + "/" + association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, ("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end

  def due_date_in_words date
    now = Time.now
    if (date < (now + 1.days)) && ( date > (now - 1.days ))
      t :today
    elsif (date < (now + 5.days)) && (date > (now - 5.days))
      date.strftime "%A"
    else
      l date, :format => "%A %d %b"
    end
  end

end
