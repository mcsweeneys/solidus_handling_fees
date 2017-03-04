Spree::ItemAdjustments.class_eval do
  module OverrideItemAdjustments
    def update_adjustments
      super

      @item.handling_total = adjustments.handling.reload.map(&:update!).compact.sum
      @item.adjustment_total += @item.handling_total

      @item.update_columns(
        handling_total: @item.handling_total,
        adjustment_total: @item.adjustment_total,
        updated_at: Time.current
      ) if @item.changed?
    end
  end

  prepend OverrideItemAdjustments

end
