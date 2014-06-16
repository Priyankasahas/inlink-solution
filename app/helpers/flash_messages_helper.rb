module FlashMessagesHelper
  def flash_messages?
    %w(notice warning error alert success info).each do |msg|
      return true unless flash[msg.to_sym].blank?
    end
    false
  end

  def flash_messages(classes = "")
    [].tap do |messages|
      {
          :notice => "alert alert-info",
          :info => "alert alert-info",
          :success => "alert alert-success",
          :alert => "alert alert-danger",
          :warning => "alert alert-warning",
          :error => "alert alert-danger",
      }.each_pair do |type,alert_class|
        unless flash[type].blank?
          message_class = ["alert fade in"]
          message_class << "alert-#{alert_class}"
          message_class << classes unless classes.blank?
          messages << content_tag(:div, content_tag(:a, "&times;".html_safe, :href => "#", :class => "close", "data-dismiss" => "alert") + flash[type], :class => message_class.join(" "))
        end
      end
    end.join.html_safe
  end

  def js_flash_messages
    "js_flash_messages('#{escape_javascript flash_messages}');".html_safe
  end
end