class Hash
  # TODO: if a value exists at an update point, collate with new value
  def update_in(keys,value)
    target = keys.pop
    keys.reduce(self) do |acc,key|
      acc[key] ||= {}
    end[target] = value
    self
  end
end

