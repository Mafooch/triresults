class Racer
  include Mongoid::Document

  embeds_one :info, as: :parent, class_name: "RacerInfo", autobuild: true
  # automatically create the object when the relationship is navigated

  before_create do |racer|
    racer.info.id = racer.id
  end
end
