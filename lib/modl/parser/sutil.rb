module Sutil

  # Remove the first n characters from a string
  def self.trail(str, n = 1)
    str&.slice(n, str.length)
  end

  # Keep the first n characters of a string
  def self.head(str, n = nil)
    n = str.length - 1 if n.nil? # Strip last char by default

    str&.slice(0, n)
  end

  # Keep everyting until char c
  def self.until(str, c)
    i = str.index(c)
    i ? str&.slice(0, i) : str
  end

  # Get everything after char c
  def self.after(str, c)
    i = str.index(c)
    i ? str&.slice(i + 1, str.length) : str
  end

  # Get everything between ch1 and ch2
  # ch1 and ch2 must be different and ch1 must be before ch2 in the string
  # e.g. Sutil.between('func(p1,p2)', '(', ')') returns 'p1,p2'
  def self.between(str, ch1, ch2)
    first = str.index(ch1)
    second = str.index(ch2)
    str.slice(first + 1, second - first - 1)
  end

  # Remove the first and last chars from a string.
  def self.toptail(str)
    str.slice(1, str.length - 2) if str
  end
end
