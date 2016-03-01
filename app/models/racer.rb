class Racer
  include Mongoid::Document

  has_many :races, class_name: "Entrant", foreign_key: "racer.racer_id",
    dependent: :nullify, order: :"race.date".desc
  embeds_one :info, as: :parent, class_name: "RacerInfo", autobuild: true
  # automatically create the object when the relationship is navigated

  # use attribute delegation to flatten embedded model and reduce complexity
  # delegating getter and setter in the embedded doc fields to the parent
  delegate :first_name, :first_name=, to: :info
  delegate :last_name, :last_name=, to: :info
  delegate :gender, :gender=, to: :info
  delegate :birth_year, :birth_year=, to: :info
  delegate :city, :city=, to: :info
  delegate :state, :state=, to: :info

  before_create do |racer|
    racer.info.id = racer.id
  end
end
