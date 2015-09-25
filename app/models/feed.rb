class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :products, dependent: :destroy
  after_destroy :delete_file_from_disk
  mount_uploaders :file, FileUploader

  def products_on_page page
    products.paginate(page: page, per_page: 10).order("updated_at DESC")
  end

  def save_products
    parse_products do |row|
      self.products.create row
      sleep 1
    end
  end

  def print_products
    parse_products do |row|
      puts row
    end
  end

  def parse_products
    if extension == '.csv'
      CSV.foreach(storage_path, headers: true) do |row|
        yield row.to_hash
      end
    else
      Nokogiri::XML(File.open(storage_path)).xpath(".//item").each do |row|
        hash = {
          title: row.xpath('title').text,
          url:   row.xpath('url').text,
          price: row.xpath('price').text
        }
        yield hash
      end 
    end
  end

  def storage_path
    File.join directory, basename
  end

  def basename
    File.basename(self.file[0].path).split("\"")[1] if self.file[0]
  end

  def extension
    File.extname basename
  end

  def directory
    File.dirname self.file[0].path if self.file[0]
  end

  def delete_file_from_disk
    FileUtils.rm_rf(File.join(FileUtils.pwd, "public", "uploads", "feed", "file", self.id.to_s))
  end
end
