class Hash
  def update_in(keys,value)
    target = keys.pop
    keys.reduce(self, :fetch)[target] = value
    self
  end
end

