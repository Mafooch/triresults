class Placing
  attr_accessor :name, :place

  def initialize doc
    @name = doc[:name]
    @place = doc[:place]
  end

  def mongoize
    { name: @name, place: @place }
  end

  def self.mongoize object
    case object
    when Placing then object.mongoize
    when Hash then Placing.new(object).mongoize
    when nil then nil
    end
  end

  def self.evolve object
    case object
    when Placing then object.mongoize
    when Hash then Placing.new(object).mongoize
    when nil then nil
    end
  end

  def self.demongoize object
    case object
    when Placing then object
    when Hash then Placing.new object
    when nil then nil
    end
  end
end
