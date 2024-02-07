# Model equivalent in Ruby
class Model
  attr_accessor :model, :system_prompt, :temperature, :functions, :provider, :url

  def initialize(model:, provider:, system_prompt: nil, temperature: nil, functions: nil, url: nil)
    @model = model
    @system_prompt = system_prompt
    @temperature = temperature
    @functions = functions
    @provider = provider
    @url = url
  end
end

# PLAY_HT_EMOTIONS equivalent in Ruby (as an array of symbols)
PLAY_HT_EMOTIONS = [
  :female_happy,
  :female_sad,
  :female_angry,
  :female_fearful,
  :female_disgust,
  :female_surprised
].freeze

# Voice equivalent in Ruby
class Voice
  attr_accessor :provider, :voice_id, :speed, :stability, :similarity_boost, :style,
                :use_speaker_boost, :temperature, :emotion, :voice_guidance, :style_guidance, :text_guidance

  def initialize(provider:, voice_id:, speed: nil, stability: nil, similarity_boost: nil, style: nil,
                 use_speaker_boost: nil, temperature: nil, emotion: nil, voice_guidance: nil,
                 style_guidance: nil, text_guidance: nil)
    @provider = provider
    @voice_id = voice_id
    @speed = speed
    @stability = stability
    @similarity_boost = similarity_boost
    @style = style
    @use_speaker_boost = use_speaker_boost
    @temperature = temperature
    @emotion = emotion
    @voice_guidance = voice_guidance
    @style_guidance = style_guidance
    @text_guidance = text_guidance
  end
end

# Assistant equivalent in Ruby
class Assistant
  attr_accessor :name, :transcriber, :model, :voice, :language, :forwarding_phone_number,
                :first_message, :voicemail_message, :end_call_message, :end_call_phrases,
                :interruptions_enabled, :recording_enabled, :end_call_function_enabled,
                :dial_keypad_function_enabled, :fillers_enabled, :client_messages, :server_messages,
                :silence_timeout_seconds, :response_delay_seconds, :live_transcripts_enabled,
                :keywords, :parent_id, :server_url, :server_url_secret, :id, :org_id, :created_at,
                :updated_at

  def initialize(name: nil, transcriber: nil, model: nil, voice: nil, language: nil,
                 forwarding_phone_number: nil, first_message: nil, voicemail_message: nil,
                 end_call_message: nil, end_call_phrases: nil, interruptions_enabled: nil,
                 recording_enabled: nil, end_call_function_enabled: nil, dial_keypad_function_enabled: nil,
                 fillers_enabled: nil, client_messages: nil, server_messages: nil,
                 silence_timeout_seconds: nil, response_delay_seconds: nil, live_transcripts_enabled: nil,
                 keywords: nil, parent_id: nil, server_url: nil, server_url_secret: nil, id: nil,
                 org_id: nil, created_at: nil, updated_at: nil)
    @name = name
    @transcriber = transcriber
    @model = model
    @voice = voice
    @language = language
    @forwarding_phone_number = forwarding_phone_number
    @first_message = first_message
    @voicemail_message = voicemail_message
    @end_call_message = end_call_message
    @end_call_phrases = end_call_phrases
    @interruptions_enabled = interruptions_enabled
    @recording_enabled = recording_enabled
    @end_call_function_enabled = end_call_function_enabled
    @dial_keypad_function_enabled = dial_keypad_function_enabled
    @fillers_enabled = fillers_enabled
    @client_messages = client_messages
    @server_messages = server_messages
    @silence_timeout_seconds = silence_timeout_seconds
    @response_delay_seconds = response_delay_seconds
    @live_transcripts_enabled = live_transcripts_enabled
    @keywords = keywords
    @parent_id = parent_id
    @server_url = server_url
    @server_url_secret = server_url_secret
    @id = id
    @org_id = org_id
    @created_at = created_at
    @updated_at = updated_at
  end
end

# VAPI_CALL_STATUSES equivalent in Ruby (as an array of symbols)
VAPI_CALL_STATUSES = [
  :queued,
  :ringing,
  :in_progress,
  :forwarding,
  :ended
].freeze

# VapiWebhookEnum equivalent in Ruby (as a module with constants)
module VapiWebhookEnum
  ASSISTANT_REQUEST = "assistant-request"
  FUNCTION_CALL = "function-call"
  STATUS_UPDATE = "status-update"
  END_OF_CALL_REPORT = "end-of-call-report"
  HANG = "hang"
  SPEECH_UPDATE = "speech-update"
  TRANSCRIPT = "transcript"
end

# ConversationMessage equivalent in Ruby
class ConversationMessage
  attr_accessor :role, :message, :name, :args, :result, :time, :end_time, :seconds_from_start

  def initialize(role:, time:, seconds_from_start:, message: nil, name: nil, args: nil, result: nil, end_time: nil)
    @role = role
    @message = message
    @name = name
    @args = args
    @result = result
    @time = time
    @end_time = end_time
    @seconds_from_start = seconds_from_start
  end
end

# BaseVapiPayload equivalent in Ruby
class BaseVapiPayload
  attr_accessor :call

  def initialize(call:)
    @call = call
  end
end

# AssistantRequestPayload equivalent in Ruby
class AssistantRequestPayload < BaseVapiPayload
  attr_accessor :type

  def initialize(call:)
    super(call: call)
    @type = VapiWebhookEnum::ASSISTANT_REQUEST
  end
end

# StatusUpdatePayload equivalent in Ruby
class StatusUpdatePayload < BaseVapiPayload
  attr_accessor :type, :status, :messages

  def initialize(call:, status:, messages: nil)
    super(call: call)
    @type = VapiWebhookEnum::STATUS_UPDATE
    @status = status
    @messages = messages
  end
end

# FunctionCallPayload equivalent in Ruby
class FunctionCallPayload < BaseVapiPayload
  attr_accessor :type, :function_call

  def initialize(call:, function_call:)
    super(call: call)
    @type = VapiWebhookEnum::FUNCTION_CALL
    @function_call = function_call
  end
end

# EndOfCallReportPayload equivalent in Ruby
class EndOfCallReportPayload < BaseVapiPayload
  attr_accessor :type, :ended_reason, :transcript, :messages, :summary, :recording_url

  def initialize(call:, ended_reason:, transcript:, messages:, summary:, recording_url: nil)
    super(call: call)
    @type = VapiWebhookEnum::END_OF_CALL_REPORT
    @ended_reason = ended_reason
    @transcript = transcript
    @messages = messages
    @summary = summary
    @recording_url = recording_url
  end
end

# SpeechUpdatePayload equivalent in Ruby
class SpeechUpdatePayload < BaseVapiPayload
  attr_accessor :type, :status, :role

  def initialize(call:, status:, role:)
    super(call: call)
    @type = VapiWebhookEnum::SPEECH_UPDATE
    @status = status
    @role = role
  end
end

# TranscriptPayload equivalent in Ruby
class TranscriptPayload
  attr_accessor :type, :role, :transcript_type, :transcript

  def initialize(role:, transcript_type:, transcript:)
    @type = VapiWebhookEnum::TRANSCRIPT
    @role = role
    @transcript_type = transcript_type
    @transcript = transcript
  end
end

# VapiCall equivalent in Ruby (empty class for now as no details are provided)
class VapiCall
end

# VapiPayload equivalent in Ruby (handled via polymorphism, no direct equivalent needed)

# FunctionCallMessageResponse equivalent in Ruby
class FunctionCallMessageResponse
  attr_accessor :result

  def initialize(result: nil)
    @result = result
  end
end

# AssistantRequestMessageResponse equivalent in Ruby
class AssistantRequestMessageResponse
  attr_accessor :assistant, :error

  def initialize(assistant: nil, error: nil)
    @assistant = assistant
    @error = error
  end
end

# StatusUpdateMessageResponse equivalent in Ruby (empty class for now as no details are provided)
class StatusUpdateMessageResponse
end

# SpeechUpdateMessageResponse equivalent in Ruby (empty class for now as no details are provided)
class SpeechUpdateMessageResponse
end

# TranscriptMessageResponse equivalent in Ruby (empty