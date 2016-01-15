require('rspec')
require('definition')
require('pry')

describe(Definition) do
  before() do
    Definition.clear()
  end

  describe('#initialize') do
    it('creates a new definition object') do
      test_definition = a_new_definition()
      expect(test_definition.text()).to(include('a procedure intended to'))
    end
  end

  describe('#generate_id') do
    it('generates a unique id for each definition') do
      first_definition = a_new_definition()
      second_definition = a_second_definition()
      expect(first_definition.id()).to(eq('1'))
      expect(second_definition.id()).to(eq('2'))
    end
  end
end

def a_new_definition
  Definition.new({:text => 'a procedure intended to establish the quality, \
                            performance, or reliability of something, especially \
                            before it is taken into widespread use'})
end

def a_second_definition
  Definition.new({:text => 'a movable hearth in a reverberating furnace, \
                            used for separating gold or silver from lead'})
end
