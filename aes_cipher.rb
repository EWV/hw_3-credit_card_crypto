require 'openssl'
require 'json'
require 'base64'

# Simple implementation if AER encryption using 256 bytes
module AesCipher
  ALGORITHM = 'AES-256-CBC'
  def self.encrypt(document, key)
    # TODO: Return JSON string of array: [iv, ciphertext]
    #       where iv is the random intialization vector used in AES
    #       and ciphertext is the output of AES encryption
    # NOTE: Use base64 for ciphertext so that it is screen printable
    #       Use cipher block chaining mode only!
    cipher = OpenSSL::Cipher.new(ALGORITHM).encrypt
    cipher.key = key
    iv = Base64.encode64(cipher.random_iv)
    crypt = cipher.update(document.to_s) + cipher.final
    ciphertext = (Base64.encode64(crypt))
    JSON.generate([iv, ciphertext])
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
    cipher.iv = Base64.decode64(iv)
    tempkey = Base64.decode64(msg)
    crypt = cipher.update(tempkey)
    crypt << cipher.final
  end

  def self.random_key
    OpenSSL::Cipher.new(ALGORITHM).encrypt.random_key
  end
end
