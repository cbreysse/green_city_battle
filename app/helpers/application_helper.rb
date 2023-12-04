module ApplicationHelper
  def address_formatter(address)
    address.split(',').first(2).join(',').gsub(',', '')
  end

  def participation_history(participation)
    case participation.action_type.name
    when "water spot"
      return "#{participation.user.username} a arrosé  #{time_difference_in_days(participation.created_at)}"
    when "care"
      return "#{participation.user.username} a désherbé #{time_difference_in_days(participation.created_at)}"
    when "plant"
      "#{participation.user.username} a planté #{time_difference_in_days(participation.created_at)}"
    when "denounce"
      return "La team #{participation.user.team.name} vous a trash #{time_difference_in_days(participation.created_at)}!"
    end
  end

  def time_difference_in_days(from_time, to_time = Time.now)
    distance_in_days = ((to_time - from_time) / 1.day).round
    return "il y a #{distance_in_days} jour#{'s' unless distance_in_days == 1}"
  end

  def block_action(spot_id, action_id)
    last_action = Participation.where(spot_id: spot_id, action_type_id: action_id).last

    return nil unless last_action

    last_action_timestamp = last_action.created_at
    action_intervals = action_intervals_mapping
    action_name = ActionType.find(action_id).name

    return last_action_timestamp > action_intervals[action_name].ago if action_intervals.key?(action_name)

    nil
  end

  private

  def action_intervals_mapping
    {
      "water spot" => 3.days,
      "care" => 15.days,
      "plant" => 89.days,
      "denounce" => 1.day
    }
  end
end
