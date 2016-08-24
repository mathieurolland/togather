class ImgcheckInput < SimpleForm::Inputs::Base

  include ActionView::Helpers::AssetTagHelper

  def input
    @builder.boolean(attribute_name, input_html_options) + image_tag().html_safe
  end
end
