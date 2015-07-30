module ApplicationHelper
  # class HTMLwithPygments < Redcarpet::Render::HTML
  #   def block_code(code, language)
  #     sha = Digest::SHA1.hexdigest(code)
  #     Rails.cache.fetch ["code", language, sha].join("-") do
  #       Pygments.highlight(code, lexer: language)
  #     end
  #   end
  # end

  def markdown text
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true, prettify: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      linenums: 40
    }
    # prettyprint
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

  def search_item_path
    return videos_path if controller?("videos")
    return articles_path if controller?("articles")
    return questions_path if controller?("questions")
    return searchs_path
  end

  def search_placeholder
    return t("layouts.header.label.search_video") if controller?("videos")
    return t("layouts.header.label.search_article") if controller?("articles")
    return t("layouts.header.label.search_question") if controller?("questions")
    return t("layouts.header.label.search_all_holder")
  end

  def side_bar
    @random_tags = Tag.order("created_at DESC").limit(6)
    @latest_videos = Video.order("created_at DESC").limit(6) unless controller?("videos")
    @latest_articles = Article.order("created_at DESC").limit(6) unless controller?("articles")
    @latest_question = Question.order("created_at DESC").limit(6) unless controller?("questions")
  end
end
