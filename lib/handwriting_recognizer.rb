require 'rtesseract'

class HandwritingRecognizer
  def self.recognize(image_path)
    RTesseract.new(image_path).to_s.strip
  end
