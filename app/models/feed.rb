class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :products
  mount_uploaders :file, FileUploader

  def save_products
    parse_products do |row|
      self.products.create row.to_hash
      sleep 1
    end
  end

  def print_products
    parse_products do |row|
      puts row.to_hash
    end
  end

  def parse_products
    CSV.foreach(storage_path, headers: true) do |row|
      yield row
    end
  end

  def storage_path
    File.join directory, basename
  end

  def basename
    File.basename(self.file[0].path).split("\"")[1]
  end

  def directory
    File.dirname self.file[0].path
  end
end
