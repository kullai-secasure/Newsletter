class StorageService
  def self.upload(file_path, bucket:)
    client = Aws::S3::Client.new(region: ENV['AWS_REGION'])
    key = "#{bucket}/#{File.basename(file_path)}"

    File.open(file_path, 'rb') do |file|
      client.put_object(
        bucket: ENV['S3_BUCKET'],
        key: key,
        body: file,
        content_type: 'image/png'
      )
    end

    "https://#{ENV['S3_BUCKET']}.s3.amazonaws.com/#{key}"
  rescue Aws::S3::Errors::ServiceError => e
    Rails.logger.error("S3 upload failed: #{e.message}")
    raise StorageError, 'Upload failed'
  end
end
