require 'leet_code'
require 'byebug'

describe 'LeetCode' do
  RSpec.configure do |c|
    c.include LeetCode
  end

  describe '#find_max_length' do
    let(:test_cases) do
      {
        [0, 0, 1, 0, 0, 0, 1, 1] => 6,
        [0, 1, 1, 0, 1, 1, 1, 0] => 4,
        [0, 1, 0]                => 2
      }
    end

    it 'returns correct value on given input' do
      test_cases.each do |test, result|
        expect(find_max_length(test)).to eq(result)
      end
    end
  end

  describe '#max_sub_array_len' do
    let(:test_cases) do
      {
        [1, 0, -1] => 2
      }
    end

    it 'returns correct value on given input' do
      test_cases.each do |test, result|
        expect(max_sub_array_len(test, -1)).to eq(result)
      end
    end
  end

  describe '#atoi' do
    it 'returns correct value on given input' do
      expect(my_atoi('-123')).to eq(-123)
    end
  end

  describe '#multiply' do
    let(:a) { [[1, 0, 0], [-1, 0, 3]] }
    let(:b) { [[7, 0, 0], [0, 0, 0], [0, 0, 1]] }
    let(:result) { [[7, 0, 0], [-7, 0, 3]] }

    it 'returns correct value on given input' do
      expect(multiply(a, b)).to eq(result)
    end
  end

  describe '#search' do
    let(:a) { [3, 1] }
    let(:b) { 1 }
    let(:result) { 1 }

    it 'returns correct value on given input' do
      expect(search(a, b)).to eq(result)
    end
  end

  describe '#compress' do
    let(:a) { %w[a b c d e f g g g g g g g g g g g g a b c] }
    let(:result) { %w[a b c d e f g 1 2 a b c] }

    it 'returns correct value on given input' do
      expect(compress(a)).to eq(result)
    end
  end
end
