class Hash
  def update_in(path,value)
    keys = path.dup
    last = keys.pop
    trgt = keys.reduce(self) do |acc,key|
      acc[key] ||= {}
    end
    trgt[last] = value.respond_to?(:call) ? value.call(trgt[last]) : value
    self
  end

  def get_in(*path)
    keys = path.dup
    last = keys.pop
    keys.reduce(self) do |acc,key|
      acc.fetch(key,{})
    end[last]
  end
end

