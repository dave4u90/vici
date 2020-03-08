RSpec.describe Vici do
  let(:vici) { Vici.new }
  
  describe '#placed?' do
    it 'should return false when not placed' do
      expect(vici.placed?).to be_falsey
    end

    it 'should return false when wrongly placed' do
      vici.placed = false
      expect(vici.placed?).to be_falsey
    end

    it 'should return true when correctly placed' do
      vici.placed = true
      expect(vici.placed?).to be_truthy
    end
  end

  describe '#place' do
    subject(:place_vici) { vici.place(xposition: 3, yposition: 2, direction: 'NORTH') }
    
    it 'should return false when invalid positions are passed' do
      allow(vici).to receive(:valid_positions?).and_return false
      expect(place_vici).to be_falsey
    end

    it 'should return false when invalid direction are passed' do
      allow(vici).to receive(:valid_direction?).and_return false
      expect(place_vici).to be_falsey
    end

    it 'should return false when invalid positions and direction are passed' do
      allow(vici).to receive(:valid_positions?).and_return false
      allow(vici).to receive(:valid_direction?).and_return false
      expect(place_vici).to be_falsey
    end

    it 'should return true when valid positions and direction are passed' do
      expect(place_vici).to be_truthy
    end

    it 'should assign correct positions when valid positions and direction are passed' do
      place_vici
      expect(vici.currentx).to eq(3)
      expect(vici.currenty).to eq(2)
    end

    it 'should assign correct direction when valid positions and direction are passed' do
      place_vici
      expect(vici.current_direction).to eq('NORTH')
    end
  end

  describe '#move' do
    let(:vici) { Vici.new }
    
    it 'should not act unless vici is placed' do
      vici.currentx = 1
      vici.currenty = 1
      vici.current_direction = 'SOUTH'
      vici.placed = false
      
      expect { vici.move }.to_not change(vici, :currentx) 
      expect { vici.move }.to_not change(vici, :currenty)
      expect { vici.move }.to_not change(vici, :current_direction)
    end

    context 'when placed' do
      context 'when current direction is north' do
        it 'should move one position up if current yposotion is valid' do
          vici.place(xposition: 2, yposition: 2, direction: 'NORTH')
          expect { vici.move }.to change(vici, :currenty).by(1)
        end

        it 'should ignore if current yposition is invalid' do
          vici.place(xposition: 5, yposition: 5, direction: 'NORTH')
          expect { vici.move }.to_not change(vici, :currenty)
        end
      end

      context 'when current direction is east' do
        it 'should move one position right when current xposition is valid' do
          vici.place(xposition: 2, yposition: 2, direction: 'EAST')
          expect { vici.move }.to change(vici, :currentx).by(1)
        end

        it 'should ignore if current xposition is invalid' do
          vici.place(xposition: 5, yposition: 5, direction: 'EAST')
          expect { vici.move }.to_not change(vici, :currentx)
        end
      end

      context 'when current direction is south' do
        it 'should move one position down when current yposition is valid' do
          vici.place(xposition: 2, yposition: 2, direction: 'SOUTH')
          expect { vici.move }.to change(vici, :currenty).by(-1)
        end

        it 'should ignore if current yposition is invalid' do
          vici.place(xposition: 0, yposition: 0, direction: 'SOUTH')
          expect { vici.move }.to_not change(vici, :currenty)
        end
      end

      context 'when current direction is west' do
        it 'should move one position left when current xposition is valid' do
          vici.place(xposition: 2, yposition: 2, direction: 'WEST')
          expect { vici.move }.to change(vici, :currentx).by(-1)
        end

        it 'should ignore if current xposition is invalid' do
          vici.place(xposition: 0, yposition: 0, direction: 'WEST')
          expect { vici.move }.to_not change(vici, :currentx)
        end
      end
    end
  end

  describe '#left' do
    it 'should not change the current position iof vici' do
      vici.place(xposition: 2, yposition: 2, direction: 'NORTH')
      expect { vici.left }.to_not change(vici, :currentx)
      expect { vici.left }.to_not change(vici, :currenty)
    end

    it 'should set the current direction to west if the direction was north' do
      vici.place(xposition: 2, yposition: 2, direction: 'NORTH')
      vici.left
      expect(vici.current_direction).to eq('WEST')
    end

    it 'should set the current direction to south if the direction was west' do
      vici.place(xposition: 2, yposition: 2, direction: 'WEST')
      vici.left
      expect(vici.current_direction).to eq('SOUTH')
    end

    it 'should set the current direction to east if the direction was south' do
      vici.place(xposition: 2, yposition: 2, direction: 'SOUTH')
      vici.left
      expect(vici.current_direction).to eq('EAST')
    end

    it 'should set the current direction to north if the direction was east' do
      vici.place(xposition: 2, yposition: 2, direction: 'EAST')
      vici.left
      expect(vici.current_direction).to eq('NORTH')
    end
  end

  describe '#right' do
    it 'should not change the current position iof vici' do
      vici.place(xposition: 2, yposition: 2, direction: 'NORTH')
      expect { vici.right }.to_not change(vici, :currentx)
      expect { vici.right }.to_not change(vici, :currenty)
    end

    it 'should set the current direction to east if the direction was north' do
      vici.place(xposition: 2, yposition: 2, direction: 'NORTH')
      vici.right
      expect(vici.current_direction).to eq('EAST')
    end

    it 'should set the current direction to south if the direction was east' do
      vici.place(xposition: 2, yposition: 2, direction: 'EAST')
      vici.right
      expect(vici.current_direction).to eq('SOUTH')
    end

    it 'should set the current direction to west if the direction was south' do
      vici.place(xposition: 2, yposition: 2, direction: 'SOUTH')
      vici.right
      expect(vici.current_direction).to eq('WEST')
    end

    it 'should set the current direction to north if the direction was west' do
      vici.place(xposition: 2, yposition: 2, direction: 'WEST')
      vici.right
      expect(vici.current_direction).to eq('NORTH')
    end
  end

  describe '#report' do
    it 'should not report anything if vici is not placed' do
      vici = Vici.new
      expect(vici.report).to be_nil
    end

    it 'should announce the current x and y position and direction of vici if placed' do
      vici = Vici.new
      vici.place(xposition: 1, yposition: 4, direction: 'EAST')
      expect(vici.report).to eq('1,4,EAST')
    end
  end
end
