module ApplicationHelper
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join("-") do
        Pygments.highlight(code, lexer: language)
      end
    end
  end

  def markdown text
    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe    
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end
 
  def action?(*action)
     action.include?(params[:action])
  end
  
  def link_to_add_fields label, f, assoc
    new_obj = f.object.class.reflect_on_association(assoc).klass.new
    fields = f.fields_for assoc, new_obj,child_index: "new_#{assoc}" do |builder|
      render "#{assoc.to_s.singularize}_fields", f: builder
    end
    
    link_to label, "#", onclick: "add_fields(this, \"#{assoc}\",
            \"#{escape_javascript(fields)}\")", remote: true
  end
  
  def link_to_remove_fields label, f
    field = f.hidden_field :_destroy
    link = link_to label, "#", onclick: "remove_fields(this)", remote: true
    field + link
  end

  def nested_comments comments
     comments.map do |comment, sub_comments|
        content_tag(:div, render(comment), :class => "media")       
     end.join.html_safe
  end

  def full_title(title)
    base_title = t("app_title")
    if title.blank?
      base_title
    else
      "#{base_title} | #{title}"
    end
  end
end
