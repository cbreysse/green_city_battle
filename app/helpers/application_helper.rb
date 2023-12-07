module ApplicationHelper
  include ActionIntervals

  def address_formatter(address)
    address.split(',').first(2).join(',').gsub(',', '')
  end

  def participation_history(participation)
    action_mapping = { "water spot" => "arrosé", "care" => "désherbé", "plant" => "planté", "denounce" => "trash" }
    action_name = action_mapping[participation&.action_type&.name]
    user_or_team_name = participation&.action_type&.name == "denounce" ? participation.user.team.name : participation.user.username
    "#{user_or_team_name} a #{action_name} #{time_difference_in_days(participation&.created_at)}" if action_name
  end

  def time_difference_in_days(from_time, to_time = Time.now)
    distance_in_days = ((to_time - from_time) / 1.day).round
    return "il y a #{distance_in_days} jour#{'s' unless distance_in_days == 1}"
  end

  def block_action(spot_id, action_id)
    last_action = Participation.where(spot_id: spot_id, action_type_id: action_id).last

    return nil unless last_action

    last_action_timestamp = last_action.created_at
    action_intervals = ActionIntervals::INTERVALS_MAPPING
    action_name = ActionType.find(action_id).name

    return last_action_timestamp > action_intervals[action_name].ago if action_intervals.key?(action_name)

    nil
  end

  def dry?(spot)
    plant_dry?(spot)
  end
end
