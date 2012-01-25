module ApplicationHelper

  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true)
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

  # TODO: find adequate algorithm
  def minutes_to_units minutes
    hh, mm = minutes.divmod(60)
    dd, hh = hh.divmod(24)
    res = ''
    if (dd > 0)
      res << "#{dd} days"
    end
    if (hh > 0)
      res << "#{hh} hours"
    end
    if (mm > 0)
      res << "#{mm} minutes"
    end
    res
  end

  def due_date_in_words date
    now = Time.now
    if (date < (now + 5.days)) && (date > (now - 5.days))
      date.strftime "%A"
    else
      l date, :format => "%A %d %b"
    end
  end

end
