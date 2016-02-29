class Point
  attr_accessor :longitude, :latitude

  def initialize longitude, latitude
    @longitude = longitude
    @latitude = latitude
  end

  def mongoize
    { type: "Point", coordinates: [@longitude, @latitude] }
  end

  def self.mongoize object
    case object
    when Point then object.mongoize
    when Hash
      if object[:type] #in GeoJSON Point format
        Point.new(object[:coordinates][0], object[:coordinates][1]).mongoize
      else #in legacy format
        Point.new(object[:lng], object[:lat]).mongoize
      end
    when nil then nil
    end
  end

  def self.demongoize object
    case object
    when Point then object
    when Hash then Point.new object[:coordinates][0], object[:coordinates][1]
    when nil then nil
    end
  end

  def self.evolve object
    case object
    when Point then object.mongoize
    when Hash
      if object[:type] #in GeoJSON Point format
        Point.new(object[:coordinates][0], object[:coordinates][1]).mongoize
      else #in legacy format
        Point.new(object[:lng], object[:lat]).mongoize
      end
    when nil then nil
    end
  end
end
