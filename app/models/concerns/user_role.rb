module UserRole
  def admin!
    self.update_attribute(:role, :admin)
  end

  def user!
    self.update_attribute(:role, :user)
  end

  def guest!
    self.update_attribute(:role, :guest)
  end

  def admin?
    self.role == 'admin'
  end

  def user?
    self.role == 'user'
  end

  def guest?
    self.role == "guest"
  end
end
