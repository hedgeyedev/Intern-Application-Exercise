# Load the rails application
require File.expand_path('../application', __FILE__)

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if instance.error_message.kind_of?(Array)
    %(<div class="field-error">#{html_tag}<div class="error-message">&nbsp;
      #{instance.error_message.join(',')}</div></div>).html_safe
  else
    %(<div class="field-error">#{html_tag}<div class="error-message">&nbsp;
      #{instance.error_message}</div></div>).html_safe
  end
end

# Initialize the rails application
Blog::Application.initialize!
