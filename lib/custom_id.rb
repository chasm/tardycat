module CustomId
  extend ActiveSupport::Concern

  included do
    field :id, type: String
    set_callback :initialize, :after, :set_id
  end

  def set_id
    self.id = SecureRandom.urlsafe_base64 if self.id.is_a?(BSON::ObjectId)
  end
end
