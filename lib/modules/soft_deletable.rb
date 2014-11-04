module SoftDeletable
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end
end

module SoftDeletableStatic
  def active
    where( deleted_at: nil )
  end
end