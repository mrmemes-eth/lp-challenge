require 'ox'
require_relative 'hash_ext'

class StreamParser < Ox::Sax
  attr_accessor :elements
  attr_accessor :attributes

  def initialize
    self.elements = []
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
    guard(name) { elements.pop }
    if name == :destination
      # TODO: when this element is :destination, emit a destination template

      # then clear attributes to prepare for next destination
      attributes.clear
    end
  end

  def value(value)
    guard(value) do
      attributes.update_in(elements,value_str(value))
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
