module BaseHelper
  def sort_link column, title = nil
    title ||= column.titleize
    column = column.downcase.parameterize.underscore
    dir = column == sort_col && sort_dir == "asc" ? "desc" : "asc"
    icon = sort_dir == "asc" ? "fa fa-chevron-up" : "fa fa-chevron-down"
    icon = column == sort_col ? icon : ""
    link_to "#{title} <span class='#{icon}'></span>".html_safe,
      sort: column, direction: dir
  end

  def link_to_remove_fields name, form
    form.check_box(:_destroy) + link_to(name, "remove_fields(this)")
  end

  def link_to_add_fields name, form, association
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for association, new_object, child_index: id do |build|
      render(association.to_s.singularize + "_fields", f: build)
    end
    link_to(name, "#", id: "add_fields",
      data: {id: id, fields: fields.gsub('\n', "")})
  end
end
