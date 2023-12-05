module ActionIntervals
  INTERVALS_MAPPING = {
    "water spot" => 3.days,
    "care" => 15.days,
    "plant" => 89.days,
    "denounce" => 1.day
  }.freeze

  def plant_dry?(spot)
    action = ActionType.find_by(name: "water spot")
    return true unless spot.participations.where(action_type: action).any?

    last_watering = spot.participations.where(action_type: action).last&.created_at
    last_watering < Time.now - (INTERVALS_MAPPING["water spot"] * 2)
  end
end
