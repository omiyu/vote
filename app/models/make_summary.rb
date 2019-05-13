class MakeSummary < ApplicationRecord
  belongs_to :make ,class_name: 'Make', foreign_key: 'make_id'

  def calculation_rate(bunshi, bunbo)
    return 0 if bunbo == nil
    return ((bunshi*100)/bunbo).round(1) if bunbo != 0
  end
end
