require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963', exp: 'Mar-30-2020', name: 'Soumya Ray', net: 'Visa' },
  { num: '6011580789725897', exp: 'Sep-30-2020', name: 'Nick Danks', net: 'Visa' },
  { num: '5423661657234057', exp: 'Feb-30-2020', name: 'Lee Chen', net: 'Mastercard' }
]

cards = card_details.map { |c| CreditCard.new(c[:num], c[:exp], c[:name], c[:net]) }

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    it 'shoudld check hashes are consistently produced' do
      cards.each do |card|
        card.hash.wont_be_nil
        card.hash.wont_equal card.to_s
        card.hash.must_equal card.hash
      end
    end

    it 'Check for unique hashes' do
      hash = cards.map(&:hash)
      hash.uniq.length.must_equal hash.length
    end
  end
  #
  # describe 'Test cryptographic hashing' do
  #   describe 'Check hashes are consistently produced' do
  #     # TODO: Check that each card produces the same hash if hashed repeatedly
  #   end
  #
  #   describe 'Check for unique hashes' do
  #     # TODO: Check that each card produces a different hash than other cards
  #   end
  #
  #   describe 'Check regular hash not same as cryptographic hash' do
  #     # TODO: Check that each card's hash is different from its hash_secure
  #   end
  # end
end
