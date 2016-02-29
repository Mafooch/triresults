class Event
  include Mongoid::Document
  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String

  embedded_in :parent, polymorphic: true, touch: true

  validates_presence_of :order, :name

  def meters
    if units && distance
      if units == "meters" then distance
      elsif units == "kilometers" then distance * 1000
      elsif units == "yards" then distance * 0.9144
      elsif units == "miles" then distance * 1609.34
      end
    else
      nil
    end
  end

  def miles
    if units && distance
      if units == "miles" then distance
      elsif units == "meters" then distance * 0.000621371
      elsif units == "kilometers" then distance * 0.621371
      elsif units == "yards" then distance * 0.000568182
      end
    else
      nil
    end
  end
end
