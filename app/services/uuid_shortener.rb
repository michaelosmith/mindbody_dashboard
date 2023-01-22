module UuidShortener
  ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
  ALPHABET_HASH = ALPHABET.each_char.with_index.each_with_object({}) { |(k, v), h| h[k] = v; }
  BASE = ALPHABET.length

  class << self
    def shorten(uuid)
      num = uuid.tr('-', '').to_i(32)
      return '0' if num.zero?
      return nil if num.negative?

      str = ''
      while num.positive?
        str = ALPHABET[num % BASE] + str
        num /= BASE
      end
      str
    end

    def expand(suid)
      num = i = 0
      len = suid.length - 1
      while i < suid.length
        pow = BASE**(len - i)
        num += ALPHABET_HASH[suid[i]] * pow
        i += 1
      end
      num.to_s(32).rjust(32, '0').unpack('A8A4A4A4A12').join('-')
    end
  end
end