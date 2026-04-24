class ScreenshotService
  CHROME_PATH = '/usr/bin/chromium-browser'
  SCREENSHOT_DIR = Rails.root.join('tmp', 'screenshots')

  def initialize
    FileUtils.mkdir_p(SCREENSHOT_DIR) unless Dir.exist?(SCREENSHOT_DIR)
  end

  def generate_preview(preview_url)
    filename = "#{SecureRandom.uuid}.png"
    output_path = SCREENSHOT_DIR.join(filename)

    result = `#{CHROME_PATH} --headless --disable-gpu --screenshot=#{output_path} --window-size=1200,800 #{preview_url} 2>&1`

    unless File.exist?(output_path)
      Rails.logger.error("Screenshot failed: #{result}")
      raise ScreenshotError, 'Failed to generate preview'
    end

    upload_to_storage(output_path)
  end

  private

  def upload_to_storage(file_path)
    StorageService.upload(file_path, bucket: 'previews')
  end
end
