load 'lib/mailcannon/adapters/sendgrid.rb'

class MailCannon::Envelope
  include Mongoid::Document
  include Mongoid::Timestamps
  include MailCannon::Adapter::Sendgrid
  
  has_one :mail
  has_many :stamps
  
  field :from, type: String
  field :from_name, type: String
  field :to, type: String
  field :to_name, type: String
  field :subject, type: String
  field :bcc, type: String
  field :reply_to, type: String
  field :date, type: Date
  field :xsmtpapi, type: Hash
  
  validates :from, :to, :subject, :mail, presence: true
  validates_associated :mail
  
  after_create do |envelope|
    envelope.stamp! MailCannon::Event::New.stamp
    MailCannon::SingleBarrel.perform_async(envelope.id)
  end
  
  def stamp!(code)
    self.class.valid_code_kind?(code)
    self.stamps << MailCannon::Stamp.from_code(code)
  end
  
  def after_sent(response)
    if response
      stamp!(MailCannon::Event::Processed.stamp)
      self.mail.destroy
      self.mail=nil # to avoid reload
    end
  end
  
  private
  def self.valid_code_kind?(code)
    unless [Fixnum, MailCannon::Stamp].include?(code.class) || MailCannon::Event.constants.include?(code.to_s.camelize.to_sym)
      raise 'code must be an Integer, MailCannon::Event::*, or MailCannon::Stamp !'
    end
  end
    
end
