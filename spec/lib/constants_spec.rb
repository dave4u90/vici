RSpec.describe Vici do
  context 'Constants' do
    it 'XMAX should equal 5' do
      expect(XMAX).to eq(5)
    end
  
    it 'YMAX should equal 5' do
      expect(YMAX).to eq(5)
    end
  
    it 'DIRECTION should equal [NORTH EAST SOUTH WEST]' do
      expect(DIRECTIONS).to eq(%w[NORTH EAST SOUTH WEST])
    end
  
    it 'COMMANDS should equal [PLACE MOVE LEFT RIGHT REPORT]' do
      expect(COMMANDS).to eq(%w[PLACE MOVE LEFT RIGHT REPORT])
    end
  end
end
