class Restaurant < ApplicationRecord
  include Rails.application.routes.url_helpers

  extend FriendlyId
  friendly_id :unique_hash, use: :slugged

  # METHODS
  def unique_hash
    loop do
      random_number = SecureRandom.hex(6)
      break random_number unless Restaurant.exists?(slug: random_number)
    end  
  end

  # VALIDATIONS
  validates_presence_of :title
  validates_presence_of :user_id

  has_one_attached :image, dependent: :destroy
  has_one_attached :qrcode, dependent: :destroy

  # ASSOCIATIONS
  belongs_to :user
  has_many :categories
  has_many :products
  has_many :tables

  before_commit :generate_qrcode, on: :create

  private

  def generate_qrcode
    # Get the host
    # host = Rails.application.routes.default_url_options[:host]
    # host = Rails.application.config.action_controller.default_url_options[:host]
    host = "http://localhost:3000"

    # Create the QR code object
    # qrcode = RQRCode::QRCode.new("http://#{host}/posts/#{id}")
    qrcode = RQRCode::QRCode.new(restaurant_url(self, host: host))

    # Create a new PNG object
    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 500,
    )

    # Attach the QR code to the active storage
    self.qrcode.attach(
      io: StringIO.new(png.to_s),
      filename: "qrcode.png",
      content_type: "image/png",
    )
  end
end
