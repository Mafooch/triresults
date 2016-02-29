class LegResult
  include Mongoid::Document
  field :secs, type: Float

  embedded_in :entrant
  embeds_one :event, as: :parent

  validates_presence_of :event

  def calc_ave
    # subclasses will calc event-specific ave
  end

  def secs= seconds
    self[:secs] = seconds
    # can't set with @secs (not an instance variable) or self.secs = since this
    # just calls itself
    calc_ave
  end

  after_initialize do |leg_result|
    calc_ave
  end
end
