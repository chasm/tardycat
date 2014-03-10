module ApplicationHelper

  def flash_noty_script_tag
    unless flash.empty?
      noties = flash.map do |name, message|
        if message.is_a?(String) || message.is_a?(ActiveModel::Errors)
          type = ( name == :notice ? "success" : "error" )
          timeout = ( name == :notice ? 4000 : 30000 )
          text = ( message.is_a?(ActiveModel::Errors) ? "It's an error object" : message )

          "noty({ layout: 'top', type: '" + type +
          "', timeout: " + timeout.to_s +
          ", text: \"" + text +
          "\"});"
        end
      end

      javascript_tag( "$(function() {\n  " + noties.join("\n  ") + "\n});")
    end
  end
end
