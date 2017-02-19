class User < ApplicationRecord
  before_save :assign_role
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  self.primary_key = "user_id"
  belongs_to :role
  belongs_to :outlet

  validates_presence_of :user_name, :user_fullname, :user_address, :user_phone, :role_id, :outlet_id, message: "Semua field harus diisi!"
	validates_uniqueness_of :user_name, message: "Username harus unik!"

	def assign_role
		self.role = Role.find_by role_name: "PIC Pengadaan" if self.role.nil?
	end

  def admin?
    self.role.role_name == "Super Admin"
  end

  def pengadaan?
    self.role.role_name == "PIC Pengadaan"
  end

  def gudang?
    self.role.role_name == "PIC Gudang"
  end

  def pimpinan?
    self.role.role_name == "Pimpinan Outlet"
  end
end
