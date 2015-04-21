require 'ox'
require_relative 'hash_ext'

class StreamParser < Ox::Sax
  attr_accessor :elements
  attr_accessor :emitter
  attr_accessor :attributes

  def initialize(emitter)
    self.elements = []
    self.emitter = emitter
    self.attributes = {}
  end

  def current_element
    elements.last
  end

  def start_element(name)
    guard(name) { elements << name }
  end

  def attr_value(name, value)
    guard(name) do
      attributes.update_in(elements.push(name),value_str(value))
    end
  end

  def end_element(name)
    if name == :destination
      guard(name) { elements.pop }
      # when the :destination element is finished, call the emitter
      emitter.call(attributes)
      # then clear attributes to prepare for next destination
      self.attributes = {}
    end
  end

  def value(value)
    guard(value) do
      collate_proc = ->(new, current) do
        current ? Array(current).push(new) : new
      end
      attributes.update_in(elements, collate_proc.curry.call(value_str(value)))
    end
  end
  alias cdata value

  private

  def value_str(v)
    v.respond_to?(:as_s) ? v.as_s : v
  end

  def guard(element, &block)
    if elements.include?(:destination) || element == :destination
      block.call
    end
  end

end

__END__

example destination XML for reference

<destination atlas_id="355633" asset_id="1524-33" title="Swaziland" title-ascii="Swaziland">
  <history>
    <history>
      <history><![CDATA[EXAMPLE]]></history>
      <history><![CDATA[EXAMPLE]]></history>
      <history><![CDATA[EXAMPLE]]></history>
      <overview>
      </overview>
    </history>
  </history>
  <introductory>
    <introduction>
      <overview><![CDATA[EXAMPLE]]></overview>
    </introduction>
  </introductory>
  <practical_information>
    <money_and_costs>
      <money><![CDATA[EXAMPLE]]></money>
    </money_and_costs>
    <visas>
      <other><![CDATA[EXAMPLE]]></other>
      <overview><![CDATA[EXAMPLE]]></overview>
    </visas>
  </practical_information>
  <transport>
    <getting_around>
      <bus_and_tram><![CDATA[EXAMPLE]]></bus_and_tram>
      <hitching><![CDATA[EXAMPLE]]></hitching>
    </getting_around>
    <getting_there_and_away>
      <air><![CDATA[EXAMPLE]]></air>
      <bus_and_tram><![CDATA[EXAMPLE]]></bus_and_tram>
      <bus_and_tram><![CDATA[EXAMPLE]]></bus_and_tram>
      <bus_and_tram><![CDATA[EXAMPLE]]></bus_and_tram>
    </getting_there_and_away>
  </transport>
  <weather>
    <when_to_go>
      <climate><![CDATA[EXAMPLE]]></climate>
    </when_to_go>
  </weather>
</destination>