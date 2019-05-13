require 'dotenv/load'

input_text = ARGV[0]
raise "Input text required." unless input_text

# Synthesizes speech from the input string of text or ssml.
# Note: ssml must be well-formed according to:
# https://www.w3.org/TR/speech-synthesis/

require "google/cloud/text_to_speech"

# Instantiates a client
client = Google::Cloud::TextToSpeech.new

# Set the text input to be synthesized
synthesis_input = { text: input_text }

# Build the voice request, select the language code ("en-US") and the ssml
# voice gender ("neutral")
voice = {
  #language_code: "en-US",
  #name: "en-US-Wavenet-F"
  language_code: "ja-JP",
  name: "ja-JP-Wavenet-C"
  #ssml_gender:   "FEMALE"
}

# Select the type of audio file you want returned
audio_config = { audio_encoding: "MP3" }

# Perform the text-to-speech request on the text input with the selected
# voice parameters and audio file type
response = client.synthesize_speech synthesis_input, voice, audio_config

# The response's audio_content is binary.
File.open "#{input_text}.mp3", "wb" do |file|
  # Write the response to the output file.
  file.write response.audio_content
end

puts "Audio content written to file '#{input_text}.mp3'"
