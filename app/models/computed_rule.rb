module ComputedRule
  def self.all
    constants.select { |c| const_get(c).is_a? Class }.map { |c| "ComputedRule::#{c}" }.map(&:classify).map(&:constantize)
  end

  def build(house:)
    # implemented by child classes
  end
end
