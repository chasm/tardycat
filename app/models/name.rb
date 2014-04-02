class Name
  include Mongoid::Document
  include CustomId

  embedded_in :user

  field :prefix
  field :given
  field :middle
  field :family
  field :suffix

  validates :given, :family, presence: true

  def full
    [
      self.prefix,
      self.given,
      self.middle,
      self.family,
      self.suffix
    ].compact.join(" ")
  end

  def full_reversed
    [
      self.family,
      [
        self.prefix,
        self.given,
        self.middle,
      ].compact.join(" "),
      self.suffix
    ].compact.join(", ")
  end

  def simple
    [ self.given, self.middle, self.family ].compact.join(" ")
  end

  def simple_reversed
    [
      self.family,
      [ self.given, self.middle ].compact.join(" ")
    ].compact.join(", ")
  end

  def reversed
    [ self.family, self.given ].compact.join(" ")
  end
end
