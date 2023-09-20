class Table < ApplicationRecord
  include Rails.application.routes.url_helpers

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :title,
      [:title, restaurant.title]
    ]
  end

  # VALIDATIONS
  validates_presence_of :title
  validates_presence_of :restaurant_id

  has_one_attached :qrcode, dependent: :destroy
  # ASSOCIATIONS
  belongs_to :restaurant

  before_commit :generate_qrcode, on: :create

  private

  def generate_qrcode
    # Get the host
    # host = Rails.application.routes.default_url_options[:host]
    # host = Rails.application.config.action_controller.default_url_options[:host]
    host = "http://localhost:3000"

    # Create the QR code object
    # qrcode = RQRCode::QRCode.new("http://#{host}/posts/#{id}")
    qrcode = RQRCode::QRCode.new(table_url(self, host: host))

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
