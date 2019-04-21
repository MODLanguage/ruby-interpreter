# frozen_string_literal: true

module Sutil
  # Remove the first n characters from a string
  def self.tail(str, n = 1)
    return if n.negative?

    str&.slice(n, str.length)
  end

  # Keep the first n characters of a string
  def self.head(str, n = nil)
    return if str.nil?

    n = str.length - 1 if n.nil? # Strip last char by default

    str&.slice(0, n)
  end

  # Keep everything until char c
  def self.until(str, c)
    return str if c.nil? || c.empty?

    i = str.index(c)
    i ? str&.slice(0, i) : str
  end

  # Get everything after char c
  def self.after(str, c)
    return if str.nil?
    return str if c.nil?

    i = str.index(c)
    return '' if i.nil?

    str.slice(i + c.length, str.length)
  end

  # Get everything between ch1 and ch2
  # ch1 and ch2 must be different and ch1 must be before ch2 in the string
  # e.g. Sutil.between('func(p1,p2)', '(', ')') returns 'p1,p2'
  def self.between(str, ch1, ch2)
    return if str.nil?
    return str if ch1.nil? || ch2.nil? || ch1 == '' || ch2 == ''
    return str if str.length < 3

    first = str.index(ch1)
    second = str.rindex(ch2)
    if first > second
      tmp = first
      first = second
      second = tmp
    end
    return str if first == second

    str.slice(first + 1, second - first - 1)
  end

  # Remove the first and last chars from a string.
  def self.toptail(str)
    return str if str.nil?
    return '' if str.length < 3

    str&.slice(1, str.length - 2)
  end

  def self.replace(str, old, new)
    return str if old.nil? || new.nil? || old.empty? || old == new

    result = str
    loop do
      break unless result.include?(old)

      result = result.sub(old, new)
    end
    result
  end
end
