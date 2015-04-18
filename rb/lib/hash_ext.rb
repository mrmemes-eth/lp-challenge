class Hash
  def update_in(keys,value)
    target = keys.pop
    keys.reduce(self) do |acc,key|
      acc[key] ||= {}
    end[target] = value
    self
  end
end

