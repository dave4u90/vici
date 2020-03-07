RSpec.describe Vici do
  context 'Validations' do
    let(:vici) { Vici.new }

    ['validx?', 'validy?'].each do |method|
      argument, maximum, attribute = method == 'validx?' ? [:xposition, XMAX, :currentx] : [:yposition, YMAX, :currenty]
     
      describe "##{method}" do
        it 'should return false when vici is not placed' do
          expect(vici.public_send method).to be_falsey
        end

        it 'should return false when a non integer is passed' do
          expect(vici.public_send method, argument => 'x').to be_falsey
        end

        it 'should return false when a value greater than maximum is passed' do
          expect(vici.public_send method, argument => (maximum + 2).to_s).to be_falsey
        end

        it 'should return false when a value less than 0 is passed' do
          expect(vici.public_send method, argument => -(maximum + 2).to_s).to be_falsey
        end

        it "should return false when current #{argument} is invalid" do
          vici.send "#{attribute}=", (maximum + 2).to_s
          expect(vici.validx?).to be_falsey
        end
        
        it 'should return true when a valid value is passed' do
          expect(vici.public_send method, argument => (maximum - 1).to_s).to be_truthy
        end
        
        it 'should return true when current xposition is valid' do
          vici.send "#{attribute}=", maximum - 1
          vici.placed = true
          expect(vici.send method).to be_truthy
        end
      end
    end

    describe '#valid_direction?' do
      it 'should return false when vici is not placed' do
        expect(vici.valid_direction?).to be_falsey
      end

      it 'should return false when an invalid direction is passed' do
        expect(vici.valid_direction?(direction: 'NORTHWEST')).to be_falsey
      end

      it 'should return false when current direction is invalid' do
        vici.current_direction = 'NORTHWEST'
        expect(vici.valid_direction?).to be_falsey
      end

      it 'should return true when current direction is valid' do
        vici.current_direction = 'NORTH'
        expect(vici.valid_direction?).to be_truthy
      end

      it 'should return true when an valid direction is passed' do
        expect(vici.valid_direction?(direction: 'NORTH')).to be_truthy
      end
    end

    describe '#valid_positions' do
      it 'should return false when xposition is invalid' do
        allow(vici).to receive(:validx?).and_return false
        expect(vici.valid_positions?).to be_falsey
      end

      it 'should return false when yposition is invalid' do
        allow(vici).to receive(:validy?).and_return false
        expect(vici.valid_positions?).to be_falsey
      end

      it 'should return false when both xposition and yposition are invalid' do
        allow(vici).to receive(:validx?).and_return false
        allow(vici).to receive(:validy?).and_return false
        expect(vici.valid_positions?).to be_falsey
      end

      it 'should return true when both xposition and yposition are valid' do
        allow(vici).to receive(:validx?).and_return true
        allow(vici).to receive(:validy?).and_return true
        expect(vici.valid_positions?).to be_truthy
      end
    end

    describe '#valid?' do
      it 'should return false when position is not valid' do
        allow(vici).to receive(:valid_positions?).and_return false
        expect(vici.valid?).to be_falsey
      end

      it 'should return false when direction is not valid' do
        allow(vici).to receive(:valid_direction?).and_return false
        expect(vici.valid?).to be_falsey
      end

      it 'should return false when both position and direction is not valid' do
        allow(vici).to receive(:valid_direction?).and_return false
        allow(vici).to receive(:valid_positions?).and_return false
        expect(vici.valid?).to be_falsey
      end

      it 'should return true when both position and is valid' do
        allow(vici).to receive(:valid_direction?).and_return true
        allow(vici).to receive(:valid_positions?).and_return true
        expect(vici.valid?).to be_truthy
      end
    end
  end
end
