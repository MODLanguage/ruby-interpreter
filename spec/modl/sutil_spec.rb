# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright (c) 2019 NUM Technology Ltd
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'modl/parser/ref_processor'

RSpec.describe MODL::Parser do
  it "can run Sutil.after correctly" do
    expect(Sutil.after(nil, nil)).to be(nil)
    expect(Sutil.after('test', nil)).to eq('test')
    expect(Sutil.after('test', '')).to eq('test')
    expect(Sutil.after('test', 'x')).to eq('')
    expect(Sutil.after('test', 't')).to eq('est')
    expect(Sutil.after('test', 'te')).to eq('st')
    expect(Sutil.after('test', 'test')).to eq('')
    expect(Sutil.after('', '')).to eq('')
  end
  it "can run Sutil.between correctly" do
    expect(Sutil.between(nil, nil, nil)).to be(nil)
    expect(Sutil.between('', nil, nil)).to eq('')
    expect(Sutil.between('', nil, 'x')).to eq('')
    expect(Sutil.between('', '', '')).to eq('')
    expect(Sutil.between('', '', 'x')).to eq('')
    expect(Sutil.between('', 'x', '')).to eq('')
    expect(Sutil.between('', 'x', 'y')).to eq('')

    expect(Sutil.between('x', nil, nil)).to eq('x')
    expect(Sutil.between('x', nil, 'x')).to eq('x')
    expect(Sutil.between('x', '', '')).to eq('x')
    expect(Sutil.between('x', '', 'x')).to eq('x')
    expect(Sutil.between('x', 'x', '')).to eq('x')
    expect(Sutil.between('x', 'x', 'y')).to eq('x')

    expect(Sutil.between('xy', nil, nil)).to eq('xy')
    expect(Sutil.between('xy', nil, 'x')).to eq('xy')
    expect(Sutil.between('xy', '', '')).to eq('xy')
    expect(Sutil.between('xy', '', 'x')).to eq('xy')
    expect(Sutil.between('xy', 'x', '')).to eq('xy')
    expect(Sutil.between('xy', 'x', 'y')).to eq('xy')

    expect(Sutil.between('yx', nil, nil)).to eq('yx')
    expect(Sutil.between('yx', nil, 'x')).to eq('yx')
    expect(Sutil.between('yx', '', '')).to eq('yx')
    expect(Sutil.between('yx', '', 'x')).to eq('yx')
    expect(Sutil.between('yx', 'x', '')).to eq('yx')
    expect(Sutil.between('yx', 'x', 'y')).to eq('yx')

    expect(Sutil.between('xyz', nil, nil)).to eq('xyz')
    expect(Sutil.between('xyz', nil, 'x')).to eq('xyz')
    expect(Sutil.between('xyz', '', '')).to eq('xyz')
    expect(Sutil.between('xyz', '', 'x')).to eq('xyz')
    expect(Sutil.between('xyz', 'x', '')).to eq('xyz')
    expect(Sutil.between('xyz', 'x', 'z')).to eq('y')

    expect(Sutil.between('zyx', nil, nil)).to eq('zyx')
    expect(Sutil.between('zyx', nil, 'x')).to eq('zyx')
    expect(Sutil.between('zyx', '', '')).to eq('zyx')
    expect(Sutil.between('zyx', '', 'x')).to eq('zyx')
    expect(Sutil.between('zyx', 'x', '')).to eq('zyx')
    expect(Sutil.between('zyx', 'x', 'z')).to eq('y')

    expect(Sutil.between('zyxz', 'z', 'z')).to eq('yx')

  end
  it "can run Sutil.head correctly" do
    expect(Sutil.head(nil)).to be(nil)
    expect(Sutil.head('')).to eq(nil)
    expect(Sutil.head('x')).to eq('')
    expect(Sutil.head('xy')).to eq('x')
    expect(Sutil.head('xyz')).to eq('xy')

    expect(Sutil.head('', -2)).to eq(nil)
    expect(Sutil.head('', 0)).to eq('')
    expect(Sutil.head('', 2)).to eq('')
    expect(Sutil.head('x', -2)).to eq(nil)
    expect(Sutil.head('x', 0)).to eq('')
    expect(Sutil.head('x', 2)).to eq('x')
    expect(Sutil.head('xy', -2)).to eq(nil)
    expect(Sutil.head('xy', 0)).to eq('')
    expect(Sutil.head('xy', 2)).to eq('xy')
    expect(Sutil.head('xyz', -2)).to eq(nil)
    expect(Sutil.head('xyz', 0)).to eq('')
    expect(Sutil.head('xyz', 2)).to eq('xy')
    expect(Sutil.head('xyz', -1)).to eq(nil)
    expect(Sutil.head('xyz', 0)).to eq('')
    expect(Sutil.head('xyz', 1)).to eq('x')

  end
  it "can run Sutil.replace correctly" do
    expect(Sutil.replace(nil, nil, nil)).to be(nil)
    expect(Sutil.replace('abc', nil, nil)).to eq('abc')
    expect(Sutil.replace('abc', 'def', nil)).to eq('abc')
    expect(Sutil.replace('abc', 'def', 'ghi')).to eq('abc')
    expect(Sutil.replace('abc', 'def', 'def')).to eq('abc')
    expect(Sutil.replace('abc', 'abc', 'def')).to eq('def')
    expect(Sutil.replace('abcabcabc', 'abc', 'def')).to eq('defdefdef')
    expect(Sutil.replace('abcabcabc', '', '')).to eq('abcabcabc')
    expect(Sutil.replace('abcabcabc', '', 'def')).to eq('abcabcabc')
    expect(Sutil.replace('abcabcabc', 'abc', '')).to eq('')
    expect(Sutil.replace('`e1afmkfd`.p', '`', '')).to eq('e1afmkfd.p')
  end
  it "can run Sutil.tail correctly" do
    expect(Sutil.tail(nil)).to be(nil)
    expect(Sutil.tail('')).to eq(nil)
    expect(Sutil.tail('x')).to eq('')
    expect(Sutil.tail('xy')).to eq('y')
    expect(Sutil.tail('xyz')).to eq('yz')

    expect(Sutil.tail('', -2)).to eq(nil)
    expect(Sutil.tail('', 0)).to eq('')
    expect(Sutil.tail('', 2)).to eq(nil)
    expect(Sutil.tail('x', -2)).to eq(nil)
    expect(Sutil.tail('x', 0)).to eq('x')
    expect(Sutil.tail('x', 2)).to eq(nil)
    expect(Sutil.tail('xy', -2)).to eq(nil)
    expect(Sutil.tail('xy', 0)).to eq('xy')
    expect(Sutil.tail('xy', 2)).to eq('')
    expect(Sutil.tail('xyz', -2)).to eq(nil)
    expect(Sutil.tail('xyz', 0)).to eq('xyz')
    expect(Sutil.tail('xyz', 2)).to eq('z')
    expect(Sutil.tail('xyz', -1)).to eq(nil)
    expect(Sutil.tail('xyz', 0)).to eq('xyz')
    expect(Sutil.tail('xyz', 1)).to eq('yz')
  end
  it "can run Sutil.toptail correctly" do
    expect(Sutil.toptail(nil)).to be(nil)
    expect(Sutil.toptail('')).to eq('')
    expect(Sutil.toptail('a')).to eq('')
    expect(Sutil.toptail('ab')).to eq('')
    expect(Sutil.toptail('abc')).to eq('b')
    expect(Sutil.toptail('abcd')).to eq('bc')
  end
  it "can run Sutil.until correctly" do
    expect(Sutil.until(nil, nil)).to be(nil)
    expect(Sutil.until('test', nil)).to eq('test')
    expect(Sutil.until('test', '')).to eq('test')
    expect(Sutil.until('test', 'x')).to eq('test')
    expect(Sutil.until('test', 't')).to eq('')
    expect(Sutil.until('test', 'st')).to eq('te')
    expect(Sutil.until('test', 'test')).to eq('')
    expect(Sutil.until('', '')).to eq('')
    expect(Sutil.until('the end', 'end')).to eq('the ')
  end
end
