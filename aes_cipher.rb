require 'openssl'
require 'json'
require 'base64'

module AesCipher
  ALGORITHM = 'AES-256-CBC'
  def self.encrypt(document, key)
    # TODO: Return JSON string of array: [iv, ciphertext]
    #       where iv is the random intialization vector used in AES
    #       and ciphertext is the output of AES encryption
    # NOTE: Use base64 for ciphertext so that it is screen printable
    #       Use cipher block chaining mode only!
    # begin
      cipher = OpenSSL::Cipher.new(ALGORITHM).encrypt
      cipher.key = key
      iv = Base64.strict_encode64(cipher.random_iv)
      crypt = cipher.update(document.to_s) + cipher.final
      ciphertext = (Base64.strict_encode64(crypt))
      JSON.generate([iv , ciphertext])
    # rescue Exception => e
    #   puts "Message cannot be encrpted"
    #   puts "document: #{document}"
    #   puts "error: #{e.message}"
    # end
  end

  def self.decrypt(aes_crypt, key)
    # TODO: decrypt from JSON output (aes_crypt) of encrypt method above
    # begin
      array = JSON.load(aes_crypt)
      iv = array[0]
      msg = array[1]
      cipher = OpenSSL::Cipher.new(ALGORITHM)
      cipher.decrypt
      cipher.key = key
      cipher.iv = iv
      tempkey = Base64.decode64(msg)
      crypt = cipher.update(tempkey)
      crypt << cipher.final
      crypt
    # rescue Exception => e
    #   puts "Message cannot be decrypted"
    #   puts "Crypt Message: #{msg}"
    #   ptus "error: #{exc.message}"
    # end
  end 

  def self.random_key
    key = OpenSSL::Cipher.new(ALGORITHM).encrypt.random_key
  end
end
