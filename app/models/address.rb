class Address
  attr_accessor :city, :state, :location

  def initialize doc
    @city = doc[:city]
    @state = doc[:state]
    @location = Point.new doc[:loc][:coordinates][0], doc[:loc][:coordinates][1]
  end

  def mongoize
    { city: @city, state: @state,
        loc: { type: "Point", coordinates: [@location.longitude, @location.latitude] }
    }
  end

  def self.mongoize object
    case object
    when Address then object.mongoize
    when Hash then Address.new(object).mongoize
    when nil then nil
    end
  end

  def self.evolve object
    case object
    when Address then object.mongoize
    when Hash then Address.new(object).mongoize
    when nil then nil
    end
  end

  def self.demongoize object
    case object
    when Address then object
    when Hash then Address.new object
    when nil then nil
    end
  end
end
